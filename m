Received: from eggs.gnu.org ([2001:4830:134:3::10]:41213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkp-0004Y3-2u
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkm-0007XV-Ti
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:15 +0200
Message-Id: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 000/100] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit b11365867568ba954de667a0bfe0945b8f78d6=
bd:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170706' =
into staging (2017-07-06 11:42:59 +0100)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 7d982302db173616d011e07ee43be3b0aae872b1:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-07-07' into q=
ueue-block (2017-07-07 18:11:41 +0200)

----------------------------------------------------------------

Block layer patches

----------------------------------------------------------------
Daniel P. Berrange (26):
      qemu-img: drop -e and -6 options from the 'create' & 'convert' comm=
ands
      block: expose crypto option names / defs to other drivers
      block: add ability to set a prefix for opt names
      qcow: document another weakness of qcow AES encryption
      qcow: require image size to be > 1 for new images
      iotests: skip 042 with qcow which dosn't support zero sized images
      iotests: skip 048 with qcow which doesn't support resize
      block: deprecate "encryption=3Don" in favor of "encrypt.format=3Dae=
s"
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

Eric Blake (26):
      qemu-io: Don't die on second open
      block: Guarantee that *file is set on bdrv_get_block_status()
      block: Simplify use of BDRV_BLOCK_RAW
      blkdebug: Support .bdrv_co_get_block_status
      blockjob: Track job ratelimits via bytes, not sectors
      trace: Show blockjob actions via bytes, not sectors
      stream: Switch stream_populate() to byte-based
      stream: Drop reached_end for stream_complete()
      stream: Switch stream_run() to byte-based
      commit: Switch commit_populate() to byte-based
      commit: Switch commit_run() to byte-based
      mirror: Switch MirrorBlockJob to byte-based
      mirror: Switch mirror_do_zero_or_discard() to byte-based
      mirror: Update signature of mirror_clip_sectors()
      mirror: Switch mirror_cow_align() to byte-based
      mirror: Switch mirror_do_read() to byte-based
      mirror: Switch mirror_iteration() to byte-based
      block: Drop unused bdrv_round_sectors_to_clusters()
      backup: Switch BackupBlockJob to byte-based
      backup: Switch block_backup.h to byte-based
      backup: Switch backup_do_cow() to byte-based
      backup: Switch backup_run() to byte-based
      block: Make bdrv_is_allocated() byte-based
      block: Minimize raw use of bds->total_sectors
      block: Make bdrv_is_allocated_above() byte-based
      tests: Avoid non-portable 'echo -ARG'

Herv=C3=A9 Poussineau (13):
      vvfat: fix qemu-img map and qemu-img convert
      vvfat: replace tabs by 8 spaces
      vvfat: fix typos
      vvfat: rename useless enumeration values
      vvfat: introduce offset_to_bootsector, offset_to_fat and offset_to_=
root_dir
      vvfat: fix field names in FAT12/FAT16 and FAT32 boot sectors
      vvfat: always create . and .. entries at first and in that order
      vvfat: correctly create long names for non-ASCII filenames
      vvfat: correctly create base short names for non-ASCII filenames
      vvfat: correctly generate numeric-tail of short file names
      vvfat: limit number of entries in root directory in FAT12/FAT16
      vvfat: handle KANJI lead byte 0xe5
      vvfat: change OEM name to 'MSWIN4.1'

Kevin Wolf (1):
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-07-07' in=
to queue-block

Max Reitz (3):
      iotests: 181 does not work for all formats
      iotests: Use absolute paths for executables
      iotests: Add test for colon handling

Thomas Huth (1):
      blockdev: Print a warning for legacy drive options that belong to -=
device

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

 block.c                          |  143 +--
 block/Makefile.objs              |    2 +-
 block/backup.c                   |  128 +--
 block/blkdebug.c                 |   11 +
 block/commit.c                   |   56 +-
 block/crypto.c                   |   97 +-
 block/crypto.h                   |  101 ++
 block/dirty-bitmap.c             |  154 ++-
 block/io.c                       |  110 +-
 block/mirror.c                   |  310 ++---
 block/qapi.c                     |    2 +-
 block/qcow.c                     |  269 ++---
 block/qcow2-bitmap.c             | 1481 ++++++++++++++++++++++++
 block/qcow2-cluster.c            |   66 +-
 block/qcow2-refcount.c           |   69 +-
 block/qcow2.c                    |  653 +++++++++--
 block/qcow2.h                    |   60 +-
 block/raw-format.c               |    2 +-
 block/replication.c              |   29 +-
 block/stream.c                   |   37 +-
 block/trace-events               |   14 +-
 block/vpc.c                      |    2 +-
 block/vvfat.c                    | 2336 ++++++++++++++++++++------------=
------
 blockdev.c                       |  124 +-
 crypto/block-luks.c              |    8 +-
 crypto/block-qcow.c              |    8 +-
 crypto/block.c                   |    6 +-
 crypto/blockpriv.h               |    2 +
 docs/interop/qcow2.txt           |  111 +-
 hmp-commands.hx                  |    2 +
 hmp.c                            |   31 -
 include/block/block.h            |   22 +-
 include/block/block_backup.h     |   11 +-
 include/block/block_int.h        |   17 +-
 include/block/dirty-bitmap.h     |   22 +-
 include/crypto/block.h           |    6 +-
 include/monitor/monitor.h        |    7 -
 include/qapi/error.h             |    1 -
 include/qemu/hbitmap.h           |   49 +-
 include/qemu/osdep.h             |    2 -
 include/qemu/ratelimit.h         |    3 +-
 migration/block.c                |   16 +-
 monitor.c                        |   68 --
 qapi-schema.json                 |   10 +-
 qapi/block-core.json             |  172 ++-
 qapi/common.json                 |    5 +-
 qemu-doc.texi                    |  123 +-
 qemu-img.c                       |   76 +-
 qemu-img.texi                    |   19 +-
 qemu-io-cmds.c                   |   70 +-
 qemu-io.c                        |   27 +-
 qemu-options.hx                  |   13 +-
 qmp.c                            |   12 +-
 tests/Makefile.include           |    2 +-
 tests/multiboot/run_test.sh      |   10 +-
 tests/qemu-iotests/033           |   12 +-
 tests/qemu-iotests/042           |    2 +-
 tests/qemu-iotests/048           |    2 +-
 tests/qemu-iotests/049           |    2 +-
 tests/qemu-iotests/049.out       |  102 +-
 tests/qemu-iotests/051           |    7 +-
 tests/qemu-iotests/060.out       |    1 +
 tests/qemu-iotests/068           |    2 +-
 tests/qemu-iotests/082.out       |  284 ++++-
 tests/qemu-iotests/085.out       |   38 +-
 tests/qemu-iotests/087           |   39 +-
 tests/qemu-iotests/087.out       |   16 +-
 tests/qemu-iotests/114.out       |    5 +-
 tests/qemu-iotests/120           |    1 +
 tests/qemu-iotests/126           |  105 ++
 tests/qemu-iotests/126.out       |   23 +
 tests/qemu-iotests/134           |   20 +-
 tests/qemu-iotests/134.out       |   10 +-
 tests/qemu-iotests/140           |    9 +-
 tests/qemu-iotests/142           |   48 +-
 tests/qemu-iotests/144.out       |    4 +-
 tests/qemu-iotests/145           |   19 +-
 tests/qemu-iotests/149           |   25 +-
 tests/qemu-iotests/149.out       | 1002 +++++++++++-----
 tests/qemu-iotests/153.out       |    6 +
 tests/qemu-iotests/157           |   17 +-
 tests/qemu-iotests/157.out       |   16 +-
 tests/qemu-iotests/158           |   21 +-
 tests/qemu-iotests/158.out       |   14 +-
 tests/qemu-iotests/159           |    1 +
 tests/qemu-iotests/165           |  105 ++
 tests/qemu-iotests/165.out       |    5 +
 tests/qemu-iotests/170           |    1 +
 tests/qemu-iotests/171           |   14 +-
 tests/qemu-iotests/174           |    2 +-
 tests/qemu-iotests/177           |    3 +
 tests/qemu-iotests/177.out       |    5 +
 tests/qemu-iotests/181           |   23 +-
 tests/qemu-iotests/185.out       |    8 +-
 tests/qemu-iotests/188           |   76 ++
 tests/qemu-iotests/188.out       |   18 +
 tests/qemu-iotests/189           |   86 ++
 tests/qemu-iotests/189.out       |   26 +
 tests/qemu-iotests/check         |   18 +-
 tests/qemu-iotests/common        |   10 +-
 tests/qemu-iotests/common.config |   11 +
 tests/qemu-iotests/common.filter |    3 +-
 tests/qemu-iotests/common.qemu   |    9 +-
 tests/qemu-iotests/common.rc     |    3 +
 tests/qemu-iotests/group         |    4 +
 tests/rocker/all                 |   10 +-
 tests/tcg/cris/Makefile          |    8 +-
 tests/test-crypto-block.c        |    8 +-
 tests/test-hbitmap.c             |   19 +
 util/hbitmap.c                   |   51 +-
 util/oslib-posix.c               |   66 --
 util/oslib-win32.c               |   24 -
 112 files changed, 6714 insertions(+), 2942 deletions(-)
 create mode 100644 block/crypto.h
 create mode 100644 block/qcow2-bitmap.c
 create mode 100755 tests/qemu-iotests/126
 create mode 100644 tests/qemu-iotests/126.out
 create mode 100755 tests/qemu-iotests/165
 create mode 100644 tests/qemu-iotests/165.out
 create mode 100755 tests/qemu-iotests/188
 create mode 100644 tests/qemu-iotests/188.out
 create mode 100755 tests/qemu-iotests/189
 create mode 100644 tests/qemu-iotests/189.out
