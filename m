Received: from eggs.gnu.org ([2001:4830:134:3::10]:35043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dDANW-0005ib-DR
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dDANT-0000aF-Jt
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:01:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 May 2017 16:01:00 +0200
Message-Id: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Block migration (migrate -b) fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (4):
  block: Fix anonymous BBs in blk_root_inactivate()
  migration: Inactivate images after .save_live_complete_precopy()
  migration/block: Clean up BBs in block_save_complete()
  qemu-iotests: Block migration test

 block/block-backend.c      |   2 +-
 migration/block.c          |  22 +++++++--
 migration/migration.c      |  12 +++--
 tests/qemu-iotests/183     | 121 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/183.out |  48 ++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 6 files changed, 195 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/183
 create mode 100644 tests/qemu-iotests/183.out

-- 
1.8.3.1
