Received: from eggs.gnu.org ([2001:4830:134:3::10]:40850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTAF-0001nv-45
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTA8-000065-Of
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:47 -0500
Received: from ozlabs.org ([103.22.144.67]:55497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ecTA8-0008V0-DN
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 19 Jan 2018 20:40:12 +1100
Message-Id: <20180119094015.28266-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180119094015.28266-1-david@gibson.dropbear.id.au>
References: <20180119094015.28266-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/13] sm501: Add missing break to case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, lvivier@redhat.com, agraf@suse.de, qemu-ppc@nognu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

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
