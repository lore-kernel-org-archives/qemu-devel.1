Received: from eggs.gnu.org ([2001:4830:134:3::10]:55374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16tv-0007AX-MV
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16tu-0003Q1-Tr
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 20 Apr 2017 15:52:25 +0800
Message-Id: <20170420075237.18219-9-famz@redhat.com>
In-Reply-To: <20170420075237.18219-1-famz@redhat.com>
References: <20170420075237.18219-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v13 08/20] iotests: 046: Prepare for image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The qemu-img info command is executed while VM is running, add -U option
to avoid the image locking error.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/046 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index e528b67..f2ebecf 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -192,7 +192,7 @@ echo "== Verify image content =="
 
 function verify_io()
 {
-    if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" | grep "compat: 0.10" > /dev/null); then
+    if ($QEMU_IMG info -U -f "$IMGFMT" "$TEST_IMG" | grep "compat: 0.10" > /dev/null); then
         # For v2 images, discarded clusters are read from the backing file
         # Keep the variable empty so that the backing file value can be used as
         # the default below
-- 
2.9.3
