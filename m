Received: from eggs.gnu.org ([2001:4830:134:3::10]:34588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1ciGTY-0005hT-UU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1ciGTT-0007Vq-Ts
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:16:08 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1ciGTT-0007VT-O5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:16:03 -0500
Received: by mail-pf0-x241.google.com with SMTP id p185so74139pfb.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 00:16:02 -0800 (PST)
From: Suramya Shah <shah.suramya@gmail.com>
Date: Mon, 27 Feb 2017 13:44:56 +0530
Message-Id: <20170227081456.7131-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [PATCH] Removed  support for depth!=32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Suramya Shah <shah.suramya@gmail.com>

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
---
 hw/display/sm501_template.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index f33e499..4e5801e 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -22,13 +22,7 @@
  * THE SOFTWARE.
  */
 
-#if DEPTH == 8
-#define BPP 1
-#define PIXEL_TYPE uint8_t
-#elif DEPTH == 15 || DEPTH == 16
-#define BPP 2
-#define PIXEL_TYPE uint16_t
-#elif DEPTH == 32
+#if DEPTH == 32
 #define BPP 4
 #define PIXEL_TYPE uint32_t
 #else
-- 
2.9.3
