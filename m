Received: from eggs.gnu.org ([2001:4830:134:3::10]:50410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK51-0006Rx-FJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4y-0008Fl-T6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:11 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4y-0008FD-MK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:08 -0500
Received: by mail-wr0-x243.google.com with SMTP id v18so9417401wrv.0
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:37:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Mar 2018 16:36:53 +0100
Message-Id: <20180309153654.13518-8-f4bug@amsat.org>
In-Reply-To: <20180309153654.13518-1-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/8] sdhci: Fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 97b4a473c8..1b828b104d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -433,13 +433,13 @@ static void sdhci_read_block_from_card(SDHCIState *s)
     for (index = 0; index < blk_size; index++) {
         data = sdbus_read_data(&s->sdbus);
         if (!FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
-            /* Device is not in tunning */
+            /* Device is not in tuning */
             s->fifo_buffer[index] = data;
         }
     }
 
     if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
-        /* Device is in tunning */
+        /* Device is in tuning */
         s->hostctl2 &= ~R_SDHC_HOSTCTL2_EXECUTE_TUNING_MASK;
         s->hostctl2 |= R_SDHC_HOSTCTL2_SAMPLING_CLKSEL_MASK;
         s->prnsts &= ~(SDHC_DAT_LINE_ACTIVE | SDHC_DOING_READ |
-- 
2.16.2
