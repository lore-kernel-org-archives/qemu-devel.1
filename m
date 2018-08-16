Received: from eggs.gnu.org ([2001:4830:134:3::10]:59076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQc-0000Yv-IR
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQa-0001zc-7F
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQZ-0001yS-Vr
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQZ-00008N-41
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:28 +0100
Message-Id: <20180816133438.17061-21-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/30] aspeed_sdmc: Set 'cache initial sequence'
 always true
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

The SDRAM training routine sets the 'Enable cache initial' bit, and then
waits for the 'cache initial sequence' to be done.

Have it always return done, as there is no other side effects that the
model needs to implement. This allows the upstream u-boot training to
proceed on the ast2500-evb board.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180807075757.7242-4-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_sdmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 24fd4aee2d8..9ece545c4ff 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -226,6 +226,7 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
         s->ram_bits = ast2500_rambits(s);
         s->fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
             ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
+            ASPEED_SDMC_CACHE_INITIAL_DONE |
             ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
         break;
     default:
-- 
2.18.0
