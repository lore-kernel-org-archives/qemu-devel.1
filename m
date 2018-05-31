Received: from eggs.gnu.org ([2001:4830:134:3::10]:58469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8P-0003XC-Px
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8N-0008S4-NI
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8N-0008RT-Gu
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:07 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:13 +0200
Message-Id: <20180531171253.21012-14-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/53] hw: Do not include
 "exec/address-spaces.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Code change produced with:
    $ git grep '#include "exec/address-spaces.h"' hw include/hw | \
      cut -d: -f-1 | \
      xargs egrep -L "(get_system_|address_space_)" | \
      xargs sed -i.bak '/#include "exec\/address-spaces.h"/d'

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-12-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/bcm2836.c                     | 1 -
 hw/arm/xlnx-zcu102.c                 | 1 -
 hw/block/onenand.c                   | 1 -
 hw/block/pflash_cfi01.c              | 1 -
 hw/block/pflash_cfi02.c              | 1 -
 hw/char/mcf_uart.c                   | 1 -
 hw/char/serial.c                     | 1 -
 hw/char/sh_serial.c                  | 1 -
 hw/core/loader-fit.c                 | 1 -
 hw/core/platform-bus.c               | 1 -
 hw/display/sm501.c                   | 1 -
 hw/m68k/mcf5206.c                    | 1 -
 hw/m68k/mcf_intc.c                   | 1 -
 hw/misc/arm_integrator_debug.c       | 1 -
 hw/net/mcf_fec.c                     | 1 -
 hw/net/ne2000-isa.c                  | 1 -
 hw/pci-host/versatile.c              | 1 -
 hw/riscv/riscv_htif.c                | 1 -
 hw/sh4/sh7750.c                      | 1 -
 hw/timer/sh_timer.c                  | 1 -
 include/hw/arm/allwinner-a10.h       | 1 -
 include/hw/arm/bcm2835_peripherals.h | 1 -
 include/hw/display/bcm2835_fb.h      | 1 -
 include/hw/dma/bcm2835_dma.h         | 1 -
 include/hw/misc/bcm2835_mbox.h       | 1 -
 include/hw/misc/bcm2835_property.h   | 1 -
 include/hw/sh4/sh_intc.h             | 1 -
 include/hw/virtio/virtio-access.h    | 1 -
 28 files changed, 28 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 3c4b44a53e..6805a7d7c8 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -15,7 +15,6 @@
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
-#include "exec/address-spaces.h"
=20
 /* Peripheral base address seen by the CPU */
 #define BCM2836_PERI_BASE       0x3F000000
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index b126cf148b..c70278c8c1 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -22,7 +22,6 @@
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
-#include "exec/address-spaces.h"
 #include "qemu/log.h"
 #include "sysemu/qtest.h"
=20
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index ed77f859e9..ab0c7ea1b3 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -27,7 +27,6 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "exec/memory.h"
-#include "exec/address-spaces.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
=20
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 2e8284001d..e4b5b3c273 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -43,7 +43,6 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
-#include "exec/address-spaces.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "hw/sysbus.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 75d1ae1026..a8b3f7f978 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -41,7 +41,6 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "sysemu/block-backend.h"
-#include "exec/address-spaces.h"
 #include "qemu/host-utils.h"
 #include "hw/sysbus.h"
=20
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index faae083e78..787f985db6 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -10,7 +10,6 @@
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
 #include "chardev/char-fe.h"
-#include "exec/address-spaces.h"
=20
 typedef struct {
     SysBusDevice parent_obj;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2c080c9862..605b0d02f9 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -28,7 +28,6 @@
 #include "chardev/char-serial.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "exec/address-spaces.h"
 #include "qemu/error-report.h"
=20
 //#define DEBUG_SERIAL
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 835b5378a0..373a40595f 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -28,7 +28,6 @@
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
-#include "exec/address-spaces.h"
 #include "qapi/error.h"
=20
 //#define DEBUG_SERIAL
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 0c4a7207f4..6387854b54 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "hw/loader.h"
 #include "hw/loader-fit.h"
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 807cb5ccda..e473a44746 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -21,7 +21,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/platform-bus.h"
-#include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index f4bb33c279..e47be99451 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -36,7 +36,6 @@
 #include "hw/pci/pci.h"
 #include "qemu/range.h"
 #include "ui/pixel_ops.h"
-#include "exec/address-spaces.h"
=20
 /*
  * Status: 2010/05/07
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 6ad1e4bd2d..7abd84ac47 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -14,7 +14,6 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "sysemu/sysemu.h"
-#include "exec/address-spaces.h"
=20
 /* General purpose timer module.  */
 typedef struct {
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 8198afac1e..393ce284a2 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -11,7 +11,6 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
-#include "exec/address-spaces.h"
=20
 #define TYPE_MCF_INTC "mcf-intc"
 #define MCF_INTC(obj) OBJECT_CHECK(mcf_intc_state, (obj), TYPE_MCF_INTC)
diff --git a/hw/misc/arm_integrator_debug.c b/hw/misc/arm_integrator_debu=
g.c
index 8a5f29559d..533e6e3208 100644
--- a/hw/misc/arm_integrator_debug.c
+++ b/hw/misc/arm_integrator_debug.c
@@ -17,7 +17,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "exec/address-spaces.h"
 #include "hw/misc/arm_integrator_debug.h"
 #include "qemu/log.h"
=20
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index bfa6b4bcce..0091e4ecdd 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -14,7 +14,6 @@
 #include "hw/sysbus.h"
 /* For crc32 */
 #include <zlib.h>
-#include "exec/address-spaces.h"
=20
 //#define DEBUG_FEC 1
=20
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 70e5c1d3d4..c7fdeb0f6c 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -27,7 +27,6 @@
 #include "hw/qdev.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
-#include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
=20
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index d0b02bdc47..7b19078c80 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -12,7 +12,6 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
-#include "exec/address-spaces.h"
 #include "qemu/log.h"
=20
 /* Old and buggy versions of QEMU used the wrong mapping from
diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index f73512941f..4f7b11dc37 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -29,7 +29,6 @@
 #include "chardev/char-fe.h"
 #include "hw/riscv/riscv_htif.h"
 #include "qemu/timer.h"
-#include "exec/address-spaces.h"
 #include "qemu/error-report.h"
=20
 #define RISCV_DEBUG_HTIF 0
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 5a7d47d31e..2dc07a904b 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -31,7 +31,6 @@
 #include "hw/sh4/sh_intc.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "exec/address-spaces.h"
=20
 #define NB_DEVICES 4
=20
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 9afb2d048c..5f8736cf10 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -13,7 +13,6 @@
 #include "hw/sh4/sh.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
-#include "exec/address-spaces.h"
 #include "hw/ptimer.h"
=20
 //#define DEBUG_TIMER
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a1=
0.h
index 6b32a99e21..efb8fc8123 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -11,7 +11,6 @@
 #include "hw/ide/ahci.h"
=20
 #include "sysemu/sysemu.h"
-#include "exec/address-spaces.h"
=20
=20
 #define AW_A10_PIC_REG_BASE     0x01c20400
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
index 122b286de7..f5b193f670 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -12,7 +12,6 @@
 #define BCM2835_PERIPHERALS_H
=20
 #include "qemu-common.h"
-#include "exec/address-spaces.h"
 #include "hw/sysbus.h"
 #include "hw/char/bcm2835_aux.h"
 #include "hw/display/bcm2835_fb.h"
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835=
_fb.h
index 9a12d7afa2..ae0a3807f2 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -12,7 +12,6 @@
 #define BCM2835_FB_H
=20
 #include "hw/sysbus.h"
-#include "exec/address-spaces.h"
 #include "ui/console.h"
=20
 #define TYPE_BCM2835_FB "bcm2835-fb"
diff --git a/include/hw/dma/bcm2835_dma.h b/include/hw/dma/bcm2835_dma.h
index 75312e2e17..60138f4d31 100644
--- a/include/hw/dma/bcm2835_dma.h
+++ b/include/hw/dma/bcm2835_dma.h
@@ -7,7 +7,6 @@
 #define BCM2835_DMA_H
=20
 #include "qemu-common.h"
-#include "exec/address-spaces.h"
 #include "hw/sysbus.h"
=20
 typedef struct {
diff --git a/include/hw/misc/bcm2835_mbox.h b/include/hw/misc/bcm2835_mbo=
x.h
index f4e9ff9ef6..7e8f3ce86d 100644
--- a/include/hw/misc/bcm2835_mbox.h
+++ b/include/hw/misc/bcm2835_mbox.h
@@ -8,7 +8,6 @@
=20
 #include "bcm2835_mbox_defs.h"
 #include "hw/sysbus.h"
-#include "exec/address-spaces.h"
=20
 #define TYPE_BCM2835_MBOX "bcm2835-mbox"
 #define BCM2835_MBOX(obj) \
diff --git a/include/hw/misc/bcm2835_property.h b/include/hw/misc/bcm2835=
_property.h
index edcab603ce..11be0dbeac 100644
--- a/include/hw/misc/bcm2835_property.h
+++ b/include/hw/misc/bcm2835_property.h
@@ -7,7 +7,6 @@
 #define BCM2835_PROPERTY_H
=20
 #include "hw/sysbus.h"
-#include "exec/address-spaces.h"
 #include "net/net.h"
 #include "hw/display/bcm2835_fb.h"
=20
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index 7913bc48a2..fbcee94ed7 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -3,7 +3,6 @@
=20
 #include "qemu-common.h"
 #include "hw/irq.h"
-#include "exec/address-spaces.h"
=20
 typedef unsigned char intc_enum;
=20
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
index 2e92074bd1..bdf58f3119 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -18,7 +18,6 @@
=20
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
-#include "exec/address-spaces.h"
=20
 #if defined(TARGET_PPC64) || defined(TARGET_ARM)
 #define LEGACY_VIRTIO_IS_BIENDIAN 1
--=20
2.17.0
