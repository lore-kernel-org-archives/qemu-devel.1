Received: from eggs.gnu.org ([2001:4830:134:3::10]:40497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJM9M-0006qH-P6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJM9H-0006xh-Fw
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:53:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 17 May 2018 18:52:50 +0200
Message-Id: <20180517165253.19958-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] qemu-iotests: Fix NFS + raw
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

This series fixes the NFS support in qemu-iotests, at least as far as
raw is concerned. More fixes would be needed for NFS with qcow2.

Kevin Wolf (3):
  qemu-iotests: Fix paths for NFS
  qemu-iotests: Filter NFS paths
  qemu-iotests: 086 doesn't work with NFS

 tests/qemu-iotests/086           | 2 +-
 tests/qemu-iotests/common.filter | 6 ++++--
 tests/qemu-iotests/common.rc     | 7 ++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.13.6
