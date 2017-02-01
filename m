Received: from eggs.gnu.org ([2001:4830:134:3::10]:41286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYiqf-0003zn-Sc
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYiqf-0001P0-4p
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:32:33 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Wed,  1 Feb 2017 02:31:19 +0200
Message-Id: <20170201003120.23378-3-nirsof@gmail.com>
In-Reply-To: <20170201003120.23378-1-nirsof@gmail.com>
References: <20170201003120.23378-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH v5 2/3] qemu-iotests: Add _unsupported_fmt
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

This helper allows adding tests supporting any format expect the
specified formats. This may be useful to test that many formats behave
in a common way.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 tests/qemu-iotests/common.rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 3213765..c6d5d81 100644
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
2.9.3
