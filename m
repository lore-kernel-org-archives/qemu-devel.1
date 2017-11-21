Received: from eggs.gnu.org ([2001:4830:134:3::10]:37018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC6-00039M-3u
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC2-0005Dj-Pa
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Nov 2017 16:10:10 +0100
Message-Id: <20171121151017.28158-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Block layer patches for 2.11.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

The following changes since commit d0dead3b6df7f6cd970ed02e8369ab8730aac9d3:

  scripts/make-release: ship u-boot source as a tarball (2017-11-21 12:48:20 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4fd0295c151e596944be2f8062c4563cdf9106a0:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-11-21' into queue-block (2017-11-21 15:09:54 +0100)

----------------------------------------------------------------
Block layer patches for 2.11.0-rc2

----------------------------------------------------------------
Alberto Garcia (1):
      block: Close a BlockDriverState completely even when bs->drv is NULL

Eric Blake (1):
      iotests: Fix 176 on 32-bit host

Kevin Wolf (6):
      block: Don't use BLK_PERM_CONSISTENT_READ for format probing
      block: Don't request I/O permission with BDRV_O_NO_IO
      block: Add errp to bdrv_snapshot_goto()
      block: Add errp to bdrv_all_goto_snapshot()
      block: Error out on load_vm with active dirty bitmaps
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-11-21' into queue-block

 include/block/snapshot.h   |  6 +++--
 block.c                    | 62 ++++++++++++++++++++++++----------------------
 block/block-backend.c      | 10 +++++---
 block/snapshot.c           | 45 +++++++++++++++++----------------
 migration/savevm.c         |  6 ++---
 qemu-img.c                 |  6 ++---
 tests/qemu-iotests/060     | 13 ++++++++++
 tests/qemu-iotests/060.out | 12 +++++++++
 tests/qemu-iotests/176     |  3 ++-
 tests/qemu-iotests/176.out |  8 +++---
 10 files changed, 103 insertions(+), 68 deletions(-)
