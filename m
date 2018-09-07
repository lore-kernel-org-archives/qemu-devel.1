Received: from eggs.gnu.org ([2001:4830:134:3::10]:32971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyLTH-0004gS-3m
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyLTC-0008FH-8O
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:27:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CGME20180831102306eucas1p1ffbf82383f23675fecb5faf8a2fa54d7@eucas1p1.samsung.com>
	<9310418.Wg32kryeWE@amdc3058>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f99f130-4be5-912f-329c-06666c929cd4@amsat.org>
Date: Fri, 7 Sep 2018 15:26:53 -0300
MIME-Version: 1.0
In-Reply-To: <9310418.Wg32kryeWE@amdc3058>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Lej4390D3rTTb9zfi0HhF3Wx0iDppecof"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/exynos4210: fix Exynos4210 UART
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Huth <thuth@redhat.com>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lej4390D3rTTb9zfi0HhF3Wx0iDppecof
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <4f99f130-4be5-912f-329c-06666c929cd4@amsat.org>
Subject: Re: [PATCH] hw/arm/exynos4210: fix Exynos4210 UART support
References: <CGME20180831102306eucas1p1ffbf82383f23675fecb5faf8a2fa54d7@eucas1p1.samsung.com>
 <9310418.Wg32kryeWE@amdc3058>
In-Reply-To: <9310418.Wg32kryeWE@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/31/18 7:23 AM, Bartlomiej Zolnierkiewicz wrote:
> commit 97274d0c05d4 ("hw/char/exynos4210_uart.c: Remove unneeded
> handling of NULL chardev") broke Exynos4210 support as it removed
> NULL 'Chardev *chr' handling from exynos4210_uart_create() and
> currently exynos4210_init() always passes NULL as 'Chardev *chr'
> argument to exynos4210_uart_create() calls. Fix it by adding
> missing serial_hd() calls to exynos4210_init().
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/arm/exynos4210.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> Index: b/hw/arm/exynos4210.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/hw/arm/exynos4210.c	2018-08-22 12:21:06.328813907 +0200
> +++ b/hw/arm/exynos4210.c	2018-08-22 13:00:54.344771039 +0200
> @@ -352,19 +352,19 @@ Exynos4210State *exynos4210_init(MemoryR
> =20
>      /*** UARTs ***/
>      exynos4210_uart_create(EXYNOS4210_UART0_BASE_ADDR,
> -                           EXYNOS4210_UART0_FIFO_SIZE, 0, NULL,
> +                           EXYNOS4210_UART0_FIFO_SIZE, 0, serial_hd(0)=
,
>                    s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_=
GRP, 0)]);
> =20
>      exynos4210_uart_create(EXYNOS4210_UART1_BASE_ADDR,
> -                           EXYNOS4210_UART1_FIFO_SIZE, 1, NULL,
> +                           EXYNOS4210_UART1_FIFO_SIZE, 1, serial_hd(1)=
,
>                    s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_=
GRP, 1)]);
> =20
>      exynos4210_uart_create(EXYNOS4210_UART2_BASE_ADDR,
> -                           EXYNOS4210_UART2_FIFO_SIZE, 2, NULL,
> +                           EXYNOS4210_UART2_FIFO_SIZE, 2, serial_hd(2)=
,
>                    s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_=
GRP, 2)]);
> =20
>      exynos4210_uart_create(EXYNOS4210_UART3_BASE_ADDR,
> -                           EXYNOS4210_UART3_FIFO_SIZE, 3, NULL,
> +                           EXYNOS4210_UART3_FIFO_SIZE, 3, serial_hd(3)=
,
>                    s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_=
GRP, 3)]);
> =20
>      /*** SD/MMC host controllers ***/
>=20


--Lej4390D3rTTb9zfi0HhF3Wx0iDppecof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAluSwu8ACgkQ4+MsLN6t
wN6xARAAhy5RGV2BdAEH5o9rwzIqS4+ZoBgF1at6ySZacp49MfIBYwQLFNJTMGXv
gZwSWn5r9E+5C4sqWTB7EuRUcxIC/P3MiPtSyy95nzR2l5qK1ACyXSxDceqvCUID
WlOih9qcGYrSVBW0nY4JsnR5H4lFq7BJPgMtbK72df8jq84QQ08qYsi1CncFel4q
rLw5VyFmiJ/ujLjMGAXnNVu3iT3yhnraMRA8q0pCwzalgd+74lcy6ZyjcQ/KSi8y
pxf2euIW8nI6YI188Qk8tpeDOI56SUqEJctFY9DzdXPI2x+666BPBCOQhnmq/cXc
tDmqD/rtiTTze+WsSdxA6ijQsAK570EHC9dkhYpYxdeb6XSLY3vwovrDYGk48dxH
NVb5jlKhKDzVn6dARyqSFZ/y88wX7ke4uuVSQtWO6xdeNShfEueMzvY3lntNoBIb
NMfT0k76Uz/hzfMFdbXTWBAEukLSFDxpWPTPXPrKiSwTKqL7Rl3smLSwSkufZbgC
gMoQGAWkDM2P7W8MpcO3V4z5KMhA/b1VcXxTdG4g5qXFau1dc53gkLGQ82Ss21mi
clbo2tAs5+i68doZajeIDlfUWDQ59tCK/M9tn4Kj+OIXwN0bgJ58x9DGPxmeMO5T
JGTZQdJm0HLAjo/BJzkbYGKosK8UASFD1FKFiYOz5EB5YaBzuGM=
=R2jv
-----END PGP SIGNATURE-----

--Lej4390D3rTTb9zfi0HhF3Wx0iDppecof--
