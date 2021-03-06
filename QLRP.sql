USE [master]
GO
/****** Object:  Database [QLRP]    Script Date: 10/10/2021 9:40:54 PM ******/
CREATE DATABASE [QLRP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLRP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\QLRP.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLRP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\QLRP_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QLRP] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLRP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLRP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLRP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLRP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLRP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLRP] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLRP] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLRP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLRP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLRP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLRP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLRP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLRP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLRP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLRP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLRP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLRP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLRP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLRP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLRP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLRP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLRP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLRP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLRP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLRP] SET  MULTI_USER 
GO
ALTER DATABASE [QLRP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLRP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLRP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLRP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLRP] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLRP] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QLRP] SET QUERY_STORE = OFF
GO
USE [QLRP]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[DinhDangPhim]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DinhDangPhim](
	[id] [varchar](50) NOT NULL,
	[idPhim] [varchar](50) NOT NULL,
	[idLoaiManHinh] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[id] [varchar](50) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SDT] [varchar](100) NULL,
	[CMND] [int] NOT NULL,
	[DiemTichLuy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CMND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichChieu]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichChieu](
	[id] [varchar](50) NOT NULL,
	[ThoiGianChieu] [datetime] NOT NULL,
	[idPhong] [varchar](50) NOT NULL,
	[idDinhDang] [varchar](50) NOT NULL,
	[GiaVe] [money] NOT NULL,
	[TrangThai] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiManHinh]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiManHinh](
	[id] [varchar](50) NOT NULL,
	[TenMH] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[id] [varchar](50) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SDT] [varchar](100) NULL,
	[CMND] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CMND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhanLoaiPhim]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanLoaiPhim](
	[idPhim] [varchar](50) NOT NULL,
	[idTheLoai] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PhanLoaiPhim] PRIMARY KEY CLUSTERED 
(
	[idPhim] ASC,
	[idTheLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phim]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phim](
	[id] [varchar](50) NOT NULL,
	[TenPhim] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](1000) NULL,
	[ThoiLuong] [float] NOT NULL,
	[NgayKhoiChieu] [date] NOT NULL,
	[NgayKetThuc] [date] NOT NULL,
	[SanXuat] [nvarchar](50) NOT NULL,
	[DaoDien] [nvarchar](100) NULL,
	[NamSX] [int] NOT NULL,
	[Image] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongChieu]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongChieu](
	[id] [varchar](50) NOT NULL,
	[TenPhong] [nvarchar](100) NOT NULL,
	[idManHinh] [varchar](50) NULL,
	[SoChoNgoi] [int] NOT NULL,
	[TinhTrang] [int] NOT NULL,
	[SoHangGhe] [int] NOT NULL,
	[SoGheMotHang] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[UserName] [nvarchar](100) NOT NULL,
	[Pass] [varchar](1000) NOT NULL,
	[LoaiTK] [int] NOT NULL,
	[idNV] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheLoai]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheLoai](
	[id] [varchar](50) NOT NULL,
	[TenTheLoai] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ve]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ve](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LoaiVe] [int] NULL,
	[idLichChieu] [varchar](50) NULL,
	[MaGheNgoi] [varchar](50) NULL,
	[idKhachHang] [varchar](50) NULL,
	[TrangThai] [int] NOT NULL,
	[TienBanVe] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LichChieu] ADD  DEFAULT ('0') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhongChieu] ADD  DEFAULT ((1)) FOR [TinhTrang]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ((2)) FOR [LoaiTK]
GO
ALTER TABLE [dbo].[Ve] ADD  DEFAULT ('0') FOR [LoaiVe]
GO
ALTER TABLE [dbo].[Ve] ADD  DEFAULT ('0') FOR [TrangThai]
GO
ALTER TABLE [dbo].[Ve] ADD  DEFAULT ('0') FOR [TienBanVe]
GO
ALTER TABLE [dbo].[DinhDangPhim]  WITH CHECK ADD FOREIGN KEY([idLoaiManHinh])
REFERENCES [dbo].[LoaiManHinh] ([id])
GO
ALTER TABLE [dbo].[DinhDangPhim]  WITH CHECK ADD FOREIGN KEY([idPhim])
REFERENCES [dbo].[Phim] ([id])
GO
ALTER TABLE [dbo].[LichChieu]  WITH CHECK ADD FOREIGN KEY([idDinhDang])
REFERENCES [dbo].[DinhDangPhim] ([id])
GO
ALTER TABLE [dbo].[LichChieu]  WITH CHECK ADD FOREIGN KEY([idPhong])
REFERENCES [dbo].[PhongChieu] ([id])
GO
ALTER TABLE [dbo].[PhanLoaiPhim]  WITH CHECK ADD FOREIGN KEY([idPhim])
REFERENCES [dbo].[Phim] ([id])
GO
ALTER TABLE [dbo].[PhanLoaiPhim]  WITH CHECK ADD FOREIGN KEY([idTheLoai])
REFERENCES [dbo].[TheLoai] ([id])
GO
ALTER TABLE [dbo].[PhongChieu]  WITH CHECK ADD FOREIGN KEY([idManHinh])
REFERENCES [dbo].[LoaiManHinh] ([id])
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD FOREIGN KEY([idNV])
REFERENCES [dbo].[NhanVien] ([id])
GO
ALTER TABLE [dbo].[Ve]  WITH CHECK ADD FOREIGN KEY([idKhachHang])
REFERENCES [dbo].[KhachHang] ([id])
GO
ALTER TABLE [dbo].[Ve]  WITH CHECK ADD FOREIGN KEY([idLichChieu])
REFERENCES [dbo].[LichChieu] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteTicketsByShowTimes]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_DeleteTicketsByShowTimes]
@idlichChieu VARCHAR(50)
AS
BEGIN
	DELETE FROM dbo.Ve
	WHERE idLichChieu = @idlichChieu
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountList]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--TÀI KHOẢN (frmAdmin)
CREATE PROC [dbo].[USP_GetAccountList]
AS
BEGIN
	SELECT TK.UserName AS [Username], TK.LoaiTK AS [Loại tài khoản], NV.id AS [Mã nhân viên], NV.HoTen AS [Tên nhân viên]
	FROM dbo.TaiKhoan TK, dbo.NhanVien NV
	WHERE NV.id = TK.idNV
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllListShowTimes]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAllListShowTimes]
AS
BEGIN
	select l.id, pc.TenPhong, p.TenPhim, l.ThoiGianChieu, d.id as idDinhDang, l.GiaVe, l.TrangThai
	from Phim p ,DinhDangPhim d, LichChieu l, PhongChieu pc
	where p.id = d.idPhim and d.id = l.idDinhDang and l.idPhong = pc.id
	order by l.ThoiGianChieu
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetCinema]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--PHÒNG CHIẾU
CREATE PROC [dbo].[USP_GetCinema]
AS
BEGIN
	SELECT PC.id AS [Mã phòng], TenPhong AS [Tên phòng], TenMH AS [Tên màn hình], PC.SoChoNgoi AS [Số chỗ ngồi], PC.TinhTrang AS [Tình trạng], PC.SoHangGhe AS [Số hàng ghế], PC.SoGheMotHang AS [Ghế mỗi hàng]
	FROM dbo.PhongChieu AS PC, dbo.LoaiManHinh AS MH
	WHERE PC.idManHinh = MH.id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetCustomer]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--KHÁCH HÀNG
CREATE PROC [dbo].[USP_GetCustomer]
AS
BEGIN
	SELECT id AS [Mã khách hàng], HoTen AS [Họ tên], NgaySinh AS [Ngày sinh], DiaChi AS [Địa chỉ], SDT AS [SĐT], CMND AS [CMND], DiemTichLuy AS [Điểm tích lũy]
	FROM dbo.KhachHang
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListFormatMovie]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--ĐỊNH DẠNG PHIM
CREATE PROC [dbo].[USP_GetListFormatMovie]
AS
BEGIN
	SELECT DD.id AS [Mã định dạng], P.id AS [Mã phim], P.TenPhim AS [Tên phim], MH.id AS [Mã MH], MH.TenMH AS [Tên MH]
	FROM dbo.DinhDangPhim DD, Phim P, dbo.LoaiManHinh MH
	WHERE DD.idPhim = P.id AND DD.idLoaiManHinh = MH.id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListGenreByMovie]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListGenreByMovie]
@idPhim VARCHAR(50)
AS
BEGIN
	SELECT TL.id, TenTheLoai, TL.MoTa
	FROM dbo.PhanLoaiPhim PL, dbo.TheLoai TL
	WHERE idPhim = @idPhim AND PL.idTheLoai = TL.id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListShowTimesByFormatMovie]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--LỊCH CHIẾU
CREATE PROC [dbo].[USP_GetListShowTimesByFormatMovie]
@ID varchar(50), @Date Datetime
AS
BEGIN
	select l.id, pc.TenPhong, p.TenPhim, l.ThoiGianChieu, d.id as idDinhDang, l.GiaVe, l.TrangThai
	from Phim p ,DinhDangPhim d, LichChieu l, PhongChieu pc
	where p.id = d.idPhim and d.id = l.idDinhDang and l.idPhong = pc.id
	and d.id = @ID and CONVERT(DATE, @Date) = CONVERT(DATE, l.ThoiGianChieu)
	order by l.ThoiGianChieu
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListShowTimesNotCreateTickets]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListShowTimesNotCreateTickets]
AS
BEGIN
	select l.id, pc.TenPhong, p.TenPhim, l.ThoiGianChieu, d.id as idDinhDang, l.GiaVe, l.TrangThai
	from Phim p ,DinhDangPhim d, LichChieu l, PhongChieu pc
	where p.id = d.idPhim and d.id = l.idDinhDang and l.idPhong = pc.id and l.TrangThai = 0
	order by l.ThoiGianChieu
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetMovie]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--PHIM
CREATE PROC [dbo].[USP_GetMovie]
AS
BEGIN
	SELECT id AS [Mã phim], TenPhim AS [Tên phim], MoTa AS [Mô tả], ThoiLuong AS [Thời lượng], NgayKhoiChieu AS [Ngày khởi chiếu], NgayKetThuc AS [Ngày kết thúc], SanXuat AS [Sản xuất], DaoDien AS [Đạo diễn], NamSX AS [Năm SX], ApPhich AS [Áp Phích]
	FROM dbo.Phim
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetReportRevenueByMovieAndDate]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetReportRevenueByMovieAndDate]
@idMovie VARCHAR(50), @fromDate date, @toDate date
AS
BEGIN
	SELECT P.TenPhim, CONVERT(DATE, LC.ThoiGianChieu) AS NgayChieu, CONVERT(TIME(0),LC.ThoiGianChieu) AS GioChieu, COUNT(V.id) AS SoVeDaBan, SUM(TienBanVe) AS TienBanVe
	FROM dbo.Ve AS V, dbo.LichChieu AS LC, dbo.DinhDangPhim AS DDP, Phim AS P
	WHERE V.idLichChieu = LC.id AND LC.idDinhDang = DDP.id AND DDP.idPhim = P.id AND V.TrangThai = 1 AND P.id = @idMovie AND LC.ThoiGianChieu >= @fromDate AND LC.ThoiGianChieu <= @toDate
	GROUP BY idLichChieu, P.TenPhim, LC.ThoiGianChieu
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetRevenueByMovieAndDate]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--DOANH THU
CREATE PROC [dbo].[USP_GetRevenueByMovieAndDate]
@idMovie VARCHAR(50), @fromDate date, @toDate date
AS
BEGIN
	SELECT P.TenPhim AS [Tên phim], CONVERT(DATE, LC.ThoiGianChieu) AS [Ngày chiếu], CONVERT(TIME(0),LC.ThoiGianChieu) AS [Giờ chiếu], COUNT(V.id) AS [Số vé đã bán], SUM(TienBanVe) AS [Tiền vé]
	FROM dbo.Ve AS V, dbo.LichChieu AS LC, dbo.DinhDangPhim AS DDP, Phim AS P
	WHERE V.idLichChieu = LC.id AND LC.idDinhDang = DDP.id AND DDP.idPhim = P.id AND V.TrangThai = 1 AND P.id = @idMovie AND LC.ThoiGianChieu >= @fromDate AND LC.ThoiGianChieu <= @toDate
	GROUP BY idLichChieu, P.TenPhim, LC.ThoiGianChieu
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetShowtime]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetShowtime]
AS
BEGIN
	SELECT LC.id AS [Mã lịch chiếu], LC.idPhong AS [Mã phòng], P.TenPhim AS [Tên phim], MH.TenMH AS [Màn hình], LC.ThoiGianChieu AS [Thời gian chiếu], LC.GiaVe AS [Giá vé]
	FROM dbo.LichChieu AS LC, dbo.DinhDangPhim AS DD, Phim AS P, dbo.LoaiManHinh AS MH
	WHERE LC.idDinhDang = DD.id AND DD.idPhim = P.id AND DD.idLoaiManHinh = MH.id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetStaff]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--NHÂN VIÊN
CREATE PROC [dbo].[USP_GetStaff]
AS
BEGIN
	SELECT id AS [Mã nhân viên], HoTen AS [Họ tên], NgaySinh AS [Ngày sinh], DiaChi AS [Địa chỉ], SDT AS [SĐT], CMND AS [CMND]
	FROM dbo.NhanVien
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertAccount]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertAccount]
@username NVARCHAR(100), @loaiTK INT, @idnv VARCHAR(50)
AS
BEGIN
	INSERT dbo.TaiKhoan ( UserName, Pass, LoaiTK, idNV )
	VALUES ( @username, '5512317111114510840231031535810616566202691', @loaiTK, @idnv )
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertCinema]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertCinema]
@idCinema VARCHAR(50), @tenPhong NVARCHAR(100), @idMH VARCHAR(50), @soChoNgoi INT, @tinhTrang INT, @soHangGhe INT, @soGheMotHang INT
AS
BEGIN
	INSERT dbo.PhongChieu ( id , TenPhong , idManHinh , SoChoNgoi , TinhTrang , SoHangGhe , SoGheMotHang)
	VALUES (@idCinema , @tenPhong , @idMH , @soChoNgoi , @tinhTrang , @soHangGhe , @soGheMotHang)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertCustomer]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertCustomer]
@idCus VARCHAR(50), @hoTen NVARCHAR(100), @ngaySinh date, @diaChi NVARCHAR(100), @sdt VARCHAR(100), @cmnd INT
AS
BEGIN
	INSERT dbo.KhachHang (id, HoTen, NgaySinh, DiaChi, SDT, CMND, DiemTichLuy)
	VALUES (@idCus, @hoTen, @ngaySinh, @diaChi, @sdt, @cmnd, 0)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertFormatMovie]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertFormatMovie]
@id VARCHAR(50), @idPhim VARCHAR(50), @idLoaiManHinh VARCHAR(50)
AS
BEGIN
	INSERT dbo.DinhDangPhim ( id, idPhim, idLoaiManHinh )
	VALUES  ( @id, @idPhim, @idLoaiManHinh )
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertGenre]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--THỂ LOẠI
CREATE PROC [dbo].[USP_InsertGenre]
@idGenre VARCHAR(50), @ten NVARCHAR(100), @moTa NVARCHAR(100)
AS
BEGIN
	INSERT dbo.TheLoai (id, TenTheLoai, MoTa)
	VALUES  (@idGenre, @ten, @moTa)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertMovie]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertMovie]
@id VARCHAR(50), @tenPhim NVARCHAR(100), @moTa NVARCHAR(1000), @thoiLuong FLOAT, @ngayKhoiChieu DATE, @ngayKetThuc DATE, @sanXuat NVARCHAR(50), @daoDien NVARCHAR(100), @namSX INT, @apPhich IMAGE
AS
BEGIN
	INSERT dbo.Phim (id , TenPhim , MoTa , ThoiLuong , NgayKhoiChieu , NgayKetThuc , SanXuat , DaoDien , NamSX, ApPhich)
	VALUES (@id , @tenPhim , @moTa , @thoiLuong , @ngayKhoiChieu , @ngayKetThuc , @sanXuat , @daoDien , @namSX, @apPhich)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertScreenType]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--LOẠI MÀN HÌNH
CREATE PROC [dbo].[USP_InsertScreenType]
@idScreenType VARCHAR(50), @ten NVARCHAR(100)
AS
BEGIN
	INSERT dbo.LoaiManHinh ( id, TenMH )
	VALUES  (@idScreenType, @ten)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertShowtime]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertShowtime]
@id VARCHAR(50), @idPhong VARCHAR(50), @idDinhDang VARCHAR(50), @thoiGianChieu DATETIME, @giaVe FLOAT
AS
BEGIN
	INSERT dbo.LichChieu ( id , idPhong , idDinhDang, ThoiGianChieu  , GiaVe , TrangThai )
	VALUES  ( @id , @idPhong , @idDinhDang, @thoiGianChieu  , @giaVe , 0 )
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertStaff]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertStaff]
@idStaff VARCHAR(50), @hoTen NVARCHAR(100), @ngaySinh date, @diaChi NVARCHAR(100), @sdt VARCHAR(100), @cmnd INT
AS
BEGIN
	INSERT dbo.NhanVien (id, HoTen, NgaySinh, DiaChi, SDT, CMND)
	VALUES (@idStaff, @hoTen, @ngaySinh, @diaChi, @sdt, @cmnd)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertTicketByShowTimes]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--VÉ
CREATE PROC [dbo].[USP_InsertTicketByShowTimes]
@idlichChieu VARCHAR(50), @maGheNgoi VARCHAR(50)
AS
BEGIN
	INSERT INTO dbo.Ve
	(
		idLichChieu,
		MaGheNgoi,
		idKhachHang
	)
	VALUES
	(
		@idlichChieu,
		@maGheNgoi,
		NULL
	)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_Login]
@userName NVARCHAR(1000), @pass VARCHAR(1000)
AS
BEGIN
	SELECT * FROM dbo.TaiKhoan WHERE UserName = @userName AND Pass = @pass
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ResetPasswordtAccount]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_ResetPasswordtAccount]
@username NVARCHAR(100)
AS
BEGIN
	UPDATE dbo.TaiKhoan 
	SET Pass = '5512317111114510840231031535810616566202691' 
	WHERE UserName = @username
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchAccount]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SearchAccount]
@hoTen NVARCHAR(100)
AS
BEGIN
	SELECT TK.UserName AS [Username], TK.LoaiTK AS [Loại tài khoản], NV.id AS [Mã nhân viên], NV.HoTen AS [Tên nhân viên]
	FROM dbo.TaiKhoan TK, dbo.NhanVien NV
	WHERE NV.id = TK.idNV AND dbo.fuConvertToUnsign1(NV.HoTen) LIKE N'%' + dbo.fuConvertToUnsign1(@hoTen) + N'%'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchCustomer]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SearchCustomer]
@hoTen NVARCHAR(100)
AS
BEGIN
	SELECT id AS [Mã khách hàng], HoTen AS [Họ tên], NgaySinh AS [Ngày sinh], DiaChi AS [Địa chỉ], SDT AS [SĐT], CMND AS [CMND], DiemTichLuy AS [Điểm tích lũy]
	FROM dbo.KhachHang
	WHERE dbo.fuConvertToUnsign1(HoTen) LIKE N'%' + dbo.fuConvertToUnsign1(@hoTen) + N'%'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchShowtimeByMovieName]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SearchShowtimeByMovieName]
@tenPhim NVARCHAR(100)
AS
BEGIN
	SELECT LC.id AS [Mã lịch chiếu], LC.idPhong AS [Mã phòng], P.TenPhim AS [Tên phim], MH.TenMH AS [Màn hình], LC.ThoiGianChieu AS [Thời gian chiếu], LC.GiaVe AS [Giá vé]
	FROM dbo.LichChieu AS LC, dbo.DinhDangPhim AS DD, Phim AS P, dbo.LoaiManHinh AS MH
	WHERE LC.idDinhDang = DD.id AND DD.idPhim = P.id AND DD.idLoaiManHinh = MH.id AND dbo.fuConvertToUnsign1(P.TenPhim) LIKE N'%' + dbo.fuConvertToUnsign1(@tenPhim) + N'%'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchStaff]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SearchStaff]
@hoTen NVARCHAR(100)
AS
BEGIN
	SELECT id AS [Mã nhân viên], HoTen AS [Họ tên], NgaySinh AS [Ngày sinh], DiaChi AS [Địa chỉ], SDT AS [SĐT], CMND AS [CMND]
	FROM dbo.NhanVien
	WHERE dbo.fuConvertToUnsign1(HoTen) LIKE N'%' + dbo.fuConvertToUnsign1(@hoTen) + N'%'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateAccount]
@username NVARCHAR(100), @loaiTK INT
AS
BEGIN
	UPDATE dbo.TaiKhoan 
	SET LoaiTK = @loaiTK
	WHERE UserName = @username
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateMovie]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateMovie]
@id VARCHAR(50), @tenPhim NVARCHAR(100), @moTa NVARCHAR(1000), @thoiLuong FLOAT, @ngayKhoiChieu DATE, @ngayKetThuc DATE, @sanXuat NVARCHAR(50), @daoDien NVARCHAR(100), @namSX INT , @apPhich IMAGE
AS
BEGIN
	UPDATE dbo.Phim SET TenPhim = @tenPhim, MoTa = @moTa, ThoiLuong = @thoiLuong, NgayKhoiChieu = @ngayKhoiChieu, NgayKetThuc = @ngayKetThuc, SanXuat = @sanXuat, DaoDien = @daoDien, NamSX = @namSX, ApPhich = @apPhich WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdatePasswordForAccount]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Stored Procedures
--TÀI KHOẢN (Đổi mật khẩu & đăng nhập)
CREATE PROC [dbo].[USP_UpdatePasswordForAccount]
@username NVARCHAR(100), @pass VARCHAR(1000), @newPass VARCHAR(1000)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	SELECT @isRightPass = COUNT(*) FROM dbo.TaiKhoan WHERE UserName = @username AND Pass = @pass

	IF (@isRightPass = 1)
	BEGIN
		UPDATE dbo.TaiKhoan SET Pass = @newPass WHERE UserName = @username
    END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateShowtime]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateShowtime]
@id VARCHAR(50), @idPhong VARCHAR(50), @idDinhDang VARCHAR(50), @thoiGianChieu DATETIME, @giaVe FLOAT
AS
BEGIN
	UPDATE dbo.LichChieu 
	SET idPhong = @idPhong, idDinhDang = @idDinhDang, ThoiGianChieu = @thoiGianChieu , GiaVe = @giaVe
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateStatusShowTimes]    Script Date: 10/10/2021 9:40:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateStatusShowTimes]
@idLichChieu NVARCHAR(50), @status int
AS
BEGIN
	UPDATE dbo.LichChieu
	SET TrangThai = @status
	WHERE id = @idLichChieu
END
GO
USE [master]
GO
ALTER DATABASE [QLRP] SET  READ_WRITE 
GO
