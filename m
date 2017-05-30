Received: from eggs.gnu.org ([2001:4830:134:3::10]:41613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFizL-0003QU-K0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFizK-0002W1-Ou
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:23:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 May 2017 17:22:49 +0200
Message-Id: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] Block migration (migrate -b) fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

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
 tests/qemu-iotests/183     | 143 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/183.out |  46 +++++++++++++++
 tests/qemu-iotests/group   |   1 +
 6 files changed, 215 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/183
 create mode 100644 tests/qemu-iotests/183.out

-- 
1.8.3.1
