Received: from eggs.gnu.org ([2001:4830:134:3::10]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQj-0006DY-0O
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQi-0002fI-7F
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:16:53 +0100
Message-Id: <1487960230-18054-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/19] qemu-iotests: add ability to exclude
 certain protocols from tests
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

Add the ability for shell script tests to exclude specific
protocols.  This is useful to allow all protocols except ones known to
not support a feature used in the test (e.g. .bdrv_create).

Signed-off-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/common.rc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index a3d904f..6c0fd4c 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -379,6 +379,18 @@ _supported_proto()
     _notrun "not suitable for this image protocol: $IMGPROTO"
 }
 
+# tests whether $IMGPROTO is specified as an unsupported image protocol for a test
+#
+_unsupported_proto()
+{
+    for f; do
+        if [ "$f" = "$IMGPROTO" ]; then
+            _notrun "not suitable for this image protocol: $IMGPROTO"
+            return
+        fi
+    done
+}
+
 # tests whether the host OS is one of the supported OSes for a test
 #
 _supported_os()
-- 
1.8.3.1
