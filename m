Received: from eggs.gnu.org ([209.51.188.92]:50205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLryh-00036c-Qj
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLryc-0007Jy-Pe
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:21:03 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLryc-0007GV-Hg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:20:58 -0400
Received: by mail-io1-xd43.google.com with SMTP id r71so15184834iod.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:20:58 -0700 (PDT)
Date: Wed, 1 May 2019 12:20:55 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190501162055.GB21155@stefanha-x1.localdomain>
References: <20190425145420.8888-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20190425145420.8888-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 03:54:20PM +0100, Stefan Hajnoczi wrote:
> qemu.org hosts git repository mirrors of all submodules.  Update
> .gitmodules to use the mirrors and not the upstream repositories.
>=20
> Mirroring upstream repositories ensures that QEMU continues to build
> even when upstream repositories are deleted or temporarily offline.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  .gitmodules | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Ping?

> diff --git a/.gitmodules b/.gitmodules
> index aa77ce6f50..2857eec763 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -39,19 +39,19 @@
>  	url =3D https://git.qemu.org/git/capstone.git
>  [submodule "roms/seabios-hppa"]
>  	path =3D roms/seabios-hppa
> -	url =3D https://github.com/hdeller/seabios-hppa.git
> +	url =3D https://git.qemu.org/git/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>  	path =3D roms/u-boot-sam460ex
>  	url =3D https://git.qemu.org/git/u-boot-sam460ex.git
>  [submodule "tests/fp/berkeley-testfloat-3"]
>  	path =3D tests/fp/berkeley-testfloat-3
> -	url =3D https://github.com/cota/berkeley-testfloat-3
> +	url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
>  [submodule "tests/fp/berkeley-softfloat-3"]
>  	path =3D tests/fp/berkeley-softfloat-3
> -	url =3D https://github.com/cota/berkeley-softfloat-3
> +	url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
>  [submodule "roms/edk2"]
>  	path =3D roms/edk2
> -	url =3D https://github.com/tianocore/edk2.git
> +	url =3D https://git.qemu.org/git/edk2.git
>  [submodule "slirp"]
>  	path =3D slirp
> -	url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
> +	url =3D https://git.qemu.org/git/libslirp.git
> --=20
> 2.20.1
>=20
>=20

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJx2cACgkQnKSrs4Gr
c8gBsgf9ErX/MtiUX4hHocugweplU4E60EozRdVwKO+Uyv3Phy93+Xr7QoPF60Ti
AgdBNmaGalaqvVl3FXOW+kIDYvRPBkTMS0GJFM+jn5cl0pJLBSWVGjzSTK1FMLek
SZMAkaUD/l/wxQQRo/ewNwyyfE3hA1hA1yPU2psStnRMmWQio/criZLYcVQZabRP
rA1WGbCW69JvPFgKlGZUvyw++VQqmdCBtuYQKODVkbEdqO46VW44KLcr4APeC7xC
DjhZ9LSnilaZphY1To0qPHI1vDProyKYhN7iGUvR+4BRVaQdsS3PgvmbYfaYAaA1
AyLgo2CbH68TDjlX0R0rR9EfoJ67Mw==
=hjtO
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
