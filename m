Received: from eggs.gnu.org ([2001:4830:134:3::10]:41962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdfr2-00016R-Mv
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdfr1-0004Ko-PJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:21:24 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 14 Feb 2017 11:21:17 -0500
Message-Id: <7b453d448bc0c0d0e78dd8dd4359590e1cbbe3b8.1487088544.git.jcody@redhat.com>
In-Reply-To: <cover.1487088544.git.jcody@redhat.com>
References: <cover.1487088544.git.jcody@redhat.com>
In-Reply-To: <cover.1487088544.git.jcody@redhat.com>
References: <cover.1487088544.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-iotests: add ability to exclude
 certain protocols from tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Add the ability for shell script tests to exclude specific
protocols.  This is useful to allow all protocols except ones known to
not support a feature used in the test (e.g. .bdrv_create).

Signed-off-by: Jeff Cody <jcody@redhat.com>
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
2.9.3
