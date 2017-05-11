Received: from eggs.gnu.org ([2001:4830:134:3::10]:36097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9p-0001Pe-6E
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8p9o-0006n1-Fc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:11 +0200
Message-Id: <1494513181-7900-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/58] iotests: 046: Prepare for image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

The qemu-img info command is executed while VM is running, add -U option
to avoid the image locking error.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
1.8.3.1
