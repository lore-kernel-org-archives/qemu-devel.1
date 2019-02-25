Received: from eggs.gnu.org ([209.51.188.92]:36885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI49-00086h-Pu
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI47-0000XG-G0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:42 +0100
Message-Id: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/71] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 59a568b57848b10e8a44518a889323f12ccdd8=
f4:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190222-pull-req=
uest' into staging (2019-02-25 12:49:07 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1b967e9f348d48788a2ab481d45398b80ce71fa6:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2019-02-25' into q=
ueue-block (2019-02-25 15:16:57 +0100)

----------------------------------------------------------------
Block layer patches:

- Block graph change fixes (avoid loops, cope with non-tree graphs)
- bdrv_set_aio_context() related fixes
- HMP snapshot commands: Use only tag, not the ID to identify snapshots
- qmeu-img, commit: Error path fixes
- block/nvme: Build fix for gcc 9
- MAINTAINERS updates
- Fix various issues with bdrv_refresh_filename()
- Fix various iotests
- Include LUKS overhead in qemu-img measure for qcow2
- A fix for vmdk's image creation interface

----------------------------------------------------------------
Alberto Garcia (2):
      commit: Replace commit_top_bs on failure after deleting the block j=
ob
      qcow2: Assert that L2 table offsets fit in the L1 table

Daniel Henrique Barboza (3):
      block/snapshot.c: eliminate use of ID input in snapshot operations
      block/snapshot: remove bdrv_snapshot_delete_by_id_or_name
      qcow2-snapshot: remove redundant find_snapshot_by_id_and_name call

Daniel P. Berrang=C3=A9 (1):
      qemu-img: fix error reporting for -object

Denis Plotnikov (1):
      block: don't set the same context

Jeff Cody (2):
      MAINTAINERS: Replace myself with John Snow for block jobs
      MAINTAINERS: Remove myself as block maintainer

Kevin Wolf (14):
      block-backend: Make blk_inc/dec_in_flight public
      virtio-blk: Increase in_flight for request restart BH
      nbd: Restrict connection_co reentrance
      io: Make qio_channel_yield() interruptible
      io: Remove redundant read/write_coroutine assignments
      nbd: Move nbd_read_eof() to nbd/client.c
      nbd: Use low-level QIOChannel API in nbd_read_eof()
      nbd: Increase bs->in_flight during AioContext switch
      block: Don't poll in bdrv_set_aio_context()
      block: Fix AioContext switch for drained node
      test-bdrv-drain: AioContext switch in drained section
      block: Use normal drain for bdrv_set_aio_context()
      aio-posix: Assert that aio_poll() is always called in home thread
      Merge remote-tracking branch 'mreitz/tags/pull-block-2019-02-25' in=
to queue-block

Max Reitz (42):
      block: Use bdrv_refresh_filename() to pull
      block: Use children list in bdrv_refresh_filename
      block: Skip implicit nodes for filename info
      block: Add BDS.auto_backing_file
      block: Respect backing bs in bdrv_refresh_filename
      iotests.py: Add filter_imgfmt()
      iotests.py: Add node_info()
      iotests: Add test for backing file overrides
      block: Make path_combine() return the path
      block: bdrv_get_full_backing_filename_from_...'s ret. val.
      block: bdrv_get_full_backing_filename's ret. val.
      block: Add bdrv_make_absolute_filename()
      block: Fix bdrv_find_backing_image()
      block: Add bdrv_dirname()
      blkverify: Make bdrv_dirname() return NULL
      quorum: Make bdrv_dirname() return NULL
      block/nbd: Make bdrv_dirname() return NULL
      block/nfs: Implement bdrv_dirname()
      block: Use bdrv_dirname() for relative filenames
      iotests: Add quorum case to test 110
      block: Add strong_runtime_opts to BlockDriver
      block: Add BlockDriver.bdrv_gather_child_options
      block: Generically refresh runtime options
      block: Purify .bdrv_refresh_filename()
      block: Do not copy exact_filename from format file
      block/nvme: Fix bdrv_refresh_filename()
      block/curl: Harmonize option defaults
      block/curl: Implement bdrv_refresh_filename()
      block/null: Generate filename even with latency-ns
      block: BDS options may lack the "driver" option
      iotests: Test json:{} filenames of internal BDSs
      iotests: Re-add filename filters
      iotests: Fix 237 for Python 2.x
      iotests: Remove superfluous rm from 232
      iotests: Fix 232 for LUKS
      iotests: Fix 207 to use QMP filters for qmp_log
      iotests.py: Add is_str()
      iotests.py: Filter filename in any string value
      iotests: Filter SSH paths
      iotests: Let 045 be run concurrently
      iotests.py: s/_/-/g on keys in qmp_log()
      iotests: Skip 211 on insufficient memory

Stefan Hajnoczi (2):
      qcow2: include LUKS payload overhead in qemu-img measure
      iotests: add LUKS payload overhead to 178 qemu-img measure test

Thomas Huth (1):
      block/nvme: Remove QEMU_PACKED from naturally aligned NVMeRegs stru=
ct

Vladimir Sementsov-Ogievskiy (3):
      block: improve should_update_child
      block: fix bdrv_check_perm for non-tree subgraph
      tests: add test-bdrv-graph-mod

yuchenlin (1):
      vmdk: false positive of compat6 with hwversion not set

 block/nbd-client.h               |   1 +
 include/block/block.h            |  16 +-
 include/block/block_int.h        |  53 +++-
 include/block/nbd.h              |   3 +-
 include/block/snapshot.h         |   3 -
 include/io/channel.h             |   9 +-
 include/sysemu/block-backend.h   |   2 +
 nbd/nbd-internal.h               |  19 --
 block.c                          | 597 +++++++++++++++++++++++++++------=
------
 block/blkdebug.c                 |  70 ++---
 block/blklogwrites.c             |  33 +--
 block/blkverify.c                |  29 +-
 block/block-backend.c            |   4 +-
 block/commit.c                   |   7 +-
 block/crypto.c                   |   8 +
 block/curl.c                     |  55 +++-
 block/gluster.c                  |  19 ++
 block/iscsi.c                    |  18 ++
 block/mirror.c                   |   3 +-
 block/nbd-client.c               |  36 ++-
 block/nbd.c                      |  46 +--
 block/nfs.c                      |  54 ++--
 block/null.c                     |  32 ++-
 block/nvme.c                     |  29 +-
 block/qapi.c                     |  16 +-
 block/qcow.c                     |  14 +-
 block/qcow2-cluster.c            |   3 +
 block/qcow2-snapshot.c           |   5 -
 block/qcow2.c                    |  89 +++++-
 block/qed.c                      |   7 +-
 block/quorum.c                   |  71 +++--
 block/raw-format.c               |  11 +-
 block/rbd.c                      |  14 +
 block/replication.c              |  10 +-
 block/sheepdog.c                 |  12 +
 block/snapshot.c                 |  25 +-
 block/ssh.c                      |  12 +
 block/throttle.c                 |   7 +
 block/vhdx-log.c                 |   1 +
 block/vmdk.c                     |  46 ++-
 block/vpc.c                      |   7 +
 block/vvfat.c                    |  12 +
 block/vxhs.c                     |  11 +
 blockdev.c                       |   8 +
 hw/block/virtio-blk.c            |   4 +
 io/channel.c                     |  22 +-
 nbd/client.c                     |  52 +++-
 qemu-img.c                       |  64 +++--
 tests/test-bdrv-drain.c          |  32 +++
 tests/test-bdrv-graph-mod.c      | 198 +++++++++++++
 util/aio-posix.c                 |   3 +-
 MAINTAINERS                      |  22 +-
 hmp-commands.hx                  |  32 ++-
 scripts/qemu.py                  |   5 +-
 tests/Makefile.include           |   2 +
 tests/qemu-iotests/045           |   2 +-
 tests/qemu-iotests/051.out       |   8 +-
 tests/qemu-iotests/051.pc.out    |   8 +-
 tests/qemu-iotests/110           |  29 +-
 tests/qemu-iotests/110.out       |   9 +-
 tests/qemu-iotests/178           |   8 +
 tests/qemu-iotests/178.out.qcow2 |  24 ++
 tests/qemu-iotests/206.out       |  56 ++--
 tests/qemu-iotests/207           |  10 +-
 tests/qemu-iotests/207.out       |  18 +-
 tests/qemu-iotests/210           |   5 +-
 tests/qemu-iotests/210.out       |  28 +-
 tests/qemu-iotests/211           |   9 +-
 tests/qemu-iotests/211.out       |  26 +-
 tests/qemu-iotests/212           |   5 +-
 tests/qemu-iotests/212.out       |  44 +--
 tests/qemu-iotests/213           |   5 +-
 tests/qemu-iotests/213.out       |  46 +--
 tests/qemu-iotests/224           | 139 +++++++++
 tests/qemu-iotests/224.out       |  18 ++
 tests/qemu-iotests/228           | 239 ++++++++++++++++
 tests/qemu-iotests/228.out       |  84 ++++++
 tests/qemu-iotests/232           |   5 +-
 tests/qemu-iotests/237           |   7 +-
 tests/qemu-iotests/237.out       |  54 ++--
 tests/qemu-iotests/common.rc     |   1 +
 tests/qemu-iotests/group         |   2 +
 tests/qemu-iotests/iotests.py    |  36 ++-
 83 files changed, 2191 insertions(+), 697 deletions(-)
 create mode 100644 tests/test-bdrv-graph-mod.c
 create mode 100755 tests/qemu-iotests/224
 create mode 100644 tests/qemu-iotests/224.out
 create mode 100755 tests/qemu-iotests/228
 create mode 100644 tests/qemu-iotests/228.out
