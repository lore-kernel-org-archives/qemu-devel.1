Received: from eggs.gnu.org ([2001:4830:134:3::10]:45494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG3wI-0004qO-T2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG3wE-0004x3-11
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:50:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  8 May 2018 11:49:48 -0300
Message-Id: <20180508144948.14071-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/ide/ahci: Keep ALLWINNER_AHCI() macro
 internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-trivial@nongnu.org

The ALLWINNER_AHCI() macro is only used in ahci-allwinner.c.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/ahci_internal.h  | 3 ---
 hw/ide/ahci-allwinner.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 8c755d4ca1..1a25d6c039 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -375,7 +375,4 @@ void ahci_reset(AHCIState *s);
 
 #define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
 
-#define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
-                       TYPE_ALLWINNER_AHCI)
-
 #endif /* HW_IDE_AHCI_H */
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index 5397483fd8..2fd95078ba 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -24,6 +24,9 @@
 
 #include "trace.h"
 
+#define ALLWINNER_AHCI(obj) \
+        OBJECT_CHECK(AllwinnerAHCIState, (obj), TYPE_ALLWINNER_AHCI)
+
 #define ALLWINNER_AHCI_BISTAFR    ((0xa0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
 #define ALLWINNER_AHCI_BISTCR     ((0xa4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
 #define ALLWINNER_AHCI_BISTFCTR   ((0xa8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-- 
2.17.0
