Received: from eggs.gnu.org ([2001:4830:134:3::10]:59569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZvgx-0004jl-4y
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZvgw-0006NJ-DU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:59:47 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 25 Jul 2017 10:59:36 +0200
Message-Id: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-iotests: Fix reference output for 186
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Commits 70f17a1 ('error: Revert unwanted change of warning messages')
and e1824e5 ('qemu-iotests: Test 'info block'') had a semantic merge
conflict, which results in failure for qemu-iotests case 186. Fix the
reference output to consider the changes of 70f17a1.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/186.out | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index b963b12..b8bf9a2 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -442,7 +442,7 @@ ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
     Cache mode:       writeback
 (qemu) quit
 
-warning: qemu-system-x86_64: -drive if=scsi,driver=null-co: bus=0,unit=0 is deprecated with this machine type
+qemu-system-x86_64: -drive if=scsi,driver=null-co: warning: bus=0,unit=0 is deprecated with this machine type
 Testing: -drive if=scsi,driver=null-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
@@ -451,7 +451,7 @@ scsi0-hd0 (NODE_NAME): null-co:// (null-co)
     Cache mode:       writeback
 (qemu) quit
 
-warning: qemu-system-x86_64: -drive if=scsi,media=cdrom: bus=0,unit=0 is deprecated with this machine type
+qemu-system-x86_64: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
 Testing: -drive if=scsi,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
@@ -460,7 +460,7 @@ scsi0-cd0: [not inserted]
     Removable device: not locked, tray closed
 (qemu) quit
 
-warning: qemu-system-x86_64: -drive if=scsi,driver=null-co,media=cdrom: bus=0,unit=0 is deprecated with this machine type
+qemu-system-x86_64: -drive if=scsi,driver=null-co,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
 Testing: -drive if=scsi,driver=null-co,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-- 
1.8.3.1
