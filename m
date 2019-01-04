Received: from eggs.gnu.org ([208.118.235.92]:59986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRSf-0006Ql-Id
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRSc-0004MZ-FA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:32:37 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  4 Jan 2019 16:32:23 +0100
Message-Id: <1546615943-16274-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] trivial: Don't include isa.h if it is not
 really necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

These files don't seem to do anything related to ISA directly, so
there is no need to include isa.h here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/ramfb-standalone.c | 1 -
 hw/ide/pci.c                  | 1 -
 hw/ide/piix.c                 | 1 -
 hw/ide/via.c                  | 1 -
 hw/misc/macio/mac_dbdma.c     | 1 -
 hw/moxie/moxiesim.c           | 1 -
 hw/nvram/fw_cfg.c             | 1 -
 hw/sparc/sun4m.c              | 1 -
 hw/timer/i8254.c              | 1 -
 9 files changed, 9 deletions(-)

diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index c0d241b..da3229a 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/loader.h"
-#include "hw/isa/isa.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index fe1ceeb..b75154f 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "hw/isa/isa.h"
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "hw/ide/pci.h"
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a3afe1f..885c16e 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "hw/isa/isa.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 238f038..987d99c 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "hw/isa/isa.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 87ae246..e5917d8 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -38,7 +38,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/isa/isa.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 4b0ce09..c6b6f72 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -31,7 +31,6 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
-#include "hw/isa/isa.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3cb726f..62e9464 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -27,7 +27,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "hw/boards.h"
-#include "hw/isa/isa.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
 #include "trace.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 639906c..709ee37 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -37,7 +37,6 @@
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/scsi/esp.h"
-#include "hw/isa/isa.h"
 #include "hw/nvram/sun_nvram.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 1057850..20f834e 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/isa/isa.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
-- 
1.8.3.1
