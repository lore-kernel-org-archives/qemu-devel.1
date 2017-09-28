Received: from eggs.gnu.org ([2001:4830:134:3::10]:60864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dxV43-0005Sy-2M
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dxV3x-00053I-0D
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:25:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dxV3w-00052v-NM
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:24:56 -0400
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-4-ehabkost@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <57b8fe55-6534-e27e-041b-5c9a6c16f7c6@redhat.com>
Date: Thu, 28 Sep 2017 11:24:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170927130339.21444-4-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="usrO79NXATIfvr5Ds71QLuhgQuVPb4dhs"
Subject: Re: [Qemu-devel] [PATCH 3/5] basevm: Call logging.basicConfig()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--usrO79NXATIfvr5Ds71QLuhgQuVPb4dhs
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <57b8fe55-6534-e27e-041b-5c9a6c16f7c6@redhat.com>
Subject: Re: [PATCH 3/5] basevm: Call logging.basicConfig()
References: <20170927130339.21444-1-ehabkost@redhat.com>
 <20170927130339.21444-4-ehabkost@redhat.com>
In-Reply-To: <20170927130339.21444-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 27.9.2017 v 15:03 Eduardo Habkost napsal(a):
> Just setting level=3DDEBUG when debug is enabled is not enough: we
> need to set up a log handler if we want debug messages generated
> using logging.getLogger(...).debug() to be printed.
>=20
> This was not a problem before because logging.debug() calls
> logging.basicConfig() implicitly, but it's safer to not rely on
> that.
>=20
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/vm/basevm.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 3c863bc237..686d88decf 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -227,8 +227,8 @@ def main(vmcls):
>          if not argv and not args.build_qemu and not args.build_image:
>              print "Nothing to do?"
>              return 1
> -        if args.debug:
> -            logging.getLogger().setLevel(logging.DEBUG)
> +        logging.basicConfig(level=3D(logging.DEBUG if args.debug
> +                                   else logging.WARN))
>          vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
>          if args.build_image:
>              if os.path.exists(args.image) and not args.force:
>=20

Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>


--usrO79NXATIfvr5Ds71QLuhgQuVPb4dhs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZzL/hExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGb
Kgf/XLQwnELuMUplNGubSSA0zU1F/+aLBfONaHDSZBCS7MERmP6le9hGF6Qn9Zwd
V/qQCIEb8f59D3un0oR51jzu91SULdN9bXq0Gd3yvLv/I/wiDzc2JmxdJASj2B4t
E5qkHuVw7ZCxGObxRWMsGF5z/VIIBZ3ZLrSg7QWruDwMRebq1LsOf4GCO1zcXIBM
LHFNpmHxm1cE9lOgqOUd9vIIESoOF/u77R1jgBL5lW141bvbTsxPyPXFk3cF2i2W
uE67jaHt+Wx6kXnnTt/NrWnJyRdLi1w3Q1TJQFLfQ0X0bgmJtcuGGhsxZHgaoRWH
VhqiGCDW0JnpsJZ/QE9ICGpfbA==
=8LF4
-----END PGP SIGNATURE-----

--usrO79NXATIfvr5Ds71QLuhgQuVPb4dhs--
