Received: from eggs.gnu.org ([2001:4830:134:3::10]:55015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7g-0002gK-Ve
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7g-0001bQ-AP
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:53 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:42875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7g-0001bA-53
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:52 -0400
Received: by mail-qt0-x244.google.com with SMTP id c2-v6so27950206qtn.9
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:59:06 -0300
Message-Id: <20180504155918.21287-9-f4bug@amsat.org>
In-Reply-To: <20180504155918.21287-1-f4bug@amsat.org>
References: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/20] sdcard: Fix sd_crc*() style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

Fix style to keep patchew/checkpatch happy when moving this code
in the next patch.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3708ec1d72..a28ef8de5e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -243,12 +243,14 @@ static uint8_t sd_crc7(const void *message, size_t width)
     uint8_t shift_reg = 0x00;
     const uint8_t *msg = (const uint8_t *)message;
 
-    for (i = 0; i < width; i ++, msg ++)
-        for (bit = 7; bit >= 0; bit --) {
+    for (i = 0; i < width; i++, msg++) {
+        for (bit = 7; bit >= 0; bit--) {
             shift_reg <<= 1;
-            if ((shift_reg >> 7) ^ ((*msg >> bit) & 1))
+            if ((shift_reg >> 7) ^ ((*msg >> bit) & 1)) {
                 shift_reg ^= 0x89;
+            }
         }
+    }
 
     return shift_reg;
 }
@@ -260,12 +262,14 @@ static uint16_t sd_crc16(const void *message, size_t width)
     const uint16_t *msg = (const uint16_t *)message;
     width <<= 1;
 
-    for (i = 0; i < width; i ++, msg ++)
-        for (bit = 15; bit >= 0; bit --) {
+    for (i = 0; i < width; i++, msg++) {
+        for (bit = 15; bit >= 0; bit--) {
             shift_reg <<= 1;
-            if ((shift_reg >> 15) ^ ((*msg >> bit) & 1))
+            if ((shift_reg >> 15) ^ ((*msg >> bit) & 1)) {
                 shift_reg ^= 0x1011;
+            }
         }
+    }
 
     return shift_reg;
 }
-- 
2.17.0
