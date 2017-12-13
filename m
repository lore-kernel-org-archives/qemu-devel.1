Received: from eggs.gnu.org ([2001:4830:134:3::10]:32876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMp-0006GW-5U
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMo-00008r-7e
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:11 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMo-00008Z-48
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:10 -0500
Received: by mail-qt0-x243.google.com with SMTP id a16so5894273qtj.3
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:18 -0300
Message-Id: <20171213232025.24503-20-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/26] sdcard: add DSR register
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 992236df75..8a10e28080 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -90,6 +90,7 @@ struct SDState {
     /* SD Memory Card Registers */
     uint8_t cid[128 / BITS_PER_BYTE];       /* Card Identification Number */
     uint16_t rca;                           /* Relative Card Address */
+    uint16_t dsr;                           /* Driver Stage */
     uint8_t csd[128 / BITS_PER_BYTE];       /* Card Specific Data */
     uint8_t scr[64  / BITS_PER_BYTE];       /* SD Configuration */
     uint32_t ocr;                           /* Operation Conditions */
@@ -458,6 +459,7 @@ static void sd_reset(DeviceState *dev)
 
     sd_set_state(sd, sd_idle_state);
     sd->rca = 0x0000;
+    sd->dsr = 0x0404;
     sd_reset_ocr(sd);
     sd_reset_scr(sd);
     sd_reset_cid(sd);
-- 
2.15.1
