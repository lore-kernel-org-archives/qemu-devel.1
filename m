Received: from eggs.gnu.org ([209.51.188.92]:46864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDeY-0002z4-P8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDc5-0000Qk-8h
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:09:42 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  9 Jan 2019 14:08:43 +0100
Message-Id: <20190109130844.5172-6-laurent@vivier.eu>
In-Reply-To: <20190109130844.5172-1-laurent@vivier.eu>
References: <20190109130844.5172-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/6] trivial: Don't include isa.h if it is not
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Anthony Green <green@moxielogic.com>, John Snow <jsnow@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

These files don't seem to do anything related to ISA directly, so
there is no need to include isa.h here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1546615943-16274-1-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
index c0d241ba01..da3229a1f6 100644
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
index fe1ceeb0cd..b75154f99f 100644
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
index a3afe1fd29..885c16e938 100644
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
index 238f038d72..987d99c5ec 100644
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
index 87ae246d37..e5917d8f2e 100644
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
index 4b0ce09c5e..c6b6f7262d 100644
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
index de58c7be46..53e8e010a8 100644
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
index 639906cca3..709ee37e08 100644
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
index 1057850808..20f834e7da 100644
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
2.20.1
