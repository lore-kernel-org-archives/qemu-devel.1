Received: from eggs.gnu.org ([2001:4830:134:3::10]:60641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwsh-0002UX-PJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwsh-0005Th-4y
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:15 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Aug 2018 17:27:51 +0930
Message-Id: <20180807075757.7242-2-joel@jms.id.au>
In-Reply-To: <20180807075757.7242-1-joel@jms.id.au>
References: <20180807075757.7242-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH 1/7] aspeed_sdmc: Extend number of valid
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

The SDMC on the ast2500 has 170 registers.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/misc/aspeed_sdmc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 551c8afdf4be..682f0f5d56dc 100644
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
2.17.1
