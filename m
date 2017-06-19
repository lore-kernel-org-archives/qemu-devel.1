Received: from eggs.gnu.org ([2001:4830:134:3::10]:50843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dMyCS-0002c8-V3
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dMyCR-00054j-KY
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:02:45 -0400
Date: Mon, 19 Jun 2017 16:02:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170619150234.GJ17304@stefanha-x1.localdomain>
References: <20170613202107.10125-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/16] block: Preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 10:20:51PM +0200, Max Reitz wrote:
> =3D=3D=3D Series dependencies =3D=3D=3D
>=20
> This series depends on v7 of Stefan's series
> "qemu-img: add measure sub-command"
> (http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03035.html).
>=20
>=20
> =3D=3D=3D Actual cover letter =3D=3D=3D
>=20
> This series adds preallocation to bdrv_truncate() and subsequently
> qemu-img resize. This is implemented for qcow2 and raw only, just like
> preallocation for newly created images is. There is no runtime interface
> for this new parameter (yet).
>=20
>=20
> v4:
> - Patch 4:
>   - Note bug fix in commit message [Eric]
>   - "...may result in *slightly* more data being allocated..." [Eric]
> - Patch 11:
>   - Drop the "image may now occupy more space than necessary" note --
>     that's always the case when preallocation failed, and I don't really
>     want to mention it everywhere
>   - Flush metadata after preallocation [Stefan]
>=20
>=20
> git-backport-diff against v3:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/16:[----] [--] 'block: Add PreallocMode to BD.bdrv_truncate()'
> 002/16:[----] [--] 'block: Add PreallocMode to bdrv_truncate()'
> 003/16:[----] [--] 'block: Add PreallocMode to blk_truncate()'
> 004/16:[0002] [FC] 'qemu-img: Expose PreallocMode for resizing'
> 005/16:[----] [--] 'block/file-posix: Small fixes in raw_create()'
> 006/16:[----] [--] 'block/file-posix: Extract raw_regular_truncate()'
> 007/16:[----] [--] 'block/file-posix: Generalize raw_regular_truncate'
> 008/16:[----] [--] 'block/file-posix: Preallocation for truncate'
> 009/16:[----] [--] 'block/qcow2: Generalize preallocate()'
> 010/16:[----] [--] 'block/qcow2: Lock s->lock in preallocate()'
> 011/16:[0013] [FC] 'block/qcow2: Metadata preallocation for truncate'
> 012/16:[----] [--] 'block/qcow2: Add qcow2_refcount_area()'
> 013/16:[----] [--] 'block/qcow2: Rename "fail_block" to just "fail"'
> 014/16:[----] [--] 'block/qcow2: falloc/full preallocating growth'
> 015/16:[----] [--] 'iotests: Add preallocated resize test for raw'
> 016/16:[----] [--] 'iotests: Add preallocated growth test for qcow2'
>=20
>=20
> Max Reitz (16):
>   block: Add PreallocMode to BD.bdrv_truncate()
>   block: Add PreallocMode to bdrv_truncate()
>   block: Add PreallocMode to blk_truncate()
>   qemu-img: Expose PreallocMode for resizing
>   block/file-posix: Small fixes in raw_create()
>   block/file-posix: Extract raw_regular_truncate()
>   block/file-posix: Generalize raw_regular_truncate
>   block/file-posix: Preallocation for truncate
>   block/qcow2: Generalize preallocate()
>   block/qcow2: Lock s->lock in preallocate()
>   block/qcow2: Metadata preallocation for truncate
>   block/qcow2: Add qcow2_refcount_area()
>   block/qcow2: Rename "fail_block" to just "fail"
>   block/qcow2: falloc/full preallocating growth
>   iotests: Add preallocated resize test for raw
>   iotests: Add preallocated growth test for qcow2
>=20
>  block/qcow2.h                  |   9 +
>  include/block/block.h          |   3 +-
>  include/block/block_int.h      |   3 +-
>  include/sysemu/block-backend.h |   3 +-
>  block.c                        |   5 +-
>  block/blkdebug.c               |   5 +-
>  block/block-backend.c          |   5 +-
>  block/commit.c                 |   4 +-
>  block/crypto.c                 |   4 +-
>  block/file-posix.c             | 201 +++++++++++++--------
>  block/file-win32.c             |   9 +-
>  block/gluster.c                |   8 +-
>  block/iscsi.c                  |   9 +-
>  block/mirror.c                 |   3 +-
>  block/nfs.c                    |   9 +-
>  block/parallels.c              |  13 +-
>  block/qcow.c                   |   8 +-
>  block/qcow2-refcount.c         | 277 +++++++++++++++++++----------
>  block/qcow2.c                  | 205 +++++++++++++++++++---
>  block/qed.c                    |  11 +-
>  block/raw-format.c             |   5 +-
>  block/rbd.c                    |   9 +-
>  block/sheepdog.c               |  11 +-
>  block/vdi.c                    |   3 +-
>  block/vhdx-log.c               |   2 +-
>  block/vhdx.c                   |   8 +-
>  block/vmdk.c                   |   7 +-
>  block/vpc.c                    |   2 +-
>  blockdev.c                     |   2 +-
>  qemu-img.c                     |  33 +++-
>  qemu-io-cmds.c                 |   2 +-
>  qemu-img.texi                  |   7 +-
>  tests/qemu-iotests/044.out     |   2 +-
>  tests/qemu-iotests/106         |  92 ++++++++++
>  tests/qemu-iotests/106.out     |  50 ++++++
>  tests/qemu-iotests/125         | 130 ++++++++++++++
>  tests/qemu-iotests/125.out     | 386 +++++++++++++++++++++++++++++++++++=
++++++
>  tests/qemu-iotests/group       |   2 +
>  38 files changed, 1313 insertions(+), 234 deletions(-)
>  create mode 100755 tests/qemu-iotests/106
>  create mode 100644 tests/qemu-iotests/106.out
>  create mode 100755 tests/qemu-iotests/125
>  create mode 100644 tests/qemu-iotests/125.out
>=20
> --=20
> 2.9.4
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZR+eKAAoJEJykq7OBq3PIL7wH/2f9OWyq0nM2cnW0OmNWn63j
eGMtCFN5ipgEpsDJbbH+Qsg9iOPVRQJwCRviDNkvfXcU3B8DhrUx2z/bpMFVOmXk
/HaUjT6Hk3XTUmsvaclCvM6QW5xVAFMCTwjP1GWXFnvgeiPLh547ZB6BS9th7oSO
/TY27E+tn6OD8jlL7uUYiiVuYftnnB/MC5BDx9CSHobrMGa3dEfWKmi5arPSTTN9
LmvqeSBvbYdMgrrBRAp+0Y2Zh5RTxdKiJGLL9BHPEYrYiVwAJQOxOtAfSYKWsfC1
2xA91kKJPNC62euTvslpUOO3BxlPzTM7PplBzm+8HxcNZVOGNqChEJz9RPrTiW0=
=1ptV
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
