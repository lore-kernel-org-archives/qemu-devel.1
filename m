Received: from eggs.gnu.org ([2001:4830:134:3::10]:35586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaH-0002dI-RE
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaG-0001Nt-U1
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtaG-0001Nl-NT
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaF-0003wh-Sv
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:35 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:11 +0000
Message-Id: <1482852077-19397-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/25] aspeed: change SoC revision of the
 palmetto-bmc machine
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

The palmetto BMC machine uses a AST2400 revision A1 SoC.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1480434248-27138-11-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3509011..bc70b38 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -81,7 +81,7 @@ enum {
 
 static const AspeedBoardConfig aspeed_boards[] = {
     [PALMETTO_BMC] = {
-        .soc_name  = "ast2400-a0",
+        .soc_name  = "ast2400-a1",
         .hw_strap1 = PALMETTO_BMC_HW_STRAP1,
         .fmc_model = "n25q256a",
         .spi_model = "mx25l25635e",
-- 
2.7.4
