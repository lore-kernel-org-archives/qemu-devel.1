Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxem-00021J-JU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxei-0002ci-Jz
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:44:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:06 +0300
Message-Id: <9b04d0e3c155ad318b40b0e01bf997faad51a9ca.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 02/31] hw/block/m25p80: Fix typo in local macro
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/block/m25p80.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index e904514..2d6eb46 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -147,7 +147,7 @@ typedef struct FlashPartInfo {
 #define CFG_DUMMY_CLK_LEN 4
 #define NVCFG_DUMMY_CLK_POS 12
 #define VCFG_DUMMY_CLK_POS 4
-#define EVCFG_OUT_DRIVER_STRENGHT_DEF 7
+#define EVCFG_OUT_DRIVER_STRENGTH_DEF 7
 #define EVCFG_VPP_ACCELERATOR (1 << 3)
 #define EVCFG_RESET_HOLD_ENABLED (1 << 4)
 #define NVCFG_DUAL_IO_MASK (1 << 2)
@@ -747,7 +747,7 @@ static void reset_memory(Flash *s)
                             );
 
         s->enh_volatile_cfg = 0;
-        s->enh_volatile_cfg |= EVCFG_OUT_DRIVER_STRENGHT_DEF;
+        s->enh_volatile_cfg |= EVCFG_OUT_DRIVER_STRENGTH_DEF;
         s->enh_volatile_cfg |= EVCFG_VPP_ACCELERATOR;
         s->enh_volatile_cfg |= EVCFG_RESET_HOLD_ENABLED;
         if (s->nonvolatile_cfg & NVCFG_DUAL_IO_MASK) {
-- 
2.1.4
