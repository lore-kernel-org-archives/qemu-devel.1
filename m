Received: from eggs.gnu.org ([2001:4830:134:3::10]:53602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyiTQ-0007cf-0x
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyiTP-0005BS-A2
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:24:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Apr 2017 19:23:31 +0200
Message-Id: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] migration: Call
 blk_resume_after_migration() for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org

This fixes one of the bugs that made us disable the op blocker assertions for
the 2.9 release.

Kevin Wolf (3):
  migration: Call blk_resume_after_migration() for postcopy
  qemu-iotests: Filter HMP readline escape characters
  qemu-iotests: Test postcopy migration

 migration/savevm.c               |   8 +++
 tests/qemu-iotests/028.out       |   2 +-
 tests/qemu-iotests/130.out       |   4 +-
 tests/qemu-iotests/181           | 117 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/181.out       |  38 +++++++++++++
 tests/qemu-iotests/common.filter |   7 +++
 tests/qemu-iotests/common.qemu   |   4 +-
 tests/qemu-iotests/group         |   1 +
 8 files changed, 176 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/181
 create mode 100644 tests/qemu-iotests/181.out

-- 
1.8.3.1
