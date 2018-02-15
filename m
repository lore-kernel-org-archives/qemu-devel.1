Received: from eggs.gnu.org ([2001:4830:134:3::10]:55668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfJ-0006DA-Ui
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfJ-00014h-3V
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:05 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfI-00014J-Vy
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:05 -0500
Received: by mail-qk0-x241.google.com with SMTP id g129so1521854qkb.13
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:06:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:05:33 -0300
Message-Id: <20180215220540.6556-5-f4bug@amsat.org>
In-Reply-To: <20180215220540.6556-1-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 04/11] sdcard: replace fprintf() by
 qemu_hexdump()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8f72cde534..ceab263970 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -44,13 +44,6 @@
 
 //#define DEBUG_SD 1
 
-#ifdef DEBUG_SD
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
-
 #define ACMD41_ENQUIRY_MASK     0x00ffffff
 #define OCR_POWER_UP            0x80000000
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
@@ -1632,14 +1625,7 @@ send_response:
     }
 
 #ifdef DEBUG_SD
-    if (rsplen) {
-        int i;
-        DPRINTF("Response:");
-        for (i = 0; i < rsplen; i++) {
-            DPRINTF(" %02x", response[i]);
-        }
-        DPRINTF(" state %d\n", sd->state);
-    }
+    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
 #endif
 
     return rsplen;
-- 
2.16.1
