Received: from eggs.gnu.org ([209.51.188.92]:36863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bet-0005dF-HZ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bes-00006N-2G
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2Beq-0008SK-C0
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:12 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Mar 2019 10:18:38 +0100
Message-Id: <1552036723-1949-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1552036723-1949-1-git-send-email-thuth@redhat.com>
References: <1552036723-1949-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] hw: Remove unused 'hw/devices.h' include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/alpha/typhoon.c                       | 1 -
 hw/arm/allwinner-a10.c                   | 1 -
 hw/arm/collie.c                          | 1 -
 hw/arm/cubieboard.c                      | 1 -
 hw/arm/highbank.c                        | 1 -
 hw/arm/mps2-tz.c                         | 1 -
 hw/arm/musicpal.c                        | 1 -
 hw/arm/nrf51_soc.c                       | 1 -
 hw/arm/spitz.c                           | 1 -
 hw/arm/virt.c                            | 1 -
 hw/arm/z2.c                              | 1 -
 hw/display/sm501.c                       | 1 -
 hw/hppa/dino.c                           | 1 -
 hw/intc/allwinner-a10-pic.c              | 1 -
 hw/lm32/lm32_boards.c                    | 1 -
 hw/lm32/milkymist.c                      | 1 -
 hw/microblaze/petalogix_ml605_mmu.c      | 1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 -
 hw/net/dp8393x.c                         | 1 -
 hw/ppc/virtex_ml507.c                    | 1 -
 hw/sh4/r2d.c                             | 1 -
 hw/tricore/tricore_testboard.c           | 1 -
 hw/usb/tusb6010.c                        | 1 -
 23 files changed, 23 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 397e2dc..9d57361 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -11,7 +11,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "hw/devices.h"
 #include "sysemu/sysemu.h"
 #include "alpha_sys.h"
 #include "exec/address-spaces.h"
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index df0d079..06ec6f4 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -20,7 +20,6 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/devices.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/misc/unimp.h"
=20
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 48b732c..3ca4e07 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -12,7 +12,6 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
-#include "hw/devices.h"
 #include "strongarm.h"
 #include "hw/arm/arm.h"
 #include "hw/block/flash.h"
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 32f1edd..84187d3 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -20,7 +20,6 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/devices.h"
 #include "hw/boards.h"
 #include "hw/arm/allwinner-a10.h"
=20
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index fb9efa0..96ccf18 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -21,7 +21,6 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
 #include "hw/loader.h"
 #include "net/net.h"
 #include "sysemu/kvm.h"
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f5f0b0e..f79f090 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -56,7 +56,6 @@
 #include "hw/arm/armsse.h"
 #include "hw/dma/pl080.h"
 #include "hw/ssi/pl022.h"
-#include "hw/devices.h"
 #include "net/net.h"
 #include "hw/core/split-irq.h"
=20
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index d22532a..de4a12e 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -15,7 +15,6 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index bbaf050..3e633d1 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -14,7 +14,6 @@
 #include "hw/arm/arm.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
-#include "hw/devices.h"
 #include "hw/misc/unimp.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index c4bc3de..22f5958 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -21,7 +21,6 @@
 #include "hw/ssi/ssi.h"
 #include "hw/block/flash.h"
 #include "qemu/timer.h"
-#include "hw/devices.h"
 #include "hw/arm/sharpsl.h"
 #include "ui/console.h"
 #include "hw/audio/wm8750.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c7fb534..7f66dda 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -38,7 +38,6 @@
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/display/ramfb.h"
-#include "hw/devices.h"
 #include "net/net.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/numa.h"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 6f18d92..3b75d4b 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -15,7 +15,6 @@
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
 #include "hw/i2c/i2c.h"
 #include "hw/ssi/ssi.h"
 #include "hw/boards.h"
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 4a8686f..2122291 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -32,7 +32,6 @@
 #include "hw/hw.h"
 #include "hw/char/serial.h"
 #include "ui/console.h"
-#include "hw/devices.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 40f9e1a..4d1380c 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -15,7 +15,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "hw/devices.h"
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 11f1366..1aa628c 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -17,7 +17,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/devices.h"
 #include "sysemu/sysemu.h"
 #include "hw/intc/allwinner-a10-pic.h"
 #include "qemu/log.h"
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 05157f8..599e0d4 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -25,7 +25,6 @@
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "hw/block/flash.h"
-#include "hw/devices.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index b080cf1..538f33b 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -27,7 +27,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
-#include "hw/devices.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogi=
x_ml605_mmu.c
index c730878..18048d3 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -35,7 +35,6 @@
 #include "net/net.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
-#include "hw/devices.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
 #include "exec/address-spaces.h"
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/pet=
alogix_s3adsp1800_mmu.c
index b9f0b0d..a0edaf8 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -33,7 +33,6 @@
 #include "net/net.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
-#include "hw/devices.h"
 #include "hw/boards.h"
 #include "hw/misc/unimp.h"
 #include "exec/address-spaces.h"
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b53fcaa..98cb4e5 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/devices.h"
 #include "net/net.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 5a711cb..26e2312 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -31,7 +31,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
-#include "hw/devices.h"
 #include "hw/boards.h"
 #include "sysemu/device_tree.h"
 #include "hw/loader.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index dcdb372..28ed6be 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -31,7 +31,6 @@
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
-#include "hw/devices.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/pci/pci.h"
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
index 003592a..b40cc99 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -24,7 +24,6 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "hw/devices.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 501706e..f76b59a 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -24,7 +24,6 @@
 #include "hw/usb.h"
 #include "hw/arm/omap.h"
 #include "hw/irq.h"
-#include "hw/devices.h"
 #include "hw/sysbus.h"
=20
 #define TYPE_TUSB6010 "tusb6010"
--=20
1.8.3.1
