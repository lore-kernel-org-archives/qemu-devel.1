Received: from eggs.gnu.org ([2001:4830:134:3::10]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO3-0008Lp-UV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNy-0002tc-DE
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNy-0002sv-6C
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNx-0002y6-79
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:15 +0000
Message-Id: <1516109659-1557-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/24] sdhci: rename the SDHC_CAPAB register
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
Message-id: 20180115182436.2066-11-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci-internal.h | 2 +-
 hw/sd/sdhci.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index e941bc2..fc807f0 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -174,7 +174,7 @@
 #define SDHC_ACMD12ERRSTS              0x3C
 
 /* HWInit Capabilities Register 0x05E80080 */
-#define SDHC_CAPAREG                   0x40
+#define SDHC_CAPAB                     0x40
 #define SDHC_CAN_DO_DMA                0x00400000
 #define SDHC_CAN_DO_ADMA2              0x00080000
 #define SDHC_CAN_DO_ADMA1              0x00100000
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4265b6a..c4e486e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -898,7 +898,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
     case SDHC_ACMD12ERRSTS:
         ret = s->acmd12errsts;
         break;
-    case SDHC_CAPAREG:
+    case SDHC_CAPAB:
         ret = s->capareg;
         break;
     case SDHC_MAXCURR:
-- 
2.7.4
