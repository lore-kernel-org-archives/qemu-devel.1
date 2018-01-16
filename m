Received: from eggs.gnu.org ([2001:4830:134:3::10]:37523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO5-0008Ng-H5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNz-0002v4-Se
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNz-0002u6-LE
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNy-0002yy-MD
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:17 +0000
Message-Id: <1516109659-1557-23-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/24] sdhci: Implement write method of
 ACMD12ERRSTS register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180115182436.2066-13-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d4fcebc..9bdbcd0 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1129,6 +1129,9 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         }
         sdhci_update_irq(s);
         break;
+    case SDHC_ACMD12ERRSTS:
+        MASKED_WRITE(s->acmd12errsts, mask, value);
+        break;
 
     case SDHC_CAPAB:
     case SDHC_CAPAB + 4:
-- 
2.7.4
