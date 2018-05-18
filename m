Received: from eggs.gnu.org ([2001:4830:134:3::10]:47603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJgKo-0001XD-Pd
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJgKn-0003WL-PJ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 16:26:02 +0200
Message-Id: <20180518142605.19846-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qemu-iotests: Fix NFS + raw
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

v2:
- Introduce $REMOTE_TEST_DIR to avoid breaking non-NFS cases (and to
  support additional files in the same directory besides $TEST_IMG)

Kevin Wolf (3):
  qemu-iotests: Fix paths for NFS
  qemu-iotests: Filter NFS paths
  qemu-iotests: 086 doesn't work with NFS

 tests/qemu-iotests/086           |  2 +-
 tests/qemu-iotests/common.filter |  6 ++++--
 tests/qemu-iotests/common.rc     | 12 +++++++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.13.6
