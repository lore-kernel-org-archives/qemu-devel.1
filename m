Received: from eggs.gnu.org ([2001:4830:134:3::10]:57564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBY-0002by-Gk
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBX-0005Pc-Oy
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:20 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBX-0005PI-K6
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:19 -0500
Received: by mail-qt0-x241.google.com with SMTP id u10so5252527qtg.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 11:59:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 16:58:40 -0300
Message-Id: <20171213195852.30439-3-f4bug@amsat.org>
In-Reply-To: <20171213195852.30439-1-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/14] sdhci: clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h | 4 ----
 include/hw/sd/sdhci.h  | 4 +++-
 hw/sd/sdhci.c          | 1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 161177cf39..248fd027f9 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -24,8 +24,6 @@
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
-#include "hw/sd/sdhci.h"
-
 /* R/W SDMA System Address register 0x0 */
 #define SDHC_SYSAD                     0x00
 
@@ -227,6 +225,4 @@ enum {
     sdhc_gap_write  = 2   /* SDHC stopped at block gap during write operation */
 };
 
-extern const VMStateDescription sdhci_vmstate;
-
 #endif
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 0f0c3f1e64..1b6a98d578 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -26,17 +26,19 @@
 #define SDHCI_H
 
 #include "qemu-common.h"
-#include "hw/block/block.h"
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/sd/sd.h"
 
 /* SD/MMC host controller state */
 typedef struct SDHCIState {
+    /*< private >*/
     union {
         PCIDevice pcidev;
         SysBusDevice busdev;
     };
+
+    /*< public >*/
     SDBus sdbus;
     MemoryRegion iomem;
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e7cd3258a3..312b167bfa 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -28,6 +28,7 @@
 #include "sysemu/dma.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
+#include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 #include "sd-internal.h"
 #include "qemu/log.h"
-- 
2.15.1
