Received: from eggs.gnu.org ([2001:4830:134:3::10]:60360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYktP-00064t-6I
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYktO-000668-Af
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:43:31 -0500
References: <cover.1485392617.git.jcody@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1c281dc7-a4de-4bd0-a2dc-6cfddd3ccb5b@redhat.com>
Date: Wed, 1 Feb 2017 03:43:21 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1485392617.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n3vtXJEimC3bBalVtnLtu2mE6WeiT9IQa"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] block: check full backing filename
 when searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n3vtXJEimC3bBalVtnLtu2mE6WeiT9IQa
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com
Message-ID: <1c281dc7-a4de-4bd0-a2dc-6cfddd3ccb5b@redhat.com>
Subject: Re: [PATCH v2 0/3] block: check full backing filename when searching
 protocol filenames
References: <cover.1485392617.git.jcody@redhat.com>
In-Reply-To: <cover.1485392617.git.jcody@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 26.01.2017 02:08, Jeff Cody wrote:
> Differences from v1:
>=20
> Patch 1: set local_error =3D NULL after freeing (Thanks Eric)
> Patch 2: new patch, groundwork for qemu-iotest in patch 3
> Patch 3: qemu-iotest, as requested (Thanks Max)
>=20
>=20
> Jeff Cody (3):
>   block: check full backing filename when searching protocol filenames
>   qemu-iotests: Don't create fifos / pidfiles with protocol paths
>   qemu-iotest: test to lookup protocol-based image with relative backin=
g
>=20
>  block.c                          | 13 ++++++
>  tests/qemu-iotests/173           | 97 ++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/173.out       | 12 +++++
>  tests/qemu-iotests/common.config |  6 ++-
>  tests/qemu-iotests/common.qemu   | 10 ++---
>  tests/qemu-iotests/common.rc     |  6 +--
>  tests/qemu-iotests/group         |  1 +
>  7 files changed, 135 insertions(+), 10 deletions(-)
>  create mode 100755 tests/qemu-iotests/173
>  create mode 100644 tests/qemu-iotests/173.out

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--n3vtXJEimC3bBalVtnLtu2mE6WeiT9IQa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRS0kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0/wH/1bBWYFOPmu7/vNywFiJEQupVeiWW6FS
wKDiUQeBJjStvP9vrYPU0642DBCRFLUCt04Nb4eUWbfbj0jP8ZDI/W6ptjXU7zJ/
jg2hDk/yOW3Wsw5SLAePklpPn7X4IQEBQf9FoX1uSRqDAmPhgWNNUANCiKs/SXF2
UTbfeAizbR4toG51MHgV2v3cnrWMTvrx7Ak5bN3oOSZoZ7JQDafTFU/h5rJTRHG9
iMo+KBM6Knicqjot3W7ATCYwlpdBgR9FWtmdthAiQEJCOMwzUvIoZvU1ho4eDeF9
3EFEbBJq2a257l3Cpp7krBpr5VtWqBwCZpotYHsISOyCeH+7VjcS0Mk=
=8m/W
-----END PGP SIGNATURE-----

--n3vtXJEimC3bBalVtnLtu2mE6WeiT9IQa--
