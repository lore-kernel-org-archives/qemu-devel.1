Received: from eggs.gnu.org ([2001:4830:134:3::10]:32852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMl-0006D2-J4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMk-00004w-JA
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:07 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMk-0008WM-EL
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:06 -0500
Received: by mail-qt0-x241.google.com with SMTP id m59so5833149qte.11
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:17 -0300
Message-Id: <20171213232025.24503-19-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/26] sdcard: move Memory Card registers
 together
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Aesthetic, but ease review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d8e3f60536..992236df75 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -85,14 +85,17 @@ struct SDState {
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
-    uint32_t ocr;
     QEMUTimer *ocr_power_timer;
-    uint8_t scr[8];
-    uint8_t cid[16];
-    uint8_t csd[16];
-    uint16_t rca;
-    uint32_t card_status;
-    uint8_t sd_status[64];
+
+    /* SD Memory Card Registers */
+    uint8_t cid[128 / BITS_PER_BYTE];       /* Card Identification Number */
+    uint16_t rca;                           /* Relative Card Address */
+    uint8_t csd[128 / BITS_PER_BYTE];       /* Card Specific Data */
+    uint8_t scr[64  / BITS_PER_BYTE];       /* SD Configuration */
+    uint32_t ocr;                           /* Operation Conditions */
+    uint8_t sd_status[512 / BITS_PER_BYTE]; /* SD Status */
+    uint32_t card_status;                   /* Card Status */
+
     uint32_t vhs;
     bool wp_switch;
     unsigned long *wp_groups;
-- 
2.15.1
