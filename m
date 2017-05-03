Received: from eggs.gnu.org ([2001:4830:134:3::10]:55671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zcL-0006sn-1N
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zcJ-0008VY-Rh
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:07:17 -0400
References: <20170429191419.30051-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <111ec5c4-ecb2-a94f-b0c2-69b29f662f72@redhat.com>
Date: Wed, 3 May 2017 21:07:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170429191419.30051-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ilCNIknMIoDkH3cTPpGG6DVECuA4ELSbG"
Subject: Re: [Qemu-devel] [PATCH v11 0/9] add blkdebug tests
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
--ilCNIknMIoDkH3cTPpGG6DVECuA4ELSbG
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <111ec5c4-ecb2-a94f-b0c2-69b29f662f72@redhat.com>
Subject: Re: [PATCH v11 0/9] add blkdebug tests
References: <20170429191419.30051-1-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.2017 21:14, Eric Blake wrote:
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v11
>=20
> Prerequisites: Kevin's block pull request:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05799.html
>=20
> v10 was:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05227.html
>=20
> Since then:
> - Rebase to Kevin's block branch (patches 7, 8)
> - Split series in two - this focuses on just the (relatively stable)
> blkdebug enhancements (v10 6-8, 12-17), and saves the qcow2 fixes
> (v10 1-5, 9-11) for another day [Max]
> - further tweaks to the qemu-io alloc/map commands (patch 1 retitled,
> also affecting patch 2-3)
>=20
> 001/9:[down] 'qemu-io: Improve alignment checks'
> 002/9:[0022] [FC] 'qemu-io: Switch 'alloc' command to byte-based length=
'
> 003/9:[0066] [FC] 'qemu-io: Switch 'map' output to byte-based reporting=
'
> 004/9:[----] [--] 'blkdebug: Sanity check block layer guarantees'
> 005/9:[----] [--] 'blkdebug: Refactor error injection'
> 006/9:[----] [--] 'blkdebug: Add pass-through write_zero and discard su=
pport'
> 007/9:[0004] [FC] 'blkdebug: Simplify override logic'
> 008/9:[0010] [FC] 'blkdebug: Add ability to override unmap geometries'
> 009/9:[----] [-C] 'tests: Add coverage for recent block geometry fixes'=

>=20
> Eric Blake (9):
>   qemu-io: Improve alignment checks
>   qemu-io: Switch 'alloc' command to byte-based length
>   qemu-io: Switch 'map' output to byte-based reporting
>   blkdebug: Sanity check block layer guarantees
>   blkdebug: Refactor error injection
>   blkdebug: Add pass-through write_zero and discard support
>   blkdebug: Simplify override logic
>   blkdebug: Add ability to override unmap geometries
>   tests: Add coverage for recent block geometry fixes
>=20
>  qapi/block-core.json              |  33 ++++-
>  block/blkdebug.c                  | 266 ++++++++++++++++++++++++++++++=
+-------
>  qemu-io-cmds.c                    |  61 +++++----
>  tests/qemu-iotests/019.out        |   8 +-
>  tests/qemu-iotests/102.out        |   4 +-
>  tests/qemu-iotests/146.out        |  30 ++---
>  tests/qemu-iotests/177            | 114 ++++++++++++++++
>  tests/qemu-iotests/177.out        |  49 +++++++
>  tests/qemu-iotests/common.pattern |   2 +-
>  tests/qemu-iotests/group          |   1 +
>  10 files changed, 468 insertions(+), 100 deletions(-)
>  create mode 100755 tests/qemu-iotests/177
>  create mode 100644 tests/qemu-iotests/177.out

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--ilCNIknMIoDkH3cTPpGG6DVECuA4ELSbG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKKlsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AaC4IALwkYQrGawXpPlgjUOLpx05BToHtUyI4
E/w4sa/y/ricl5amN1meSjmwIPJauWdBKPQNPSPmsLwBfPB9+RC2atGAnQJmW/5R
iL9YibRtFZMX1fw4LzD7Twnh3Y+sAkz7hnPVUYoX6Ng4OCegeqyDUy01+JaDdvo4
Jbp6VAYp/RbK19dvUuu/pHO0Pcrqlm08FRKZ+CDV4b9WFF1xHiVZNyVM+7h7QFQ4
auro1MD4VfJpGc9d2z4ObtPKydZvr4fCaActrTLStMas9O+eu+8fw8lBZb5tTOBD
1Mwqajmp8N3RjtqhC1btzPMKWJ9tqtCTF6cWgBQqTQEY60hmgrXEZFA=
=ubfm
-----END PGP SIGNATURE-----

--ilCNIknMIoDkH3cTPpGG6DVECuA4ELSbG--
