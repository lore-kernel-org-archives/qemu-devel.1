Received: from eggs.gnu.org ([2001:4830:134:3::10]:36858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f2m4W-00035J-GY
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 19:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f2m4R-0004Ys-Ox
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 19:07:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <0dd4c8f5-d60e-e564-652f-cd0101f6ee68@web.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bf67848e-d6ea-1c23-0350-ba16e9674905@amsat.org>
Date: Sun, 1 Apr 2018 20:07:21 -0300
MIME-Version: 1.0
In-Reply-To: <0dd4c8f5-d60e-e564-652f-cd0101f6ee68@web.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Ibp6JaQbChb3lSPiKgTt6iRuLsFRmFOkm"
Subject: Re: [Qemu-devel] [PATCH] build: Silence dtc directory creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, qemu-trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ibp6JaQbChb3lSPiKgTt6iRuLsFRmFOkm
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Jan Kiszka <jan.kiszka@web.de>, qemu-trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <bf67848e-d6ea-1c23-0350-ba16e9674905@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] build: Silence dtc directory creation
References: <0dd4c8f5-d60e-e564-652f-cd0101f6ee68@web.de>
In-Reply-To: <0dd4c8f5-d60e-e564-652f-cd0101f6ee68@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2018 08:23 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Align with other mkdir calls.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 727ef118f3..fc6f21001f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -485,7 +485,7 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/te=
sts
>  	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS=3D"$(DTC_CPPFL=
AGS)" CFLAGS=3D"$(DTC_CFLAGS)" LDFLAGS=3D"$(LDFLAGS)" ARFLAGS=3D"$(ARFLAG=
S)" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/lib=
fdt.a,)
> =20
>  dtc/%: .git-submodule-status
> -	mkdir -p $@
> +	@mkdir -p $@
> =20
>  # Overriding CFLAGS causes us to lose defines added in the sub-makefil=
e.
>  # Not overriding CFLAGS leads to mis-matches between compilation modes=
=2E
>=20


--Ibp6JaQbChb3lSPiKgTt6iRuLsFRmFOkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrBZi0ACgkQ4+MsLN6t
wN5NRw/7BL+zqobas2+aA4X5OQOT3A6p23YS0LnJjBy63I63Rhyr1QwRaGaepai/
ji24OYdGhP2nkASW270AjMWAN6XbI/0BVCOIaPBC4hQFBWFn09/sRhiFEtk7l4Gu
RZ7DmBSpzM8F0BjnB3xr7RnUmdzOwmzVMHz/VEKZo58yf+PjiZrrsBfTm7sbBqYu
XcAG8foLYVVZRrFs7OlIN8MF/qYuQ4oNh5SqSFDA6vVdt7shVBFkXiUvscDWU9Zv
AVOBr77//NOoRhWvstenfeG1ZKMFMZJ8WoNea8TZFGX281qOUWwau31+B2ceSgtP
RMiK5kgOFEDVk++GMbLMo4mfBBUMQBftFpDW8OobIBNQ2+DOiSCwr35Eu1/X3vRW
aAS8mEfM4Ldj+KsGU0HRZodtZ1XWMoIk7NmHO9E68tAK6ZNg7Ao6LEHxl5XQLN6j
BvchYY4S6dT8OsmlSnip8AvrCO3/v3s5ebyRl4XW4MTvNT4FzIgQpwqmUsS/KT8j
NlGpX5xzl/xwHOI4GIMVZ+Wj4LZLVnyyOMMdZfscaYoeXpWAJMoOF5FpHUSdQsAx
HTreE7CKL+ml/y2Blt+OZB8Lz+VJdMQEonn67PibS/Ur2GMwD1VRk9kQ5sVgPraz
vSGSV4vfIG8lHSvudAM4kc9QfTok+CBipnJ8iZDPszz19dClRfs=
=RzaJ
-----END PGP SIGNATURE-----

--Ibp6JaQbChb3lSPiKgTt6iRuLsFRmFOkm--
