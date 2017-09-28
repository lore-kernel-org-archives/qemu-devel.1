Received: from eggs.gnu.org ([2001:4830:134:3::10]:54862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dxUb7-0003H4-63
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dxUb6-0003JO-6C
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:55:09 -0400
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-3-ehabkost@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <828133ca-fbb0-e9cf-fca8-65a59ff9ba90@redhat.com>
Date: Thu, 28 Sep 2017 10:54:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170927130339.21444-3-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x97MfmEV2Te1r8IpqL4aEX2ElkqGXKdek"
Subject: Re: [Qemu-devel] [PATCH 2/5] iotests: Set up Python logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x97MfmEV2Te1r8IpqL4aEX2ElkqGXKdek
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Message-ID: <828133ca-fbb0-e9cf-fca8-65a59ff9ba90@redhat.com>
Subject: Re: [PATCH 2/5] iotests: Set up Python logging
References: <20170927130339.21444-1-ehabkost@redhat.com>
 <20170927130339.21444-3-ehabkost@redhat.com>
In-Reply-To: <20170927130339.21444-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 27.9.2017 v 15:03 Eduardo Habkost napsal(a):
> Set up Python logging module instead of relying on
> QEMUMachine._debug to enable debugging messages.
>=20
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 1af117e37d..36a7757aaf 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -28,6 +28,7 @@ import qtest
>  import struct
>  import json
>  import signal
> +import logging
> =20
> =20
>  # This will not work if arguments contain spaces but is necessary if w=
e
> @@ -467,6 +468,8 @@ def main(supported_fmts=3D[], supported_oses=3D['li=
nux']):
>      else:
>          output =3D StringIO.StringIO()
> =20
> +    logging.basicConfig(level=3D(logging.DEBUG if debug else logging.W=
ARN))
> +

Strictly speaking the brackets around ternary operator are not necessary,=
 but given this is not a python project it's probably fine.

>      class MyTestRunner(unittest.TextTestRunner):
>          def __init__(self, stream=3Doutput, descriptions=3DTrue, verbo=
sity=3Dverbosity):
>              unittest.TextTestRunner.__init__(self, stream, description=
s, verbosity)
>=20

Yes, this is a better solution than the previous logging hotfix.

Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20


--x97MfmEV2Te1r8IpqL4aEX2ElkqGXKdek
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZzLjhExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsEm
WAf9GOmX7D42S0KrFV6QLPrIK1/8BKdN0J+g37JNDFd0H+6vjacFZNcYub/ybL7R
0wZYm42taMvQ5AEAkcyHarOLxHDsCd4uaIQfeVRafc6mUIjdI766daREn3aKT2xK
fgCPBUop3PbLTR/vlxYY8TIIrquEl/BLOWtcPXXTFMbqZLSwwRYLq38oSf/ka9eG
TYz4otXFI4WtgZDjyzpW5nFohN0Xd/p3BI2A73VaOa+z1mzgJTsAiZENrYwjnMPg
180tzfcBU1Hci0y3fGVwTZ8zDvikHOiPtbr+5+cn2Dq24EQdZ9Z7SreX0rlNiBTj
FXPkkF9fgT0n2B4EI1SO1v07CA==
=Ri2q
-----END PGP SIGNATURE-----

--x97MfmEV2Te1r8IpqL4aEX2ElkqGXKdek--
