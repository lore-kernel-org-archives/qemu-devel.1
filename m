Received: from eggs.gnu.org ([2001:4830:134:3::10]:38485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosii-0004v7-6d
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosih-0001mO-7U
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:40 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosih-0001ke-0P
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:39 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosif-00024x-TU
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:37 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:55 +0000
Message-Id: <20180222152307.7499-21-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/32] sdcard: clean the SCR register and add
 few comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3526269dbe..c87142d648 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -298,10 +298,13 @@ static void sd_ocr_powerup(void *opaque)
 
 static void sd_set_scr(SDState *sd)
 {
-    sd->scr[0] = 0x00;		/* SCR Structure */
-    sd->scr[1] = 0x2f;		/* SD Security Support */
-    sd->scr[2] = 0x00;
+    sd->scr[0] = (0 << 4)       /* SCR version 1.0 */
+                 | 0;           /* Spec Versions 1.0 and 1.01 */
+    sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
+                 | 0b0101;      /* 1-bit or 4-bit width bus modes */
+    sd->scr[2] = 0x00;          /* Extended Security is not supported. */
     sd->scr[3] = 0x00;
+    /* reserved for manufacturer usage */
     sd->scr[4] = 0x00;
     sd->scr[5] = 0x00;
     sd->scr[6] = 0x00;
-- 
2.16.1
