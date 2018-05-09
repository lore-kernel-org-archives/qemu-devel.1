Received: from eggs.gnu.org ([2001:4830:134:3::10]:58450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4V-0004P0-Ic
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4S-0002Tw-GZ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:19 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4S-0002T0-CL
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:16 -0400
Received: by mail-qk0-x241.google.com with SMTP id p186so26492486qkd.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:47 -0300
Message-Id: <20180509034658.26455-4-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/14] sdcard: Fix sd_crc*() style
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/sd/sd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index eb6dd5482e..27a70896cd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -242,12 +242,14 @@ static uint8_t sd_crc7(const void *message, size_t width)
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
@@ -259,12 +261,14 @@ static uint16_t sd_crc16(const void *message, size_t width)
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
