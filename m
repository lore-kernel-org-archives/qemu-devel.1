Received: from eggs.gnu.org ([2001:4830:134:3::10]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cu3No-00034a-QR
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 16:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cu3Nn-0001Rt-Sj
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 16:42:56 -0400
References: <20170331185356.2479-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d03cfed6-8202-64e7-a2f1-fe286464f860@redhat.com>
Date: Fri, 31 Mar 2017 22:42:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170331185356.2479-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oCPDIRbrNIdx8XgD9b5EX0pjibx8UT9dO"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v8 0/3] Fix wipe of unaligned qcow2
 image [was add blkdebug tests]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oCPDIRbrNIdx8XgD9b5EX0pjibx8UT9dO
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <d03cfed6-8202-64e7-a2f1-fe286464f860@redhat.com>
Subject: Re: [PATCH for-2.9 v8 0/3] Fix wipe of unaligned qcow2 image [was add
 blkdebug tests]
References: <20170331185356.2479-1-eblake@redhat.com>
In-Reply-To: <20170331185356.2479-1-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 20:53, Eric Blake wrote:
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v8
>=20
> (which is somewhat of a misnomer for this current version of the
> series, but historically correct)
>=20
> v6 was:
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg01562.html
> v7 was:
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg06175.html
>=20
> Since then: reorder patches 2 and 3, and update commit messages to matc=
h
>=20
> 001/3:[----] [--] 'iotests: fix 097 when run with qcow'
> 002/3:[0002] [FC] 'qcow2: Discard unaligned tail when wiping image'
> 003/3:[0002] [FC] 'iotests: Improve image-clear tests on non-aligned im=
age'
>=20
> Daniel P. Berrange (1):
>   iotests: fix 097 when run with qcow
>=20
> Eric Blake (2):
>   qcow2: Discard unaligned tail when wiping image
>   iotests: Improve image-clear tests on non-aligned image
>=20
>  block/qcow2-cluster.c      |  10 +--
>  tests/qemu-iotests/097     |  27 +++----
>  tests/qemu-iotests/097.out | 180 ++++++++++++-------------------------=
--------
>  tests/qemu-iotests/176     | 131 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/176.out | 150 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/group   |   1 +
>  6 files changed, 345 insertions(+), 154 deletions(-)
>  create mode 100755 tests/qemu-iotests/176
>  create mode 100644 tests/qemu-iotests/176.out

Reviewed-by: Max Reitz <mreitz@redhat.com>


Thanks a lot, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--oCPDIRbrNIdx8XgD9b5EX0pjibx8UT9dO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljev0YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ahb8H+QFI+26e+B/mQ3Ou+ROMjLZKWYEY8wqR
dfbKmRNoq7kvQNmjuk2kEw9CyN+qr/kuJ8DXsgpVmLYquglep0thUA31u2C8FGGf
ttcnALPxwh8pSberihKXeH3Rp0Ldc0g8k5EbaK/7MbBsXUBNQt76//Ude1YK5Pkg
POgVQiTq7uQlIl5Tbp+q+lzTI/iPBRLsBM3ej9GAEyoQ1dNvnfvEiTfpQIOgxwCi
m/2Mmj6yNGDy51xl194Ee6BQogjFz4VZHBEG9tU5byVcwtWA2uS4B/scMKusvYq0
wGM5oZX4FqYZtR10hU2O3asjq9o6M+w65V/4cWC8kV0B3oMXo84nYLs=
=KIit
-----END PGP SIGNATURE-----

--oCPDIRbrNIdx8XgD9b5EX0pjibx8UT9dO--
