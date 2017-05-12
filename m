Received: from eggs.gnu.org ([2001:4830:134:3::10]:59687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9AnD-0002uO-6H
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9AnB-00055o-JS
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:39:39 -0400
Date: Fri, 12 May 2017 09:39:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170512133926.GA589@stefanha-x1.localdomain>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/58] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:32:03PM +0200, Kevin Wolf wrote:
> The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:
>=20
>   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)
>=20
> are available in the git repository at:
>=20
>=20
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>=20
> for you to fetch changes up to d541e201bd3ad888f02abeddf0e14f7b0c126529:
>=20
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-05-11' into q=
ueue-block (2017-05-11 14:34:56 +0200)
>=20
> ----------------------------------------------------------------
>=20
> Block layer patches
>=20
> ----------------------------------------------------------------
> Anton Nefedov (1):
>       qemu-img: wait for convert coroutines to complete
>=20
> Christoph Hellwig (1):
>       nvme: Implement Write Zeroes
>=20
> Eric Blake (21):
>       qemu-io: Improve alignment checks
>       qemu-io: Switch 'alloc' command to byte-based length
>       qemu-io: Switch 'map' output to byte-based reporting
>       blkdebug: Sanity check block layer guarantees
>       blkdebug: Refactor error injection
>       blkdebug: Add pass-through write_zero and discard support
>       blkdebug: Simplify override logic
>       blkdebug: Add ability to override unmap geometries
>       tests: Add coverage for recent block geometry fixes
>       qcow2: Nicer variable names in qcow2_update_snapshot_refcount()
>       qcow2: Use consistent switch indentation
>       block: Update comments on BDRV_BLOCK_* meanings
>       qcow2: Correctly report status of preallocated zero clusters
>       qcow2: Name typedef for cluster type
>       qcow2: Make distinction between zero cluster types obvious
>       qcow2: Optimize zero_single_l2() to minimize L2 churn
>       iotests: Improve _filter_qemu_img_map
>       iotests: Add test 179 to cover write zeroes with unmap
>       qcow2: Optimize write zero of unaligned tail cluster
>       qcow2: Assert that cluster operations are aligned
>       qcow2: Discard/zero clusters by byte count
>=20
> Fam Zheng (23):
>       block: Make bdrv_perm_names public
>       block: Add, parse and store "force-share" option
>       block: Respect "force-share" in perm propagating
>       qemu-img: Add --force-share option to subcommands
>       qemu-img: Update documentation for -U
>       qemu-io: Add --force-share option
>       iotests: 030: Prepare for image locking
>       iotests: 046: Prepare for image locking
>       iotests: 055: Don't attach the target image already for drive-backup
>       iotests: 085: Avoid image locking conflict
>       iotests: 087: Don't attach test image twice
>       iotests: 091: Quit QEMU before checking image
>       iotests: 172: Use separate images for multiple devices
>       tests: Use null-co:// instead of /dev/null as the dummy image
>       file-posix: Add 'locking' option
>       file-win32: Error out if locking=3Don
>       tests: Disable image lock in test-replication
>       block: Reuse bs as backing hd for drive-backup sync=3Dnone
>       osdep: Add qemu_lock_fd and qemu_unlock_fd
>       osdep: Fall back to posix lock when OFD lock is unavailable
>       file-posix: Add image locking to perm operations
>       qemu-iotests: Add test case 153 for image locking
>       tests: Add POSIX image locking test case 182
>=20
> John Snow (1):
>       blockdev: use drained_begin/end for qmp_block_resize
>=20
> Kevin Wolf (7):
>       migration: Unify block node activation error handling
>       block: New BdrvChildRole.activate() for blk_resume_after_migration()
>       block: Drop permissions when migration completes
>       block: Inactivate parents before children
>       block: Fix write/resize permissions for inactive images
>       file-posix: Remove .bdrv_inactivate/invalidate_cache
>       Merge remote-tracking branch 'mreitz/tags/pull-block-2017-05-11' in=
to queue-block
>=20
> Max Reitz (5):
>       qcow2: Fix preallocation size formula
>       qcow2: Reuse preallocated zero clusters
>       qcow2: Discard preallocated zero clusters
>       iotests: Extend test 066
>       MAINTAINERS: Add qemu-progress to the block layer
>=20
>  MAINTAINERS                       |   1 +
>  block.c                           | 127 +++++++++++--
>  block/blkdebug.c                  | 264 +++++++++++++++++++++-----
>  block/block-backend.c             |  81 +++++---
>  block/file-posix.c                | 248 +++++++++++++++++++++++-
>  block/file-win32.c                |   5 +
>  block/qcow2-cluster.c             | 252 ++++++++++++++----------
>  block/qcow2-refcount.c            | 148 +++++++--------
>  block/qcow2-snapshot.c            |   7 +-
>  block/qcow2.c                     |  47 +++--
>  block/qcow2.h                     |  26 ++-
>  blockdev.c                        |  20 +-
>  hw/block/nvme.c                   |  26 +++
>  hw/block/nvme.h                   |   1 +
>  include/block/block.h             |  41 ++--
>  include/block/block_int.h         |  14 ++
>  include/qemu/osdep.h              |   3 +
>  migration/migration.c             |  13 +-
>  migration/savevm.c                |   9 +-
>  qapi/block-core.json              |  40 +++-
>  qemu-img-cmds.hx                  |  36 ++--
>  qemu-img.c                        | 179 ++++++++++++-----
>  qemu-io-cmds.c                    |  61 +++---
>  qemu-io.c                         |  42 +++-
>  qmp.c                             |  18 +-
>  tests/drive_del-test.c            |   2 +-
>  tests/nvme-test.c                 |   2 +-
>  tests/qemu-iotests/019.out        |   8 +-
>  tests/qemu-iotests/030            |  18 +-
>  tests/qemu-iotests/046            |   2 +-
>  tests/qemu-iotests/055            |  32 ++--
>  tests/qemu-iotests/060.out        |   6 +-
>  tests/qemu-iotests/066            | 128 ++++++++++++-
>  tests/qemu-iotests/066.out        |  46 +++++
>  tests/qemu-iotests/085            |  33 ++--
>  tests/qemu-iotests/085.out        |   3 +-
>  tests/qemu-iotests/087            |   6 +-
>  tests/qemu-iotests/091            |   2 +
>  tests/qemu-iotests/102.out        |   4 +-
>  tests/qemu-iotests/122.out        |  16 +-
>  tests/qemu-iotests/146.out        |  30 +--
>  tests/qemu-iotests/153            | 233 +++++++++++++++++++++++
>  tests/qemu-iotests/153.out        | 390 ++++++++++++++++++++++++++++++++=
++++++
>  tests/qemu-iotests/154            | 160 +++++++++++++++-
>  tests/qemu-iotests/154.out        | 158 +++++++++++++--
>  tests/qemu-iotests/172            |  55 +++---
>  tests/qemu-iotests/172.out        |  50 ++---
>  tests/qemu-iotests/177            | 114 +++++++++++
>  tests/qemu-iotests/177.out        |  49 +++++
>  tests/qemu-iotests/179            | 130 +++++++++++++
>  tests/qemu-iotests/179.out        | 156 +++++++++++++++
>  tests/qemu-iotests/182            |  68 +++++++
>  tests/qemu-iotests/182.out        |   8 +
>  tests/qemu-iotests/common.filter  |   4 +-
>  tests/qemu-iotests/common.pattern |   2 +-
>  tests/qemu-iotests/group          |   4 +
>  tests/test-replication.c          |   9 +-
>  tests/usb-hcd-uhci-test.c         |   2 +-
>  tests/usb-hcd-xhci-test.c         |   2 +-
>  tests/virtio-blk-test.c           |   2 +-
>  tests/virtio-scsi-test.c          |   5 +-
>  util/osdep.c                      |  48 +++++
>  62 files changed, 3086 insertions(+), 610 deletions(-)
>  create mode 100755 tests/qemu-iotests/153
>  create mode 100644 tests/qemu-iotests/153.out
>  create mode 100755 tests/qemu-iotests/177
>  create mode 100644 tests/qemu-iotests/177.out
>  create mode 100755 tests/qemu-iotests/179
>  create mode 100644 tests/qemu-iotests/179.out
>  create mode 100755 tests/qemu-iotests/182
>  create mode 100644 tests/qemu-iotests/182.out

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFbsOAAoJEJykq7OBq3PILrkH/0zSG6IXbI6cV0SrXIx5hFsR
15CRFrsuaXhIN+iOGEKY1A6kkTu83A5AmFuIHh1S4LU87LVO59RDb5VznETmX/Hy
pB6+0stunzQ25lF41wcCs+bDtmur/gyv1kUT3U1jaiDZPx1K+MYcz+ztlcThOxtY
K5MBdIrejrfe+OcKi0FVKrO87iwwu6XLvRPryC6BmJljgwR3hycF5HyUxLAunJ3z
abOD9zAxEyDN8BEMFIKEbH+2gp653hJ2AJSLNs0FxgSyHALrBuAka9lzFHu39Qt/
5lzV2JPGaHi7boRZGQ2ocwGPsNDDrOYPcc94ubTbSHrjP2yjS1TSbPHLfs/Uz/c=
=kvok
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
