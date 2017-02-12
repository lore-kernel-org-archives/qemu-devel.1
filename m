Received: from eggs.gnu.org ([2001:4830:134:3::10]:47295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj86-0007CP-NN
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj85-0007Mg-S9
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:06 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:38:39 +0100
Message-Id: <20170212013844.6560-7-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 16/21] qemu-iotests: Add _unsupported_fmt helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Nir Soffer <nirsof@gmail.com>

This helper allows adding tests supporting any format expect the
specified formats. This may be useful to test that many formats behave
in a common way.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
Message-id: 20170201003120.23378-3-nirsof@gmail.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 4bb9b77807..a3d904fc22 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -355,6 +355,17 @@ _supported_fmt()
     _notrun "not suitable for this image format: $IMGFMT"
 }
 
+# tests whether $IMGFMT is one of the unsupported image format for a test
+#
+_unsupported_fmt()
+{
+    for f; do
+        if [ "$f" = "$IMGFMT" ]; then
+            _notrun "not suitable for this image format: $IMGFMT"
+        fi
+    done
+}
+
 # tests whether $IMGPROTO is one of the supported image protocols for a test
 #
 _supported_proto()
-- 
2.11.0
