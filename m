Received: from eggs.gnu.org ([2001:4830:134:3::10]:44241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dG0JF-0001jB-Pn
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dG0JF-0004pq-0X
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:52:57 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 31 May 2017 11:52:43 +0200
Message-Id: <1496224367-24935-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] Block migration (migrate -b) fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

v3:
- Restricted test to formats without migration blockers [Jeff]
- Added timeout for migration completion in test [Jeff]
- Removed remaining tabs copied from another test case [Eric]
- Updated reference output (SHUTDOWN events) after rebase

v2:
- Detect when migrate -b is compiled out [Eric]
- Switched the whole test to QMP for this, HMP is a bit hard to
  deal with

Kevin Wolf (4):
  block: Fix anonymous BBs in blk_root_inactivate()
  migration: Inactivate images after .save_live_complete_precopy()
  migration/block: Clean up BBs in block_save_complete()
  qemu-iotests: Block migration test

 block/block-backend.c      |   2 +-
 migration/block.c          |  22 +++++--
 migration/migration.c      |  12 ++--
 tests/qemu-iotests/183     | 140 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/183.out |  46 +++++++++++++++
 tests/qemu-iotests/group   |   1 +
 6 files changed, 212 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/183
 create mode 100644 tests/qemu-iotests/183.out

-- 
1.8.3.1
