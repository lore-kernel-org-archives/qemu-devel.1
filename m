Received: from eggs.gnu.org ([2001:4830:134:3::10]:37465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO0-0008H0-3K
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNw-0002ro-1g
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNv-0002qb-QT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:39 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNu-0002wj-K2
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:12 +0000
Message-Id: <1516109659-1557-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/24] sdhci: use qemu_log_mask(UNIMP) instead
 of fprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180115182436.2066-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bbe4570..7ffb1db 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -947,7 +947,8 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
         break;
     default:
-        ERRPRINT("bad %ub read: addr[0x%04x]\n", size, (int)offset);
+        qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
+                      "not implemented\n", size, offset);
         break;
     }
 
@@ -1153,8 +1154,8 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_update_irq(s);
         break;
     default:
-        ERRPRINT("bad %ub write offset: addr[0x%04x] <- %u(0x%x)\n",
-                 size, (int)offset, value >> shift, value >> shift);
+        qemu_log_mask(LOG_UNIMP, "SDHC wr_%ub @0x%02" HWADDR_PRIx " <- 0x%08x "
+                      "not implemented\n", size, offset, value >> shift);
         break;
     }
     DPRINT_L2("write %ub: addr[0x%04x] <- %u(0x%x)\n",
-- 
2.7.4
