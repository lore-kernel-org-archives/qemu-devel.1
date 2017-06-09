Received: from eggs.gnu.org ([2001:4830:134:3::10]:37692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJIQd-0006lN-0D
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJIQc-0001te-9s
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:50:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Jun 2017 13:50:00 +0200
Message-Id: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] commit: Fix completion with extra reference
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

Kevin Wolf (3):
  commit: Fix completion with extra reference
  qemu-iotests: Allow starting new qemu after cleanup
  qemu-iotests: Test exiting qemu with running job

 block/commit.c                 |   7 ++
 tests/qemu-iotests/185         | 189 +++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/185.out     |  59 +++++++++++++
 tests/qemu-iotests/common.qemu |   3 +
 tests/qemu-iotests/group       |   1 +
 5 files changed, 259 insertions(+)
 create mode 100755 tests/qemu-iotests/185
 create mode 100644 tests/qemu-iotests/185.out

-- 
1.8.3.1
