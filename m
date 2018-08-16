Received: from eggs.gnu.org ([2001:4830:134:3::10]:59045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQZ-0000Q6-5q
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQY-0001yO-EA
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQY-0001wM-6Q
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQX-00007U-7Y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:26 +0100
Message-Id: <20180816133438.17061-19-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/30] aspeed_sdmc: Extend number of valid
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Joel Stanley <joel@jms.id.au>

The SDMC on the ast2500 has 170 registers.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180807075757.7242-2-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_sdmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 551c8afdf4b..682f0f5d56d 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -14,7 +14,7 @@
 #define TYPE_ASPEED_SDMC "aspeed.sdmc"
 #define ASPEED_SDMC(obj) OBJECT_CHECK(AspeedSDMCState, (obj), TYPE_ASPEED_SDMC)
 
-#define ASPEED_SDMC_NR_REGS (0x8 >> 2)
+#define ASPEED_SDMC_NR_REGS (0x174 >> 2)
 
 typedef struct AspeedSDMCState {
     /*< private >*/
-- 
2.18.0
