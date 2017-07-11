Received: from eggs.gnu.org ([2001:4830:134:3::10]:43825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxi7-0005zu-6p
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxi5-0004iJ-J0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:27 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:06:49 +0200
Message-Id: <20170711160814.20941-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/85] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

The following changes since commit 29741be341d50e4311e42ca3199f9b0bcfd4f5=
d2:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201707=
10.0' into staging (2017-07-11 13:47:28 +0100)

are available in the git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2017-07-11

for you to fetch changes up to ced14843229cd42c282f0ee4b43bbcdc324c923a:

  iotests: Add preallocated growth test for qcow2 (2017-07-11 17:45:02 +0=
200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Daniel P. Berrange (25):
  block: expose crypto option names / defs to other drivers
  block: add ability to set a prefix for opt names
  qcow: document another weakness of qcow AES encryption
  qcow: require image size to be > 1 for new images
  iotests: skip 042 with qcow which dosn't support zero sized images
  iotests: skip 048 with qcow which doesn't support resize
  block: deprecate "encryption=3Don" in favor of "encrypt.format=3Daes"
  qcow: make encrypt_sectors encrypt in place
  qcow: convert QCow to use QCryptoBlock for encryption
  qcow2: make qcow2_encrypt_sectors encrypt in place
  qcow2: convert QCow2 to use QCryptoBlock for encryption
  qcow2: extend specification to cover LUKS encryption
  qcow2: add support for LUKS encryption format
  qcow2: add iotests to cover LUKS encryption support
  iotests: enable tests 134 and 158 to work with qcow (v1)
  block: rip out all traces of password prompting
  block: remove all encryption handling APIs
  block: pass option prefix down to crypto layer
  qcow2: report encryption specific image information
  docs: document encryption options for qcow, qcow2 and luks
  iotests: skip 159 & 170 with luks format
  iotests: fix remainining tests to work with LUKS
  iotests: reduce PBKDF iterations when testing LUKS
  iotests: add more LUKS hash combination tests
  iotests: chown LUKS device before qemu-io launches

Eric Blake (1):
  tests: Avoid non-portable 'echo -ARG'

Max Reitz (19):
  iotests: 181 does not work for all formats
  iotests: Use absolute paths for executables
  iotests: Add test for colon handling
  block: Add PreallocMode to BD.bdrv_truncate()
  block: Add PreallocMode to bdrv_truncate()
  block: Add PreallocMode to blk_truncate()
  qemu-img: Expose PreallocMode for resizing
  block/file-posix: Small fixes in raw_create()
  block/file-posix: Extract raw_regular_truncate()
  block/file-posix: Generalize raw_regular_truncate
  block/file-posix: Preallocation for truncate
  block/qcow2: Generalize preallocate()
  block/qcow2: Lock s->lock in preallocate()
  block/qcow2: Metadata preallocation for truncate
  block/qcow2: Add qcow2_refcount_area()
  block/qcow2: Rename "fail_block" to just "fail"
  block/qcow2: falloc/full preallocating growth
  iotests: Add preallocated resize test for raw
  iotests: Add preallocated growth test for qcow2

Stefan Hajnoczi (9):
  block: add bdrv_measure() API
  raw-format: add bdrv_measure() support
  qcow2: extract preallocation calculation function
  qcow2: make refcount size calculation conservative
  qcow2: extract image creation option parsing
  qcow2: add bdrv_measure() support
  qemu-img: add measure subcommand
  qemu-iotests: support per-format golden output files
  iotests: add test 178 for qemu-img measure

Vladimir Sementsov-Ogievskiy (30):
  specs/qcow2: fix bitmap granularity qemu-specific note
  specs/qcow2: do not use wording 'bitmap header'
  hbitmap: improve dirty iter
  tests: add hbitmap iter test
  block: fix bdrv_dirty_bitmap_granularity signature
  block/dirty-bitmap: add deserialize_ones func
  qcow2-refcount: rename inc_refcounts() and make it public
  qcow2: add bitmaps extension
  block/dirty-bitmap: fix comment for BlockDirtyBitmap.disabled field
  block/dirty-bitmap: add readonly field to BdrvDirtyBitmap
  qcow2: autoloading dirty bitmaps
  block: refactor bdrv_reopen_commit
  block: new bdrv_reopen_bitmaps_rw interface
  qcow2: support .bdrv_reopen_bitmaps_rw
  block/dirty-bitmap: add autoload field to BdrvDirtyBitmap
  block: bdrv_close: release bitmaps after drv->bdrv_close
  block: introduce persistent dirty bitmaps
  block/dirty-bitmap: add bdrv_dirty_bitmap_next()
  qcow2: add persistent dirty bitmaps support
  qcow2: store bitmaps on reopening image as read-only
  block: add bdrv_can_store_new_dirty_bitmap
  qcow2: add .bdrv_can_store_new_dirty_bitmap
  qmp: add persistent flag to block-dirty-bitmap-add
  qmp: add autoload parameter to block-dirty-bitmap-add
  qmp: add x-debug-block-dirty-bitmap-sha256
  iotests: test qcow2 persistent dirty bitmap
  block/dirty-bitmap: add bdrv_remove_persistent_dirty_bitmap
  qcow2: add .bdrv_remove_persistent_dirty_bitmap
  qmp: block-dirty-bitmap-remove: remove persistent
  block: release persistent bitmaps on inactivate

sochin.jiang (1):
  mirror: Fix inconsistent backing AioContext for after mirroring

 docs/interop/qcow2.txt           |  111 ++-
 block/Makefile.objs              |    2 +-
 tests/Makefile.include           |    2 +-
 tests/tcg/cris/Makefile          |    8 +-
 qapi-schema.json                 |   10 +-
 qapi/block-core.json             |  197 +++--
 qapi/common.json                 |    5 +-
 block/crypto.h                   |  101 +++
 block/qcow2.h                    |   69 +-
 crypto/blockpriv.h               |    2 +
 include/block/block.h            |   11 +-
 include/block/block_int.h        |   22 +-
 include/block/dirty-bitmap.h     |   22 +-
 include/crypto/block.h           |    6 +-
 include/monitor/monitor.h        |    7 -
 include/qapi/error.h             |    1 -
 include/qemu/hbitmap.h           |   49 +-
 include/qemu/osdep.h             |    2 -
 include/sysemu/block-backend.h   |    3 +-
 block.c                          |  183 ++---
 block/blkdebug.c                 |    5 +-
 block/block-backend.c            |    5 +-
 block/commit.c                   |    4 +-
 block/crypto.c                   |  101 +--
 block/dirty-bitmap.c             |  154 +++-
 block/file-posix.c               |  201 ++++--
 block/file-win32.c               |    9 +-
 block/gluster.c                  |    8 +-
 block/io.c                       |    8 +
 block/iscsi.c                    |    9 +-
 block/mirror.c                   |    3 +-
 block/nfs.c                      |    9 +-
 block/parallels.c                |   13 +-
 block/qapi.c                     |    2 +-
 block/qcow.c                     |  277 +++----
 block/qcow2-bitmap.c             | 1482 ++++++++++++++++++++++++++++++++=
++++++
 block/qcow2-cluster.c            |   66 +-
 block/qcow2-refcount.c           |  346 ++++++---
 block/qcow2.c                    | 1231 ++++++++++++++++++++++++++-----
 block/qed.c                      |   11 +-
 block/raw-format.c               |   31 +-
 block/rbd.c                      |    9 +-
 block/sheepdog.c                 |   11 +-
 block/vdi.c                      |    3 +-
 block/vhdx-log.c                 |    2 +-
 block/vhdx.c                     |    8 +-
 block/vmdk.c                     |    7 +-
 block/vpc.c                      |    2 +-
 blockdev.c                       |  112 ++-
 crypto/block-luks.c              |    8 +-
 crypto/block-qcow.c              |    8 +-
 crypto/block.c                   |    6 +-
 hmp.c                            |   31 -
 monitor.c                        |   68 --
 qemu-img.c                       |  302 +++++++-
 qemu-io-cmds.c                   |    2 +-
 qemu-io.c                        |   20 -
 qmp.c                            |   12 +-
 tests/test-crypto-block.c        |    8 +-
 tests/test-hbitmap.c             |   19 +
 util/hbitmap.c                   |   51 +-
 util/oslib-posix.c               |   66 --
 util/oslib-win32.c               |   24 -
 hmp-commands.hx                  |    2 +
 qemu-doc.texi                    |  123 +++-
 qemu-img-cmds.hx                 |    6 +
 qemu-img.texi                    |   56 +-
 qemu-options.hx                  |    4 +-
 tests/multiboot/run_test.sh      |   10 +-
 tests/qemu-iotests/033           |   12 +-
 tests/qemu-iotests/042           |    2 +-
 tests/qemu-iotests/044.out       |    2 +-
 tests/qemu-iotests/048           |    2 +-
 tests/qemu-iotests/049           |    2 +-
 tests/qemu-iotests/049.out       |  102 +--
 tests/qemu-iotests/051           |    7 +-
 tests/qemu-iotests/068           |    2 +-
 tests/qemu-iotests/082.out       |  284 +++++++-
 tests/qemu-iotests/085.out       |   38 +-
 tests/qemu-iotests/087           |   39 +-
 tests/qemu-iotests/087.out       |   16 +-
 tests/qemu-iotests/106           |   92 +++
 tests/qemu-iotests/106.out       |   50 ++
 tests/qemu-iotests/120           |    1 +
 tests/qemu-iotests/125           |  130 ++++
 tests/qemu-iotests/125.out       |  386 ++++++++++
 tests/qemu-iotests/126           |  105 +++
 tests/qemu-iotests/126.out       |   23 +
 tests/qemu-iotests/134           |   20 +-
 tests/qemu-iotests/134.out       |   10 +-
 tests/qemu-iotests/140           |    9 +-
 tests/qemu-iotests/142           |   48 +-
 tests/qemu-iotests/144.out       |    4 +-
 tests/qemu-iotests/145           |   19 +-
 tests/qemu-iotests/149           |   25 +-
 tests/qemu-iotests/149.out       | 1002 +++++++++++++++++++-------
 tests/qemu-iotests/157           |   17 +-
 tests/qemu-iotests/157.out       |   16 +-
 tests/qemu-iotests/158           |   21 +-
 tests/qemu-iotests/158.out       |   14 +-
 tests/qemu-iotests/159           |    1 +
 tests/qemu-iotests/165           |  105 +++
 tests/qemu-iotests/165.out       |    5 +
 tests/qemu-iotests/170           |    1 +
 tests/qemu-iotests/171           |   14 +-
 tests/qemu-iotests/174           |    2 +-
 tests/qemu-iotests/178           |  170 +++++
 tests/qemu-iotests/178.out.qcow2 |  286 ++++++++
 tests/qemu-iotests/178.out.raw   |  158 ++++
 tests/qemu-iotests/181           |   23 +-
 tests/qemu-iotests/185.out       |    8 +-
 tests/qemu-iotests/188           |   76 ++
 tests/qemu-iotests/188.out       |   18 +
 tests/qemu-iotests/189           |   86 +++
 tests/qemu-iotests/189.out       |   26 +
 tests/qemu-iotests/check         |   23 +-
 tests/qemu-iotests/common        |   10 +-
 tests/qemu-iotests/common.config |   11 +
 tests/qemu-iotests/common.filter |    3 +-
 tests/qemu-iotests/common.qemu   |    9 +-
 tests/qemu-iotests/common.rc     |    3 +
 tests/qemu-iotests/group         |    7 +
 tests/rocker/all                 |   10 +-
 123 files changed, 7616 insertions(+), 1707 deletions(-)
 create mode 100644 block/crypto.h
 create mode 100644 block/qcow2-bitmap.c
 create mode 100755 tests/qemu-iotests/106
 create mode 100644 tests/qemu-iotests/106.out
 create mode 100755 tests/qemu-iotests/125
 create mode 100644 tests/qemu-iotests/125.out
 create mode 100755 tests/qemu-iotests/126
 create mode 100644 tests/qemu-iotests/126.out
 create mode 100755 tests/qemu-iotests/165
 create mode 100644 tests/qemu-iotests/165.out
 create mode 100755 tests/qemu-iotests/178
 create mode 100644 tests/qemu-iotests/178.out.qcow2
 create mode 100644 tests/qemu-iotests/178.out.raw
 create mode 100755 tests/qemu-iotests/188
 create mode 100644 tests/qemu-iotests/188.out
 create mode 100755 tests/qemu-iotests/189
 create mode 100644 tests/qemu-iotests/189.out

--=20
2.9.4
