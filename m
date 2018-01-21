Received: from eggs.gnu.org ([2001:4830:134:3::10]:36068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Gg-0000YR-2p
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Ge-0007Lt-VE
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 21 Jan 2018 16:33:50 +1100
Message-Id: <20180121053353.25970-10-david@gibson.dropbear.id.au>
In-Reply-To: <20180121053353.25970-1-david@gibson.dropbear.id.au>
References: <20180121053353.25970-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/12] sm501: Add missing break to case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Noticed by Coverity, forgotten in 5690d9ece

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 4f7dc59b25..134cbed607 100644
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
2.14.3
