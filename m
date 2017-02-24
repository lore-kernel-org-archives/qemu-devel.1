Received: from eggs.gnu.org ([2001:4830:134:3::10]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQj-0006Dz-8d
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQi-0002fV-CR
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:16:52 +0100
Message-Id: <1487960230-18054-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/19] qemu-iotests: Test 137 only supports
 'file' protocol
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

From: Jeff Cody <jcody@redhat.com>

Since test 137 make uses of qcow2.py, only local files are supported.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/137 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index e5e30de..eb91e51 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto generic
+_supported_proto file
 _supported_os Linux
 
 
-- 
1.8.3.1
