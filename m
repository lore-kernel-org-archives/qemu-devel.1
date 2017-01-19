Received: from eggs.gnu.org ([2001:4830:134:3::10]:47753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPy-00016g-NZ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPr-0005EC-NW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:22 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPr-000582-GL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPb-000360-B8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:09:59 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:26 +0000
Message-Id: <1484834995-26826-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/36] aspeed/smc: remove call to reset in
 realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

This is useless as reset will be called later on.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
Message-id: 1483979087-32663-2-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 78f5aed..8a7217d 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -541,8 +541,6 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->cs_lines[i]);
     }
 
-    aspeed_smc_reset(dev);
-
     /* The memory region for the controller registers */
     memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_smc_ops, s,
                           s->ctrl->name, ASPEED_SMC_R_MAX * 4);
-- 
2.7.4
