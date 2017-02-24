Received: from eggs.gnu.org ([2001:4830:134:3::10]:49780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQj-0006EF-GE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQi-0002fa-GJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:16:51 +0100
Message-Id: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/19] Block layer patches
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

The following changes since commit 63f495beb4007de5444614125fd6fd178ca6e2b1:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-cve-2017-2620-20170224-1' into staging (2017-02-24 13:55:26 +0000)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to d185cf0ec64cd183218ca7e0810d9130c96ebebc:

  tests: Use opened block node for block job tests (2017-02-24 16:09:23 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Jeff Cody (3):
      qemu-iotests: Test 137 only supports 'file' protocol
      qemu-iotests: add ability to exclude certain protocols from tests
      qemu-iotests: redirect nbd server stdout to /dev/null

John Snow (1):
      iotests: Fix another race in 030

Kevin Wolf (11):
      blockdev: Use BlockBackend to resize in qmp_block_resize()
      qcow2: Use BB for resizing in qcow2_amend_options()
      mirror: Resize active commit base in mirror_run()
      block: Pass BdrvChild to bdrv_truncate()
      block: Attach bs->file only during .bdrv_open()
      block: Factor out bdrv_open_child_bs()
      block: Use BlockBackend for image probing
      block: Factor out bdrv_open_driver()
      block: Add bdrv_new_open_driver()
      vvfat: Use opened node as backing file
      tests: Use opened block node for block job tests

Nir Soffer (4):
      qemu-img: Do not truncate before preallocation
      qemu-img: Add tests for raw image preallocation
      qemu-img: Truncate before full preallocation
      qemu-img: Improve documentation for PREALLOC_MODE_FALLOC

 block.c                       | 265 +++++++++++++++++++++++++++---------------
 block/blkdebug.c              |   2 +-
 block/block-backend.c         |   2 +-
 block/bochs.c                 |   6 +
 block/cloop.c                 |   6 +
 block/crypto.c                |   8 +-
 block/dmg.c                   |   6 +
 block/file-posix.c            |  28 +++--
 block/mirror.c                |  50 ++++----
 block/parallels.c             |  14 ++-
 block/qcow.c                  |  10 +-
 block/qcow2-refcount.c        |   2 +-
 block/qcow2.c                 |  28 ++++-
 block/qed.c                   |  18 ++-
 block/raw-format.c            |   8 +-
 block/replication.c           |   6 +
 block/vdi.c                   |   6 +
 block/vhdx-log.c              |   2 +-
 block/vhdx.c                  |   8 +-
 block/vmdk.c                  |   6 +
 block/vpc.c                   |   6 +
 block/vvfat.c                 |  10 +-
 blockdev.c                    |   7 +-
 include/block/block.h         |   4 +-
 tests/qemu-iotests/030        |   5 +-
 tests/qemu-iotests/051.out    |   4 +-
 tests/qemu-iotests/051.pc.out |   4 +-
 tests/qemu-iotests/137        |   2 +-
 tests/qemu-iotests/175        |  61 ++++++++++
 tests/qemu-iotests/175.out    |  18 +++
 tests/qemu-iotests/common.rc  |  14 ++-
 tests/qemu-iotests/group      |   1 +
 tests/test-blockjob-txn.c     |   6 +-
 tests/test-blockjob.c         |   6 +-
 34 files changed, 461 insertions(+), 168 deletions(-)
 create mode 100755 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out
