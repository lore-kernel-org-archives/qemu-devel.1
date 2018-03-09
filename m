Received: from eggs.gnu.org ([2001:4830:134:3::10]:59787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmz-00005D-Tn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmz-0006C2-4F
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmy-0006B9-TK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:41 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmx-00079d-W5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:39 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:21 +0000
Message-Id: <20180309172622.4277-25-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/25] sdhci: Fix a typo in comment
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180309153654.13518-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
