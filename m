Received: from eggs.gnu.org ([2001:4830:134:3::10]:54030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUId8-0007tW-Qn
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUId7-0001JH-J8
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:16:34 -0400
References: <20170613202107.10125-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <56ecd1e3-8efb-c810-37d4-36c4b68b8ac0@redhat.com>
Date: Sun, 9 Jul 2017 22:16:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LF7G7U4kxCmKq73mMkpdm8bNVq5I8lrLO"
Subject: Re: [Qemu-devel] [PATCH v4 00/16] block: Preallocated truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LF7G7U4kxCmKq73mMkpdm8bNVq5I8lrLO
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <56ecd1e3-8efb-c810-37d4-36c4b68b8ac0@redhat.com>
Subject: Re: [PATCH v4 00/16] block: Preallocated truncate
References: <20170613202107.10125-1-mreitz@redhat.com>
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 22:20, Max Reitz wrote:
> =3D=3D=3D Series dependencies =3D=3D=3D
>=20
> This series depends on v7 of Stefan's series
> "qemu-img: add measure sub-command"
> (http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03035.html)=
=2E
>=20
>=20
> =3D=3D=3D Actual cover letter =3D=3D=3D
>=20
> This series adds preallocation to bdrv_truncate() and subsequently
> qemu-img resize. This is implemented for qcow2 and raw only, just like
> preallocation for newly created images is. There is no runtime interfac=
e
> for this new parameter (yet).
>=20
>=20
> v4:
> - Patch 4:
>   - Note bug fix in commit message [Eric]
>   - "...may result in *slightly* more data being allocated..." [Eric]
> - Patch 11:
>   - Drop the "image may now occupy more space than necessary" note --
>     that's always the case when preallocation failed, and I don't reall=
y
>     want to mention it everywhere
>   - Flush metadata after preallocation [Stefan]
>=20
>=20
> git-backport-diff against v3:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
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
>  tests/qemu-iotests/125.out     | 386 +++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group       |   2 +
>  38 files changed, 1313 insertions(+), 234 deletions(-)
>  create mode 100755 tests/qemu-iotests/106
>  create mode 100644 tests/qemu-iotests/106.out
>  create mode 100755 tests/qemu-iotests/125
>  create mode 100644 tests/qemu-iotests/125.out

Applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--LF7G7U4kxCmKq73mMkpdm8bNVq5I8lrLO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYo8UEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQP/u
B/9K2Wt4vcfuSVqoYvS/yBoPqD2gQfBEkUozNjZDgFJx5rKGKzO8hXT/WDwwlnRu
Zn4kqGrB4oqdcyDr1gWvSTo2HE9XTXQf/3f0PB/v54yVoMBmLvLT1wmZ1+IZU7/R
C2Ib6k/+MxjlLcz/vP5kQiUDivT2yGF15VATD7nGlStrpNgLWo50RMe/bjoVaS1q
H6dCYHYzBIyDt9CBvd/qBawdGVA7Z3eOcM+vfTY84DSW8pGJby8FHF+6H39Oe3zT
E9Ytn58902I17LUBrhiH80OpaBbLGqGFk2daB0k2l3aI9Rj2ra36WkSUxfEL1yEb
FCvOlAWikQ+gdGfQq0HCmHHH
=MaNn
-----END PGP SIGNATURE-----

--LF7G7U4kxCmKq73mMkpdm8bNVq5I8lrLO--
