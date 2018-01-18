Received: from eggs.gnu.org ([2001:4830:134:3::10]:54175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ecLiH-0007dw-LS
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ecLiE-0000ei-Hv
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:43:25 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 18 Jan 2018 19:01:19 +0100
Message-Id: <20180119014313.445517456CD@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] sm501: Add missing break to case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Noticed by Coverity, forgotten in 5690d9ece

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 4f7dc59b2..134cbed 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -797,6 +797,7 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
         break;
     case SM501_COMMAND_LIST_STATUS:
         ret = 0x00180002; /* FIFOs are empty, everything idle */
+        break;
     case SM501_IRQ_MASK:
         ret = s->irq_mask;
         break;
-- 
2.7.6
