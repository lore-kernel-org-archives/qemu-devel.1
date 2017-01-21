Received: from eggs.gnu.org ([2001:4830:134:3::10]:46864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1RV-0007f4-Tn
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1RQ-0001AT-U8
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:35:17 -0500
References: <20170119130759.28319-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <29778613-3ffe-e17f-d01b-904b6caabfbd@redhat.com>
Date: Sat, 21 Jan 2017 20:35:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170119130759.28319-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O0X562veQaV7CuHIuo0jRDs5oN03G7Hbk"
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Fix iotests 059
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O0X562veQaV7CuHIuo0jRDs5oN03G7Hbk
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <29778613-3ffe-e17f-d01b-904b6caabfbd@redhat.com>
Subject: Re: [PATCH 0/2] block: Fix iotests 059
References: <20170119130759.28319-1-famz@redhat.com>
In-Reply-To: <20170119130759.28319-1-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 19.01.2017 14:07, Fam Zheng wrote:
> The 059.out went out of sync, bring it back in line.
>=20
> Fam Zheng (2):
>   qapi: Tweak error message of bdrv_query_image_info
>   iotests: Fix reference output for 059
>=20
>  block/qapi.c               | 4 ++--
>  tests/qemu-iotests/059.out | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--O0X562veQaV7CuHIuo0jRDs5oN03G7Hbk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliDt+USHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADbgIALjCItKWDbj0VWMceB7NqjvyOKsMLbNa
6I8Ax8DqL5JddIQHM2c4aMN+4NpaLHhcGnhiHO+lifxIoOLu16641wASiAhfuRms
oKyo3GamcydbNEnvMlJJi+Zyu50nqTMhQSYPGi6bYDHN/o4T94WaE2dRtm7dqQp1
hbSt1+oo4HSE3slRF8Y3aApXl8TMZgDQmcYdKsm9C325DGwLrhPo7DVf4p8ovwVe
/ceExbQdaUyi3HSL8MXdQxKO6YrzFyNLPkODdOCmW09LqBHhyHbLV8W27EqLzOIE
QlmT06rJCgffz7z1eqiaLxK0pNoZxVq2IECK03nwP26w62HZ93cO3Kc=
=2V4d
-----END PGP SIGNATURE-----

--O0X562veQaV7CuHIuo0jRDs5oN03G7Hbk--
