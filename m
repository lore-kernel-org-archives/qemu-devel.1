Received: from eggs.gnu.org ([2001:4830:134:3::10]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaL-0002gT-Cg
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaK-0001Od-Mc
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtaK-0001OI-Fg
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:40 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaJ-0003x4-Kc
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:39 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:12 +0000
Message-Id: <1482852077-19397-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/25] aspeed/scu: fix SCU region size
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

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1480434248-27138-12-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 34e8638..95022d3 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -86,7 +86,7 @@
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
 #define PROT_KEY_UNLOCK 0x1688A8A8
-#define SCU_IO_REGION_SIZE 0x20000
+#define SCU_IO_REGION_SIZE 0x1000
 
 static const uint32_t ast2400_a0_resets[ASPEED_SCU_NR_REGS] = {
      [SYS_RST_CTRL]    = 0xFFCFFEDCU,
-- 
2.7.4
