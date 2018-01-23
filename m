Received: from eggs.gnu.org ([2001:4830:134:3::10]:37679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIU-0003FK-Ty
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIU-0007mn-0D
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:54 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIT-0007mS-Rh
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:53 -0500
Received: by mail-qt0-x242.google.com with SMTP id g14so17281689qti.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:30:53 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:20 -0300
Message-Id: <20180123033034.29493-5-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/18] sdcard: clean the SCR register and
 add few comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 56df5b660a..5d50d48097 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -297,10 +297,13 @@ static void sd_ocr_powerup(void *opaque)
 
 static void sd_reset_scr(SDState *sd)
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
2.15.1
