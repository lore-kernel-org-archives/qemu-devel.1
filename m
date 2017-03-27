Received: from eggs.gnu.org ([2001:4830:134:3::10]:35125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1csTAx-0001Tm-U0
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1csTAg-0005jT-S5
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:51:08 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1csTAg-0005gx-5u
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:50:50 -0400
Received: by mail-ot0-x244.google.com with SMTP id s100so3597368ota.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 04:50:49 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Mon, 27 Mar 2017 14:50:47 +0300
Message-ID: <CA+KKJYCOKxea1TJY0Uu8HSzYLoh3G=EX-DeKbM+r40HhoxfJrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH] debug: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From cddb60744808eedbadebdc4f0258ee6db694c4a3 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Mon, 27 Mar 2017 14:43:10 +0300
Subject: [PATCH] debug: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings. Also updated some debug messages to remove compiler errors and
warnings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 A patch for "Bitrot prevention" in BiteSizedTasks.
 hw/acpi/pcihp.c               | 15 ++++++----
 hw/acpi/piix4.c               | 16 ++++++-----
 hw/arm/strongarm.c            | 17 +++++++----
 hw/arm/z2.c                   | 16 +++++++----
 hw/audio/lm4549.c             | 18 +++++++-----
 hw/block/pflash_cfi01.c       | 18 ++++++------
 hw/block/pflash_cfi02.c       | 19 ++++++------
 hw/char/ipoctal232.c          | 24 +++++++++-------
 hw/char/serial.c              | 16 ++++++-----
 hw/core/empty_slot.c          | 15 ++++++----
 hw/display/sm501.c            | 15 ++++++----
 hw/display/ssd0303.c          | 26 ++++++++++-------
 hw/display/ssd0323.c          | 28 +++++++++---------
 hw/dma/i82374.c               | 18 +++++++-----
 hw/dma/puv3_dma.c             |  8 +++---
 hw/gpio/pl061.c               | 28 ++++++++++--------
 hw/gpio/puv3_gpio.c           |  8 +++---
 hw/i2c/bitbang_i2c.c          | 16 +++++++----
 hw/i2c/pm_smbus.c             | 15 ++++++----
 hw/i2c/smbus.c                | 28 +++++++++++-------
 hw/i386/acpi-build.c          | 17 +++++++----
 hw/i386/intel_iommu.c         | 18 ++++++------
 hw/i386/pc.c                  | 16 +++++++----
 hw/i386/xen/xen_platform.c    | 17 ++++++-----
 hw/input/adb.c                | 17 ++++++-----
 hw/input/pckbd.c              | 17 +++++++----
 hw/input/vmmouse.c            | 15 ++++++----
 hw/intc/arm_gicv3_kvm.c       | 16 ++++++-----
 hw/intc/exynos4210_combiner.c | 18 ++++++------
 hw/intc/heathrow_pic.c        | 17 ++++++-----
 hw/intc/i8259.c               | 16 ++++++-----
 hw/intc/ioapic.c              | 16 ++++++-----
 hw/intc/puv3_intc.c           |  4 +--
 hw/ipack/tpci200.c            | 16 +++++++----
 hw/isa/apm.c                  | 14 +++++----
 hw/isa/vt82c686.c             | 18 ++++++------
 hw/mips/gt64xxx_pci.c         | 15 ++++++----
 hw/misc/macio/cuda.c          | 15 ++++++----
 hw/misc/puv3_pm.c             |  8 +++---
 hw/net/dp8393x.c              | 15 ++++++----
 hw/net/lan9118.c              | 20 +++++++++----
 hw/net/mcf_fec.c              | 18 +++++++-----
 hw/net/stellaris_enet.c       | 28 +++++++++++-------
 hw/nvram/mac_nvram.c          | 16 +++++++----
 hw/pci-bridge/dec.c           | 18 ++++++------
 hw/pci-host/apb.c             | 16 +++++++----
 hw/pci-host/bonito.c          | 19 +++++++-----
 hw/pci-host/grackle.c         | 16 +++++++----
 hw/pci-host/uninorth.c        | 16 +++++++----
 hw/pci/msi.c                  | 17 +++++++----
 hw/pci/pci.c                  | 16 +++++++----
 hw/pci/pci_host.c             | 16 +++++++----
 hw/pci/pcie.c                 | 18 ++++++++----
 hw/pci/pcie_aer.c             | 18 ++++++++----
 hw/s390x/s390-pci-bus.c       | 18 +++++++-----
 hw/s390x/s390-pci-inst.c      | 18 +++++++-----
 hw/scsi/lsi53c895a.c          | 26 ++++++++++-------
 hw/scsi/scsi-disk.c           | 17 ++++++-----
 hw/scsi/scsi-generic.c        | 17 +++++------
 hw/sd/pl181.c                 | 16 +++++++----
 hw/sd/sd.c                    | 14 +++++----
 hw/sd/ssi-sd.c                | 27 ++++++++++-------
 hw/sparc64/sparc64.c          | 36 ++++++++++++-----------
 hw/sparc64/sun4u.c            | 16 ++++++-----
 hw/ssi/pl022.c                | 28 ++++++++++--------
 hw/timer/exynos4210_mct.c     | 43 +++++++++++++--------------
 hw/timer/exynos4210_pwm.c     | 18 ++++++------
 hw/timer/exynos4210_rtc.c     | 12 ++++----
 hw/timer/hpet.c               | 24 +++++++++-------
 hw/timer/mc146818rtc.c        | 33 ++++++++++++---------
 hw/timer/pl031.c              | 17 +++++------
 hw/timer/puv3_ost.c           |  4 +--
 hw/timer/sun4v-rtc.c          | 18 ++++++------
 hw/usb/dev-serial.c           | 17 +++++------
 hw/usb/dev-storage.c          | 17 +++++------
 hw/usb/hcd-ehci.h             | 10 +++----
 hw/usb/hcd-xhci.c             | 19 +++++++-----
 hw/virtio/virtio-bus.c        | 15 ++++++----
 hw/virtio/virtio-mmio.c       | 17 ++++++-----
 include/hw/unicore32/puv3.h   | 15 ++++++----
 include/hw/vfio/vfio-common.h | 17 +++++------
 kvm-all.c                     | 16 +++++------
 migration/block.c             | 16 ++++++-----
 page_cache.c                  | 17 ++++++-----
 target/i386/kvm.c             | 18 ++++++------
 target/ppc/kvm.c              | 18 ++++++------
 target/s390x/kvm.c            | 18 ++++++------
 target/sparc/ldst_helper.c    | 67
+++++++++++++++++++++++++------------------
 target/unicore32/helper.c     | 16 ++++++-----
 target/unicore32/softmmu.c    | 14 +++++----
 xen-common.c                  | 18 ++++++------
 xen-hvm.c                     | 18 ++++++------
 xen-mapcache.c                | 18 ++++++------
 93 files changed, 992 insertions(+), 712 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2b0f3e1..bf880c1 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -39,13 +39,16 @@
 #include "qom/qom-qobject.h"
 #include "qapi/qmp/qint.h"

-//#define DEBUG

-#ifdef DEBUG
-# define ACPI_PCIHP_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define ACPI_PCIHP_DPRINTF(format, ...)     do { } while (0)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define ACPI_PCIHP_DPRINTF(fmt, ...) do {     \
+    if (DEBUG) {                              \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define ACPI_PCIHP_ADDR 0xae00
 #define ACPI_PCIHP_SIZE 0x0014
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a553a7e..34e85b4 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -42,13 +42,15 @@
 #include "hw/xen/xen.h"
 #include "qom/cpu.h"

-//#define DEBUG
-
-#ifdef DEBUG
-# define PIIX4_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define PIIX4_DPRINTF(format, ...)     do { } while (0)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define PIIX4_DPRINTF(fmt, ...) do {                    \
+    if (DEBUG) {                          \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                             \
+} while (0);

 #define GPE_BASE 0xafe0
 #define GPE_LEN 4
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 3311cc3..88368ac 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -59,11 +59,16 @@
  - Enhance UART with modem signals
  */

-#ifdef DEBUG
-# define DPRINTF(format, ...) printf(format , ## __VA_ARGS__)
-#else
-# define DPRINTF(format, ...) do { } while (0)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...)                         \
+    do {                                          \
+        if (DEBUG) {                              \
+            fprintf(stderr, fmt, ## __VA_ARGS__); \
+        }                                         \
+    } while (0)

 static struct {
     hwaddr io_base;
@@ -1022,7 +1027,7 @@ static void
strongarm_uart_update_parameters(StrongARMUARTState *s)
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);

-    DPRINTF(stderr, "%s speed=%d parity=%c data=%d stop=%d\n",
s->chr->label,
+    DPRINTF("%s speed=%d parity=%c data=%d stop=%d\n", s->chr.chr->label,
             speed, parity, data_bits, stop_bits);
 }

diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 1607cbd..1ee8ed9 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -27,12 +27,16 @@
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"

-#ifdef DEBUG_Z2
-#define DPRINTF(fmt, ...) \
-        printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_Z2
+#define DEBUG_Z2 0
+#endif
+
+#define DPRINTF(fmt, ...)                                \
+    do {                                                 \
+        if (DEBUG_Z2) {                                  \
+            fprintf(stderr, "z2: " fmt, ## __VA_ARGS__); \
+        }                                                \
+    } while (0)

 static const struct keymap map[0x100] = {
     [0 ... 0xff] = { -1, -1 },
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index a46f230..962db8e 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -26,13 +26,17 @@
 #define LM4549_DUMP_DAC_INPUT 1
 #endif

-#ifdef LM4549_DEBUG
-#define DPRINTF(fmt, ...) \
-do { printf("lm4549: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
+#ifndef LM4549_DEBUG
+#define LM4549_DEBUG 0
 #endif

+#define DPRINTF(fmt, ...)                                    \
+    do {                                                     \
+        if (LM4549_DEBUG) {                                  \
+            fprintf(stderr, "lm4549: " fmt, ## __VA_ARGS__); \
+        }                                                    \
+    } while (0)
+
 #if defined(LM4549_DUMP_DAC_INPUT)
 static FILE *fp_dac_input;
 #endif
@@ -159,7 +163,7 @@ uint32_t lm4549_read(lm4549_state *s, hwaddr offset)
     assert(offset < 128);
     value = regfile[offset];

-    DPRINTF("read [0x%02x] = 0x%04x\n", offset, value);
+    DPRINTF("read [0x%02x] = 0x%04x\n", (int) offset, value);

     return value;
 }
@@ -170,7 +174,7 @@ void lm4549_write(lm4549_state *s,
     uint16_t *regfile = s->regfile;

     assert(offset < 128);
-    DPRINTF("write [0x%02x] = 0x%04x\n", offset, value);
+    DPRINTF("write [0x%02x] = 0x%04x\n", (int) offset, value);

     switch (offset) {
     case LM4549_Reset:
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 594d4cf..6e07ad7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -55,15 +55,15 @@ do { \
     exit(1); \
 } while(0)

-/* #define PFLASH_DEBUG */
-#ifdef PFLASH_DEBUG
-#define DPRINTF(fmt, ...)                                   \
-do {                                                        \
-    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
-} while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef PFLASH_DEBUG
+#define PFLASH_DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (PFLASH_DEBUG) {                                  \
+        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__); \
+    }                                                    \
+} while (0);

 #define CFI_PFLASH01(obj) OBJECT_CHECK(pflash_t, (obj), TYPE_CFI_PFLASH01)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index e6c5c6c..be35bca 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -46,14 +46,17 @@
 #include "hw/sysbus.h"

 //#define PFLASH_DEBUG
-#ifdef PFLASH_DEBUG
-#define DPRINTF(fmt, ...)                                  \
-do {                                                       \
-    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
-} while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+
+#ifndef PFLASH_DEBUG
+#define PFLASH_DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (PFLASH_DEBUG) {                                  \
+        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__); \
+    }                                                    \
+} while (0);
+

 #define PFLASH_LAZY_ROMD_THRESHOLD 42

diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 93929c2..180d8f7 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -13,14 +13,16 @@
 #include "qemu/bitops.h"
 #include "sysemu/char.h"

-/* #define DEBUG_IPOCTAL */

-#ifdef DEBUG_IPOCTAL
-#define DPRINTF2(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF2(fmt, ...) do { } while (0)
-#endif
+#ifndef DEBUG_IPOCTAL
+#define DEBUG_IPOCTAL 0
+#endif
+
+#define DPRINTF2(fmt, ...) do {                \
+    if (DEBUG_IPOCTAL) {                       \
+        fprintf(stderr, fmt, ## __VA_ARGS__);  \
+    }                                          \
+} while (0);

 #define DPRINTF(fmt, ...) DPRINTF2("IP-Octal: " fmt, ## __VA_ARGS__)

@@ -504,11 +506,11 @@ static void hostdev_event(void *opaque, int event)
     SCC2698Channel *ch = opaque;
     switch (event) {
     case CHR_EVENT_OPENED:
-        DPRINTF("Device %s opened\n", ch->dev->label);
+        DPRINTF("Device %s opened\n", ch->dev.chr->label);
         break;
     case CHR_EVENT_BREAK: {
         uint8_t zero = 0;
-        DPRINTF("Device %s received break\n", ch->dev->label);
+        DPRINTF("Device %s received break\n", ch->dev.chr->label);

         if (!(ch->sr & SR_BREAK)) {
             IPOctalState *dev = ch->ipoctal;
@@ -528,7 +530,7 @@ static void hostdev_event(void *opaque, int event)
     }
         break;
     default:
-        DPRINTF("Device %s received event %d\n", ch->dev->label, event);
+        DPRINTF("Device %s received event %d\n", ch->dev.chr->label,
event);
     }
 }

@@ -546,7 +548,7 @@ static void ipoctal_realize(DeviceState *dev, Error
**errp)
             qemu_chr_fe_set_handlers(&ch->dev, hostdev_can_receive,
                                      hostdev_receive, hostdev_event,
                                      ch, NULL, true);
-            DPRINTF("Redirecting channel %u to %s\n", i, ch->dev->label);
+            DPRINTF("Redirecting channel %u to %s\n", i,
ch->dev.chr->label);
         } else {
             DPRINTF("Could not redirect channel %u, no chardev set\n", i);
         }
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 03d890c..9421c7a 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -97,13 +97,15 @@

 #define MAX_XMIT_RETRY      4

-#ifdef DEBUG_SERIAL
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "serial: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-do {} while (0)
-#endif
+#ifndef DEBUG_SERIAL
+#define DEBUG_SERIAL 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                            \
+    if (DEBUG_SERIAL) {                                   \
+        fprintf(stderr, "serial: " fmt , ## __VA_ARGS__); \
+    }                                                     \
+} while (0);

 static void serial_receive1(void *opaque, const uint8_t *buf, int size);
 static void serial_xmit(SerialState *s);
diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index c1b9c2b..b58957d 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -16,12 +16,15 @@

 //#define DEBUG_EMPTY_SLOT

-#ifdef DEBUG_EMPTY_SLOT
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("empty_slot: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_EMPTY_SLOT
+#define DEBUG_EMPTY_SLOT 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                \
+    if (DEBUG_EMPTY_SLOT) {                                   \
+        fprintf(stderr, "empty_slot: " fmt , ## __VA_ARGS__); \
+    }                                                         \
+} while (0);

 #define TYPE_EMPTY_SLOT "empty_slot"
 #define EMPTY_SLOT(obj) OBJECT_CHECK(EmptySlot, (obj), TYPE_EMPTY_SLOT)
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 040a0b9..ff16613 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -52,11 +52,16 @@
 //#define DEBUG_SM501
 //#define DEBUG_BITBLT

-#ifdef DEBUG_SM501
-#define SM501_DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
-#else
-#define SM501_DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_SM501
+#define DEBUG_SM501 0
+#endif
+
+#define SM501_DPRINTF(fmt, ...)                   \
+    do {                                          \
+        if (DEBUG_SM501) {                        \
+            fprintf(stderr, fmt, ## __VA_ARGS__); \
+        }                                         \
+    } while (0)


 #define MMIO_BASE_OFFSET 0x3e00000
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index 68a80b9..35ce7c4 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -14,18 +14,22 @@
 #include "hw/i2c/i2c.h"
 #include "ui/console.h"

-//#define DEBUG_SSD0303 1
+#ifndef DEBUG_SSD0303
+#define DEBUG_SSD0303 0
+#endif

-#ifdef DEBUG_SSD0303
-#define DPRINTF(fmt, ...) \
-do { printf("ssd0303: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssd0303: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssd0303: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#define DPRINTF(fmt, ...) do {                    \
+    if (DEBUG_SSD0303) {                          \
+        fprintf(stderr, "ssd0303: " fmt , ## __VA_ARGS__); \
+    }                                             \
+} while (0);
+
+#define BADF(fmt, ...) do {                                   \
+    fprintf(stderr, "ssd0303: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_SSD0303) {                                      \
+        exit(1);                                              \
+    }                                                         \
+} while (0);

 /* Scaling factor for pixels.  */
 #define MAGNIFY 4
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index e182893..70b1e33 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -14,20 +14,22 @@
 #include "hw/ssi/ssi.h"
 #include "ui/console.h"

-//#define DEBUG_SSD0323 1
+#ifndef DEBUG_SSD0323
+#define DEBUG_SSD0323 0
+#endif

-#ifdef DEBUG_SSD0323
-#define DPRINTF(fmt, ...) \
-do { printf("ssd0323: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { \
-    fprintf(stderr, "ssd0323: error: " fmt , ## __VA_ARGS__); abort(); \
-} while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssd0323: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#define DPRINTF(fmt, ...) do {                    \
+    if (DEBUG_SSD0323) {                          \
+        fprintf(stderr, "ssd0323: " fmt , ## __VA_ARGS__); \
+    }                                             \
+} while (0);
+
+#define BADF(fmt, ...) do {                                   \
+    fprintf(stderr, "ssd0323: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_SSD0323) {                                      \
+        abort();                                              \
+    }                                                         \
+} while (0);

 /* Scaling factor for pixels.  */
 #define MAGNIFY 4
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 6c0f975..5e994ef 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -30,13 +30,17 @@

 //#define DEBUG_I82374

-#ifdef DEBUG_I82374
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "i82374: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-do {} while (0)
-#endif
+#ifndef DEBUG_I82374
+#define DEBUG_I82374 0
+#endif
+
+#define DPRINTF(fmt, ...)                                    \
+    do {                                                     \
+        if (DEBUG_I82374) {                                  \
+            fprintf(stderr, "i82374: " fmt, ## __VA_ARGS__); \
+        }                                                    \
+    } while (0)
+
 #define BADF(fmt, ...) \
 do { fprintf(stderr, "i82374 ERROR: " fmt , ## __VA_ARGS__); } while (0)

diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
index b97a6c1..3d6c0ced 100644
--- a/hw/dma/puv3_dma.c
+++ b/hw/dma/puv3_dma.c
@@ -42,9 +42,9 @@ static uint64_t puv3_dma_read(void *opaque, hwaddr offset,
         ret = s->reg_CFG[PUV3_DMA_CH(offset)];
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        DPRINTF("Bad offset 0x%lx\n", offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    DPRINTF("offset 0x%lx, value 0x%x\n", offset, ret);

     return ret;
 }
@@ -61,9 +61,9 @@ static void puv3_dma_write(void *opaque, hwaddr offset,
         s->reg_CFG[PUV3_DMA_CH(offset)] = value;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        DPRINTF("Bad offset 0x%lx\n", offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    DPRINTF("offset 0x%lx, value 0x%lx\n", offset, value);
 }

 static const MemoryRegionOps puv3_dma_ops = {
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 4ae2aa1..af0de24 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -12,18 +12,22 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"

-//#define DEBUG_PL061 1
-
-#ifdef DEBUG_PL061
-#define DPRINTF(fmt, ...) \
-do { printf("pl061: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "pl061: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "pl061: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#ifndef DEBUG_PL061
+#define DEBUG_PL061  0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (DEBUG_PL061) {                                   \
+        fprintf(stderr, "pl061: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);
+
+#define BADF(fmt, ...) do {                                 \
+    fprintf(stderr, "pl061: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_PL061) {                                      \
+        exit(1);                                            \
+    }                                                       \
+} while (0);

 static const uint8_t pl061_id[12] =
   { 0x00, 0x00, 0x00, 0x00, 0x61, 0x10, 0x04, 0x00, 0x0d, 0xf0, 0x05, 0xb1
};
diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
index 445afcc..48a8a4b 100644
--- a/hw/gpio/puv3_gpio.c
+++ b/hw/gpio/puv3_gpio.c
@@ -46,9 +46,9 @@ static uint64_t puv3_gpio_read(void *opaque, hwaddr
offset,
         ret = s->reg_GPIR;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        DPRINTF("Bad offset 0x%lx\n", offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    DPRINTF("offset 0x%lx, value 0x%x\n", offset, ret);

     return ret;
 }
@@ -58,7 +58,7 @@ static void puv3_gpio_write(void *opaque, hwaddr offset,
 {
     PUV3GPIOState *s = opaque;

-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    DPRINTF("offset 0x%lx, value 0x%lx\n", offset, value);
     switch (offset) {
     case 0x04:
         s->reg_GPDR = value;
@@ -85,7 +85,7 @@ static void puv3_gpio_write(void *opaque, hwaddr offset,
         s->reg_GPIR = value;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        DPRINTF("Bad offset 0x%lx\n", offset);
     }
 }

diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 8be88ee..55a5f85 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -16,12 +16,16 @@

 //#define DEBUG_BITBANG_I2C

-#ifdef DEBUG_BITBANG_I2C
-#define DPRINTF(fmt, ...) \
-do { printf("bitbang_i2c: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_BITBANG_I2C
+#define DEBUG_BITBANG_I2C 0
+#endif
+
+#define DPRINTF(fmt, ...)                                         \
+    do {                                                          \
+        if (DEBUG_BITBANG_I2C) {                                  \
+            fprintf(stderr, "bitbang_i2c: " fmt, ## __VA_ARGS__); \
+        }                                                         \
+    } while (0)

 typedef enum bitbang_i2c_state {
     STOPPED = 0,
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 6fc3923..b36a460 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -47,11 +47,16 @@

 //#define DEBUG

-#ifdef DEBUG
-# define SMBUS_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define SMBUS_DPRINTF(format, ...)     do { } while (0)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define SMBUS_DPRINTF(fmt, ...)                   \
+    do {                                          \
+        if (DEBUG) {                              \
+            fprintf(stderr, fmt, ## __VA_ARGS__); \
+        }                                         \
+    } while (0)


 static void smb_transaction(PMSMBus *s)
diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 2d1b79a..a81445b 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -16,16 +16,24 @@

 //#define DEBUG_SMBUS 1

-#ifdef DEBUG_SMBUS
-#define DPRINTF(fmt, ...) \
-do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); }
while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#ifndef DEBUG_SMBUS
+#define DEBUG_SMBUS 0
+#endif
+
+#define DPRINTF(fmt, ...)
           \
+    do {
          \
+        if (DEBUG_SMBUS) {
          \
+            fprintf(stderr, "smbus(%02x): " fmt , dev->i2c.address, ##
__VA_ARGS__); \
+        }
           \
+    } while (0)
+
+#define BADF(fmt, ...)                                          \
+    do {                                                        \
+        fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); \
+        if (DEBUG_SMBUS) {                                      \
+            exit(1);                                            \
+        }                                                       \
+    } while (0)

 enum {
     SMBUS_IDLE,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2073108..53b3aaf 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -75,12 +75,17 @@
 #define ACPI_BUILD_TABLE_SIZE             0x20000

 /* #define DEBUG_ACPI_BUILD */
-#ifdef DEBUG_ACPI_BUILD
-#define ACPI_BUILD_DPRINTF(fmt, ...)        \
-    do {printf("ACPI_BUILD: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define ACPI_BUILD_DPRINTF(fmt, ...)
-#endif
+
+#ifndef DEBUG_ACPI_BUILD
+#define DEBUG_ACPI_BUILD 0
+#endif
+
+#define ACPI_BUILD_DPRINTF(fmt, ...)                             \
+    do {                                                         \
+        if (DEBUG_ACPI_BUILD) {                                  \
+            fprintf(stderr, "ACPI_BUILD: " fmt, ## __VA_ARGS__); \
+        }                                                        \
+    } while (0)

 /* Default IOAPIC ID */
 #define ACPI_BUILD_IOAPIC_ID 0x0
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 22d8226..562588b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,8 +37,10 @@
 #include "kvm_i386.h"
 #include "trace.h"

-/*#define DEBUG_INTEL_IOMMU*/
-#ifdef DEBUG_INTEL_IOMMU
+#ifndef DEBUG_INTEL_IOMMU
+#define DEBUG_INTEL_IOMMU 0
+#endif
+
 enum {
     DEBUG_GENERAL, DEBUG_CSR, DEBUG_INV, DEBUG_MMU, DEBUG_FLOG,
     DEBUG_CACHE, DEBUG_IR,
@@ -46,14 +48,12 @@ enum {
 #define VTD_DBGBIT(x)   (1 << DEBUG_##x)
 static int vtd_dbgflags = VTD_DBGBIT(GENERAL) | VTD_DBGBIT(CSR);

-#define VTD_DPRINTF(what, fmt, ...) do { \
-    if (vtd_dbgflags & VTD_DBGBIT(what)) { \
-        fprintf(stderr, "(vtd)%s: " fmt "\n", __func__, \
-                ## __VA_ARGS__); } \
+#define VTD_DPRINTF(what, fmt, ...)
           \
+    do {
    \
+        if (DEBUG_INTEL_IOMMU && vtd_dbgflags & VTD_DBGBIT(what)) {
     \
+            fprintf(stderr, "(vtd)%s: " fmt "\n", __func__, ##
__VA_ARGS__);   \
+        }
     \
     } while (0)
-#else
-#define VTD_DPRINTF(what, fmt, ...) do {} while (0)
-#endif

 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e..87b4312 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,12 +73,16 @@
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ

-#ifdef DEBUG_IRQ
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_IRQ
+#define DEBUG_IRQ 0
+#endif
+
+#define DPRINTF(fmt, ...)                                    \
+    do {                                                     \
+        if (DEBUG_IRQ) {                                     \
+            fprintf(stderr, "CPUIRQ: " fmt, ## __VA_ARGS__); \
+        }                                                    \
+    } while (0)

 #define FW_CFG_ACPI_TABLES (FW_CFG_ARCH_LOCAL + 0)
 #define FW_CFG_SMBIOS_ENTRIES (FW_CFG_ARCH_LOCAL + 1)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 6010f35..218bc2f 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -41,13 +41,16 @@

 //#define DEBUG_PLATFORM

-#ifdef DEBUG_PLATFORM
-#define DPRINTF(fmt, ...) do { \
-    fprintf(stderr, "xen_platform: " fmt, ## __VA_ARGS__); \
-} while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef DEBUG_PLATFORM
+#define DEBUG_PLATFORM 0
+#endif
+
+#define DPRINTF(fmt, ...)                                          \
+    do {                                                           \
+        if (DEBUG_PLATFORM) {                                      \
+            fprintf(stderr, "xen_platform: " fmt, ## __VA_ARGS__); \
+        }                                                          \
+    } while (0)

 #define PFFLAG_ROM_LOCK 1 /* Sets whether ROM memory area is RW or RO */

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 43d3205..a8e0958 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -31,13 +31,16 @@

 /* debug ADB */
 //#define DEBUG_ADB
-
-#ifdef DEBUG_ADB
-#define ADB_DPRINTF(fmt, ...) \
-do { printf("ADB: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define ADB_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_ADB
+#define DEBUG_ADB 0
+#endif
+
+#define ADB_DPRINTF(fmt, ...)                                   \
+    do {                                                        \
+        if (DEBUG_ADB) {                                        \
+            fprintf(stderr, "ADB: " fmt , ## __VA_ARGS__);      \
+        }                                                       \
+    } while (0)

 /* ADB commands */
 #define ADB_BUSRESET 0x00
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index d414288..d886ab6 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -30,12 +30,17 @@

 /* debug PC keyboard */
 //#define DEBUG_KBD
-#ifdef DEBUG_KBD
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("KBD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+
+#ifndef DEBUG_KBD
+#define DEBUG_KBD 0
+#endif
+
+#define DPRINTF(fmt, ...)                                     \
+    do {                                                      \
+        if (DEBUG_KBD) {                                      \
+            fprintf(stderr, "KDB: " fmt , ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)

 /* Keyboard Controller Commands */
 #define KBD_CCMD_READ_MODE 0x20 /* Read mode bits */
diff --git a/hw/input/vmmouse.c b/hw/input/vmmouse.c
index 6d15a88..2a4fa0a 100644
--- a/hw/input/vmmouse.c
+++ b/hw/input/vmmouse.c
@@ -46,11 +46,16 @@

 #define VMMOUSE_VERSION 0x3442554a

-#ifdef DEBUG_VMMOUSE
-#define DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef DEBUG_VMMOUSE
+#define DEBUG_VMMOUSE 0
+#endif
+
+#define DPRINTF(fmt, ...)                          \
+    do {                                           \
+        if (DEBUG_VMMOUSE) {                       \
+            fprintf(stderr, fmt, ## __VA_ARGS__);  \
+        }                                          \
+    } while (0)

 #define TYPE_VMMOUSE "vmmouse"
 #define VMMOUSE(obj) OBJECT_CHECK(VMMouseState, (obj), TYPE_VMMOUSE)
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 81f0403..32e75c0 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -30,13 +30,15 @@
 #include "vgic_common.h"
 #include "migration/migration.h"

-#ifdef DEBUG_GICV3_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "kvm_gicv3: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_GICV3_KVM
+#define DEBUG_GICV3_KVM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                               \
+    if (DEBUG_GICV3_KVM) {                                   \
+        fprintf(stderr, "kvm_gicv3: " fmt , ## __VA_ARGS__); \
+    }                                                        \
+} while (0);

 #define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
 #define KVM_ARM_GICV3(obj) \
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index f19a706..512fda6 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -32,15 +32,15 @@

 #include "hw/arm/exynos4210.h"

-//#define DEBUG_COMBINER
-
-#ifdef DEBUG_COMBINER
-#define DPRINTF(fmt, ...) \
-        do { fprintf(stdout, "COMBINER: [%s:%d] " fmt, __func__ ,
__LINE__, \
-                ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_COMBINER
+#define DEBUG_COMBINER 0
+#endif
+
+#define DPRINTF(fmt, ...) do {
             \
+    if (DEBUG_COMBINER) {
              \
+        fprintf(stdout, "COMBINER: [%s:%d] " fmt, __func__ , __LINE__, ##
__VA_ARGS__); \
+    }
              \
+} while (0);

 #define    IIC_NGRP        64            /* Internal Interrupt Combiner
                                             Groups number */
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 171f5ed..b9593f7 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -29,12 +29,15 @@
 /* debug PIC */
 //#define DEBUG_PIC

-#ifdef DEBUG_PIC
-#define PIC_DPRINTF(fmt, ...)                                   \
-    do { printf("PIC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define PIC_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_PIC
+#define DEBUG_PIC 0
+#endif
+
+#define PIC_DPRINTF(fmt, ...) do {                    \
+    if (DEBUG_PIC) {                          \
+        fprintf(stderr, "PIC: " fmt , ## __VA_ARGS__); \
+    }                                             \
+} while (0);

 typedef struct HeathrowPIC {
     uint32_t events;
@@ -72,7 +75,7 @@ static void pic_write(void *opaque, hwaddr addr,
     unsigned int n;

     n = ((addr & 0xfff) - 0x10) >> 4;
-    PIC_DPRINTF("writel: " TARGET_FMT_plx " %u: %08x\n", addr, n, value);
+    PIC_DPRINTF("writel: " TARGET_FMT_plx " %u: %08x\n", addr, n, (int)
value);
     if (n >= 2)
         return;
     pic = &s->pics[n];
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index fe9ecd6..43a20ce 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -32,14 +32,16 @@
 #include "hw/intc/intc.h"

 /* debug PIC */
-//#define DEBUG_PIC

-#ifdef DEBUG_PIC
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("pic: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_PIC
+#define DEBUG_PIC 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                         \
+    if (DEBUG_PIC) {                                   \
+        fprintf(stderr, "pic: " fmt , ## __VA_ARGS__); \
+    }                                                  \
+} while (0);

 //#define DEBUG_IRQ_LATENCY
 //#define DEBUG_IRQ_COUNT
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 37c4386..684401a 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -35,14 +35,16 @@
 #include "hw/i386/x86-iommu.h"
 #include "trace.h"

-//#define DEBUG_IOAPIC

-#ifdef DEBUG_IOAPIC
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("ioapic: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_IOAPIC
+#define DEBUG_IOAPIC 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                            \
+    if (DEBUG_IOAPIC) {                                   \
+        fprintf(stderr, "ioapic: " fmt , ## __VA_ARGS__); \
+    }                                                     \
+} while (0);

 #define APIC_DELIVERY_MODE_SHIFT 8
 #define APIC_POLARITY_SHIFT 14
diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index ef8488a..80934f2 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -67,7 +67,7 @@ static uint64_t puv3_intc_read(void *opaque, hwaddr
offset,
     default:
         DPRINTF("Bad offset %x\n", (int)offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    DPRINTF("offset 0x%lx, value 0x%x\n", offset, ret);
     return ret;
 }

@@ -76,7 +76,7 @@ static void puv3_intc_write(void *opaque, hwaddr offset,
 {
     PUV3INTCState *s = opaque;

-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    DPRINTF("offset 0x%lx, value 0x%lx\n", offset, value);
     switch (offset) {
     case 0x00: /* INTC_ICLR */
     case 0x14: /* INTC_ICCR */
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 4dfa6b3..53bcbd5 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -15,12 +15,16 @@

 /* #define DEBUG_TPCI */

-#ifdef DEBUG_TPCI
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "TPCI200: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef DEBUG_TPCI
+#define DEBUG_TPCI 0
+#endif
+
+#define DPRINTF(fmt, ...)                                  \
+    do {                                                      \
+        if (DEBUG_TPCI) {                                     \
+            fprintf(stderr, "TPCI200: " fmt, ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)

 #define N_MODULES 4

diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index e232b0d..c481e22 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -25,13 +25,15 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"

-//#define DEBUG
+#ifndef DEBUG
+#define DEBUG 0
+#endif

-#ifdef DEBUG
-# define APM_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
-#else
-# define APM_DPRINTF(format, ...)       do { } while (0)
-#endif
+#define APM_DPRINTF(fmt, ...) do {             \
+    if (DEBUG) {                               \
+        fprintf(stderr, fmt , ## __VA_ARGS__); \
+    }                                          \
+} while (0);

 /* fixed I/O location */
 #define APM_CNT_IOPORT  0xb2
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 41d5254..f427e5a 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -27,13 +27,15 @@
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"

-//#define DEBUG_VT82C686B
+#ifndef DEBUG_VT82C686B
+#define DEBUG_VT82C686B 0
+#endif

-#ifdef DEBUG_VT82C686B
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__,
##__VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#define DPRINTF(fmt, ...) do {                                    \
+    if (DEBUG_VT82C686B) {                                        \
+        fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__); \
+    }                                                             \
+} while (0);

 typedef struct SuperIOConfig
 {
@@ -57,7 +59,7 @@ static void superio_ioport_writeb(void *opaque, hwaddr
addr, uint64_t data,
 {
     SuperIOConfig *superio_conf = opaque;

-    DPRINTF("superio_ioport_writeb  address 0x%x  val 0x%x\n", addr, data);
+    DPRINTF("superio_ioport_writeb  address 0x%lx  val 0x%lx\n", addr,
data);
     if (addr == 0x3f0) {
         superio_conf->index = data & 0xff;
     } else {
@@ -101,7 +103,7 @@ static uint64_t superio_ioport_readb(void *opaque,
hwaddr addr, unsigned size)
 {
     SuperIOConfig *superio_conf = opaque;

-    DPRINTF("superio_ioport_readb  address 0x%x\n", addr);
+    DPRINTF("superio_ioport_readb  address 0x%lx\n", addr);
     return (superio_conf->config[superio_conf->index]);
 }

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 4811843..adb64ff 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -30,13 +30,16 @@
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"

-//#define DEBUG

-#ifdef DEBUG
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__,
##__VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                    \
+    if (DEBUG) {                                                  \
+        fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__); \
+    }                                                             \
+} while (0);

 #define GT_REGS (0x1000 >> 2)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 05c02fb..a2204b4 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -39,12 +39,15 @@
 /* debug CUDA packets */
 //#define DEBUG_CUDA_PACKET

-#ifdef DEBUG_CUDA
-#define CUDA_DPRINTF(fmt, ...)                                  \
-    do { printf("CUDA: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define CUDA_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_CUDA
+#define DEBUG_CUDA 0
+#endif
+
+#define CUDA_DPRINTF(fmt, ...) do {                           \
+    if (DEBUG_CUDA) {                                   \
+        fprintf(stderr, "CUDA: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);

 /* Bits in B data register: all active low */
 #define TREQ 0x08 /* Transfer request (input) */
diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
index 577ceba..c310f41 100644
--- a/hw/misc/puv3_pm.c
+++ b/hw/misc/puv3_pm.c
@@ -72,9 +72,9 @@ static uint64_t puv3_pm_read(void *opaque, hwaddr offset,
         ret = 0x7;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        DPRINTF("Bad offset 0x%lx\n", offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    DPRINTF("offset 0x%lx, value 0x%x\n", offset, ret);

     return ret;
 }
@@ -104,9 +104,9 @@ static void puv3_pm_write(void *opaque, hwaddr offset,
     case 0x38:
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        DPRINTF("Bad offset 0x%lx\n", offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    DPRINTF("offset 0x%lx, value 0x%lx\n", offset, value);
 }

 static const MemoryRegionOps puv3_pm_ops = {
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index efa33ad..1236990 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -25,13 +25,13 @@
 #include "qemu/timer.h"
 #include <zlib.h>

-//#define DEBUG_SONIC
+#ifndef DEBUG_SONIC
+#define DEBUG_SONIC  0
+#endif

 #define SONIC_PROM_SIZE 0x1000

 #ifdef DEBUG_SONIC
-#define DPRINTF(fmt, ...) \
-do { printf("sonic: " fmt , ##  __VA_ARGS__); } while (0)
 static const char* reg_names[] = {
     "CR", "DCR", "RCR", "TCR", "IMR", "ISR", "UTDA", "CTDA",
     "TPS", "TFC", "TSA0", "TSA1", "TFS", "URDA", "CRDA", "CRBA0",
@@ -41,10 +41,15 @@ static const char* reg_names[] = {
     "SR", "WT0", "WT1", "RSC", "CRCT", "FAET", "MPT", "MDT",
     "0x30", "0x31", "0x32", "0x33", "0x34", "0x35", "0x36", "0x37",
     "0x38", "0x39", "0x3a", "0x3b", "0x3c", "0x3d", "0x3e", "DCR2" };
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
 #endif

+#define DPRINTF(fmt, ...)                                   \
+    do {                                                    \
+        if (DEBUG_SONIC) {                                  \
+            fprintf(stderr, "sonic: " fmt, ## __VA_ARGS__); \
+        }                                                   \
+    } while (0)
+
 #define SONIC_ERROR(fmt, ...) \
 do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA_ARGS__); } while
(0)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 3db8937..427160a 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -22,17 +22,25 @@

 //#define DEBUG_LAN9118

+#ifndef DEBUG_LAN9118
+#define DEBUG_LAN9118 0
+#endif
+
 #ifdef DEBUG_LAN9118
-#define DPRINTF(fmt, ...) \
-do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
 #define BADF(fmt, ...) \
 do { hw_error("lan9118: error: " fmt , ## __VA_ARGS__);} while (0)
 #else
-#define DPRINTF(fmt, ...) do {} while(0)
 #define BADF(fmt, ...) \
 do { fprintf(stderr, "lan9118: error: " fmt , ## __VA_ARGS__);} while (0)
 #endif

+#define DPRINTF(fmt, ...)                                     \
+    do {                                                      \
+        if (DEBUG_LAN9118) {                                  \
+            fprintf(stderr, "lan9118: " fmt, ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)
+
 #define CSR_ID_REV      0x50
 #define CSR_IRQ_CFG     0x54
 #define CSR_INT_STS     0x58
@@ -1033,7 +1041,7 @@ static void lan9118_writel(void *opaque, hwaddr
offset,
         s->int_sts |= val & SW_INT;
         break;
     case CSR_FIFO_INT:
-        DPRINTF("FIFO INT levels %08x\n", val);
+        DPRINTF("FIFO INT levels %08x\n", (int)val);
         s->fifo_int = val;
         break;
     case CSR_RX_CFG:
@@ -1114,9 +1122,9 @@ static void lan9118_writel(void *opaque, hwaddr
offset,
         if (val & 0x80000000) {
             if (val & 0x40000000) {
                 s->mac_data = do_mac_read(s, val & 0xf);
-                DPRINTF("MAC read %d = 0x%08x\n", val & 0xf, s->mac_data);
+                DPRINTF("MAC read %lx = 0x%08x\n", val & 0xf, s->mac_data);
             } else {
-                DPRINTF("MAC write %d = 0x%08x\n", val & 0xf, s->mac_data);
+                DPRINTF("MAC write %lx = 0x%08x\n", val & 0xf,
s->mac_data);
                 do_mac_write(s, val & 0xf, s->mac_data);
             }
         }
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index bfa6b4b..b1430ee 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -18,12 +18,16 @@

 //#define DEBUG_FEC 1

-#ifdef DEBUG_FEC
-#define DPRINTF(fmt, ...) \
-do { printf("mcf_fec: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_FEC
+#define DEBUG_FEC 0
+#endif
+
+#define DPRINTF(fmt, ...)                                     \
+    do {                                                      \
+        if (DEBUG_FEC) {                                      \
+            fprintf(stderr, "mcf_fec: " fmt, ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)

 #define FEC_MAX_DESC 1024
 #define FEC_MAX_FRAME_SIZE 2032
@@ -557,7 +561,7 @@ static ssize_t mcf_fec_receive(NetClientState *nc,
const uint8_t *buf, size_t si
     unsigned int buf_len;
     size_t retsize;

-    DPRINTF("do_rx len %d\n", size);
+    DPRINTF("do_rx len %lx\n", size);
     if (!s->rx_enabled) {
         return -1;
     }
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 04bd10a..e6f5e28 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -13,16 +13,24 @@

 //#define DEBUG_STELLARIS_ENET 1

-#ifdef DEBUG_STELLARIS_ENET
-#define DPRINTF(fmt, ...) \
-do { printf("stellaris_enet: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__);
exit(1);} while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__);}
while (0)
-#endif
+#ifndef DEBUG_STELLARIS_ENET
+#define DEBUG_STELLARIS_ENET 0
+#endif
+
+#define DPRINTF(fmt, ...)                                            \
+    do {                                                             \
+        if (DEBUG_STELLARIS_ENET) {                                  \
+            fprintf(stderr, "stellaris_enet: " fmt, ## __VA_ARGS__); \
+        }                                                            \
+    } while (0)
+
+#define BADF(fmt, ...)                                                   \
+    do {                                                                 \
+        fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__); \
+        if (DEBUG_STELLARIS_ENET) {                                      \
+            exit(1);                                                     \
+        }                                                                \
+    } while (0)

 #define SE_INT_RX       0x01
 #define SE_INT_TXER     0x02
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index aef80e6..e152203 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -32,12 +32,16 @@
 /* debug NVR */
 //#define DEBUG_NVR

-#ifdef DEBUG_NVR
-#define NVR_DPRINTF(fmt, ...)                                   \
-    do { printf("NVR: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define NVR_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_NVR
+#define DEBUG_NVR 0
+#endif
+
+#define NVR_DPRINTF(fmt, ...)                             \
+    do {                                                  \
+        if (DEBUG_NVR) {                                  \
+            fprintf(stderr, "NVR: " fmt, ## __VA_ARGS__); \
+        }                                                 \
+    } while (0)

 #define DEF_SYSTEM_SIZE 0xc10

diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 840c961..84149da 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -32,14 +32,16 @@
 #include "hw/pci/pci_bus.h"

 /* debug DEC */
-//#define DEBUG_DEC
-
-#ifdef DEBUG_DEC
-#define DEC_DPRINTF(fmt, ...)                               \
-    do { printf("DEC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DEC_DPRINTF(fmt, ...)
-#endif
+
+#ifndef DEBUG_DEC
+#define DEBUG_DEC 0
+#endif
+
+#define DEC_DPRINTF(fmt, ...) do {                     \
+    if (DEBUG_DEC) {                                   \
+        fprintf(stderr, "DEC: " fmt , ## __VA_ARGS__); \
+    }                                                  \
+} while (0);

 #define DEC_21154(obj) OBJECT_CHECK(DECState, (obj), TYPE_DEC_21154)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 653e711..e1ef3db 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -41,12 +41,16 @@
 /* debug APB */
 //#define DEBUG_APB

-#ifdef DEBUG_APB
-#define APB_DPRINTF(fmt, ...) \
-do { printf("APB: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define APB_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_APB
+#define DEBUG_APB 0
+#endif
+
+#define APB_DPRINTF(fmt, ...)                             \
+    do {                                                  \
+        if (DEBUG_APB) {                                  \
+            fprintf(stderr, "APB: " fmt, ## __VA_ARGS__); \
+        }                                                 \
+    } while (0)

 /* debug IOMMU */
 //#define DEBUG_IOMMU
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1999ece..49a28de 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -49,11 +49,16 @@

 //#define DEBUG_BONITO

-#ifdef DEBUG_BONITO
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__,
##__VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_BONITO
+#define DEBUG_BONITO 0
+#endif
+
+#define DPRINTF(fmt, ...)                                             \
+    do {                                                              \
+        if (DEBUG_BONITO) {                                           \
+            fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__); \
+        }                                                             \
+    } while (0)

 /* from linux soure code. include/asm-mips/mips-boards/bonito64.h*/
 #define BONITO_BOOT_BASE        0x1fc00000
@@ -236,7 +241,7 @@ static void bonito_writel(void *opaque, hwaddr addr,

     saddr = addr >> 2;

-    DPRINTF("bonito_writel "TARGET_FMT_plx" val %x saddr %x\n", addr, val,
saddr);
+    DPRINTF("bonito_writel "TARGET_FMT_plx" val %lx saddr %x\n", addr,
val, saddr);
     switch (saddr) {
     case BONITO_BONPONCFG:
     case BONITO_IODEVCFG:
@@ -323,7 +328,7 @@ static void bonito_pciconf_writel(void *opaque, hwaddr
addr,
     PCIBonitoState *s = opaque;
     PCIDevice *d = PCI_DEVICE(s);

-    DPRINTF("bonito_pciconf_writel "TARGET_FMT_plx" val %x\n", addr, val);
+    DPRINTF("bonito_pciconf_writel "TARGET_FMT_plx" val %lx\n", addr, val);
     d->config_write(d, addr, val, 4);
 }

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 2c8acda..129929c 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -31,12 +31,16 @@
 /* debug Grackle */
 //#define DEBUG_GRACKLE

-#ifdef DEBUG_GRACKLE
-#define GRACKLE_DPRINTF(fmt, ...)                               \
-    do { printf("GRACKLE: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define GRACKLE_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_GRACKLE
+#define DEBUG_GRACKLE 0
+#endif
+
+#define GRACKLE_DPRINTF(fmt, ...)                             \
+    do {                                                      \
+        if (DEBUG_GRACKLE) {                                  \
+            fprintf(stderr, "GRACKLE: " fmt, ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)

 #define GRACKLE_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(GrackleState, (obj), TYPE_GRACKLE_PCI_HOST_BRIDGE)
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index df342ac..408b29f 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -30,12 +30,16 @@
 /* debug UniNorth */
 //#define DEBUG_UNIN

-#ifdef DEBUG_UNIN
-#define UNIN_DPRINTF(fmt, ...)                                  \
-    do { printf("UNIN: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define UNIN_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_UNIN
+#define DEBUG_UNIN 0
+#endif
+
+#define UNIN_DPRINTF(fmt, ...)                             \
+    do {                                                   \
+        if (DEBUG_UNIN) {                                  \
+            fprintf(stderr, "UNIN: " fmt, ## __VA_ARGS__); \
+        }                                                  \
+    } while (0)

 static const int unin_irq_line[] = { 0x1b, 0x1c, 0x1d, 0x1e };

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index a87b227..b7cfa5c 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -72,12 +72,17 @@ static inline uint8_t msi_cap_sizeof(uint16_t flags)

 //#define MSI_DEBUG

-#ifdef MSI_DEBUG
-# define MSI_DPRINTF(fmt, ...)                                          \
-    fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ## __VA_ARGS__)
-#else
-# define MSI_DPRINTF(fmt, ...)  do { } while (0)
-#endif
+#ifndef MSI_DEBUG
+#define MSI_DEBUG 0
+#endif
+
+#define MSI_DPRINTF(fmt, ...)
     \
+    do {
    \
+        if (MSI_DEBUG) {
    \
+            fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ##
__VA_ARGS__); \
+        }
     \
+    } while (0)
+
 #define MSI_DEV_PRINTF(dev, fmt, ...)                                   \
     MSI_DPRINTF("%s:%x " fmt, (dev)->name, (dev)->devfn, ## __VA_ARGS__)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e6b08e1..80d08af 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -43,11 +43,17 @@
 #include "qemu/cutils.h"

 //#define DEBUG_PCI
-#ifdef DEBUG_PCI
-# define PCI_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
-#else
-# define PCI_DPRINTF(format, ...)       do { } while (0)
-#endif
+//
+#ifndef DEBUG_PCI
+#define DEBUG_PCI 0
+#endif
+
+#define PCI_DPRINTF(fmt, ...)                             \
+    do {                                                  \
+        if (DEBUG_PCI) {                                  \
+            fprintf(stderr, "pci: " fmt, ## __VA_ARGS__); \
+        }                                                 \
+    } while (0)

 static void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static char *pcibus_get_dev_path(DeviceState *dev);
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5eaa935..83fde14 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -27,12 +27,16 @@
 /* debug PCI */
 //#define DEBUG_PCI

-#ifdef DEBUG_PCI
-#define PCI_DPRINTF(fmt, ...) \
-do { printf("pci_host_data: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define PCI_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_PCI
+#define DEBUG_PCI 0
+#endif
+
+#define PCI_DPRINTF(fmt, ...)                                       \
+    do {                                                            \
+        if (DEBUG_PCI) {                                            \
+            fprintf(stderr, "pci_host_data: " fmt, ## __VA_ARGS__); \
+        }                                                           \
+    } while (0)

 /*
  * PCI address
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 18e634f..5148f69 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -30,12 +30,18 @@
 #include "qemu/range.h"

 //#define DEBUG_PCIE
-#ifdef DEBUG_PCIE
-# define PCIE_DPRINTF(fmt, ...)                                         \
-    fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ## __VA_ARGS__)
-#else
-# define PCIE_DPRINTF(fmt, ...) do {} while (0)
-#endif
+
+#ifndef DEBUG_PCIE
+#define DEBUG_PCIE 0
+#endif
+
+#define PCIE_DPRINTF(fmt, ...)
    \
+    do {
    \
+        if (DEBUG_PCIE) {
     \
+            fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ##
__VA_ARGS__); \
+        }
     \
+    } while (0)
+
 #define PCIE_DEV_PRINTF(dev, fmt, ...)                                  \
     PCIE_DPRINTF("%s:%x "fmt, (dev)->name, (dev)->devfn, ## __VA_ARGS__)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index a8c1820..5dfedda 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -32,12 +32,18 @@
 #include "qapi/error.h"

 //#define DEBUG_PCIE
-#ifdef DEBUG_PCIE
-# define PCIE_DPRINTF(fmt, ...)                                         \
-    fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ## __VA_ARGS__)
-#else
-# define PCIE_DPRINTF(fmt, ...) do {} while (0)
-#endif
+
+#ifndef DEBUG_PCIE
+#define DEBUG_PCIE 0
+#endif
+
+#define PCIE_DPRINTF(fmt, ...)
   \
+    do {
   \
+        if (DEBUG_PCIE) {
    \
+            fprintf(stderr, "%s:%d " fmt, __func__, __LINE__, ##
__VA_ARGS__) \
+        }
    \
+    } while (0)
+
 #define PCIE_DEV_PRINTF(dev, fmt, ...)                                  \
     PCIE_DPRINTF("%s:%x "fmt, (dev)->name, (dev)->devfn, ## __VA_ARGS__)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 69b0291..6dd9bca 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -24,13 +24,17 @@
 #include "qemu/error-report.h"

 /* #define DEBUG_S390PCI_BUS */
-#ifdef DEBUG_S390PCI_BUS
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+
+#ifndef DEBUG_S390PCI_BUS
+#define DEBUG_S390PCI_BUS  0
+#endif
+
+#define DPRINTF(fmt, ...)                                         \
+    do {                                                          \
+        if (DEBUG_S390PCI_BUS) {                                  \
+            fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
+        }                                                         \
+    } while (0)

 S390pciState *s390_get_phb(void)
 {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index d2a8c0a..82b5617 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -21,13 +21,17 @@
 #include "sysemu/hw_accel.h"

 /* #define DEBUG_S390PCI_INST */
-#ifdef DEBUG_S390PCI_INST
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+
+#ifndef DEBUG_S390PCI_INST
+#define DEBUG_S390PCI_INST  0
+#endif
+
+#define DPRINTF(fmt, ...)                                          \
+    do {                                                           \
+        if (DEBUG_S390PCI_INST) {                                  \
+            fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); \
+        }                                                          \
+    } while (0)

 static void s390_set_status_code(CPUS390XState *env,
                                  uint8_t r, uint64_t status_code)
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 595c260..379db4b 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -24,16 +24,22 @@
 //#define DEBUG_LSI
 //#define DEBUG_LSI_REG

-#ifdef DEBUG_LSI
-#define DPRINTF(fmt, ...) \
-do { printf("lsi_scsi: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "lsi_scsi: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "lsi_scsi: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#ifndef DEBUG_LSI
+#define DEBUG_LSI 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                              \
+    if (DEBUG_LSI) {                                        \
+        fprintf(stderr, "lsi_scsi: " fmt , ## __VA_ARGS__); \
+    }                                                       \
+} while (0);
+
+#define BADF(fmt, ...) do {                                    \
+    fprintf(stderr, "lsi_scsi: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_LSI) {                                           \
+        exit(1);                                               \
+    }                                                          \
+} while (0);

 static const char *names[] = {
     "SCNTL0", "SCNTL1", "SCNTL2", "SCNTL3", "SCID", "SXFER", "SDID",
"GPREG",
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a53f058..33213df 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -19,14 +19,17 @@
  * the host adapter emulator.
  */

-//#define DEBUG_SCSI

-#ifdef DEBUG_SCSI
-#define DPRINTF(fmt, ...) \
-do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_SCSI
+#define DEBUG_SCSI 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                               \
+    if (DEBUG_SCSI) {                                        \
+        fprintf(stderr, "scsi-disk: " fmt , ## __VA_ARGS__); \
+    }                                                        \
+} while (0);
+

 #include "qemu/osdep.h"
 #include "qapi/error.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 2933119..8b97972 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -21,14 +21,15 @@

 #ifdef __linux__

-//#define DEBUG_SCSI
-
-#ifdef DEBUG_SCSI
-#define DPRINTF(fmt, ...) \
-do { printf("scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_SCSI
+#define DEBUG_SCSI 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                  \
+    if (DEBUG_SCSI) {                                           \
+        fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); \
+    }                                                           \
+} while (0);

 #define BADF(fmt, ...) \
 do { fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 82c63a4..e4d350f 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -16,14 +16,18 @@
 #include "qapi/error.h"

 //#define DEBUG_PL181 1
-
-#ifdef DEBUG_PL181
-#define DPRINTF(fmt, ...) \
-do { printf("pl181: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
+//
+#ifndef DEBUG_PL181
+#define DEBUG_PL181 0
 #endif

+#define DPRINTF(fmt, ...)                                   \
+    do {                                                    \
+        if (DEBUG_PL181) {                                  \
+            fprintf(stderr, "pl181: " fmt, ## __VA_ARGS__); \
+        }                                                   \
+    } while (0)
+
 #define PL181_FIFO_LEN 16

 #define TYPE_PL181 "pl181"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba47bff..f2cd369 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -43,13 +43,17 @@

 //#define DEBUG_SD 1

-#ifdef DEBUG_SD
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
+#ifndef DEBUG_SD
+#define DEBUG_SD 0
 #endif

+#define DPRINTF(fmt, ...)                                \
+    do {                                                 \
+        if (DEBUG_SD) {                                  \
+            fprintf(stderr, "SD: " fmt, ## __VA_ARGS__); \
+        }                                                \
+    } while (0)
+
 #define ACMD41_ENQUIRY_MASK     0x00ffffff
 #define OCR_POWER_UP            0x80000000
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 24001dc..c8168ae 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -18,18 +18,25 @@
 #include "qapi/error.h"

 //#define DEBUG_SSI_SD 1
-
-#ifdef DEBUG_SSI_SD
-#define DPRINTF(fmt, ...) \
-do { printf("ssi_sd: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssi_sd: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssi_sd: error: " fmt , ## __VA_ARGS__);} while (0)
+#ifndef DEBUG_SSI_SD
+#define DEBUG_SSI_SD 0
 #endif

+#define DPRINTF(fmt, ...)                                    \
+    do {                                                     \
+        if (DEBUG_SSI_SD) {                                  \
+            fprintf(stderr, "ssi_sd: " fmt, ## __VA_ARGS__); \
+        }                                                    \
+    } while (0)
+
+#define BADF(fmt, ...)                                          \
+    do {                                                        \
+        fprintf(stderr, "ssi_sd: error: " fmt, ## __VA_ARGS__); \
+        if (DEBUG_SSI_SD) {                                     \
+            exit(1);                                            \
+        }                                                       \
+    } while (0)
+
 typedef enum {
     SSI_SD_CMD = 0,
     SSI_SD_CMDARG,
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 4e4fdab..2f1136f 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -29,23 +29,25 @@
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"

-
-//#define DEBUG_IRQ
-//#define DEBUG_TIMER
-
-#ifdef DEBUG_IRQ
-#define CPUIRQ_DPRINTF(fmt, ...)                                \
-    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define CPUIRQ_DPRINTF(fmt, ...)
-#endif
-
-#ifdef DEBUG_TIMER
-#define TIMER_DPRINTF(fmt, ...)                                  \
-    do { printf("TIMER: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define TIMER_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_IRQ
+#define DEBUG_IRQ 0
+#endif
+
+#ifndef DEBUG_TIMER
+#define DEBUG_TIMER 0
+#endif
+
+#define CPUIRQ_DPRINTF(fmt, ...) do {                     \
+    if (DEBUG_IRQ) {                                      \
+        fprintf(stderr, "CPUIRQ: " fmt , ## __VA_ARGS__); \
+    }                                                     \
+} while (0);
+
+#define TIMER_DPRINTF(fmt, ...) do {                     \
+    if (DEBUG_TIMER) {                                   \
+        fprintf(stderr, "TIMER: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);

 #define TICK_MAX             0x7fffffffffffffffULL

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d347b66..c27b738 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -46,14 +46,16 @@
 #include "elf.h"
 #include "qemu/cutils.h"

-//#define DEBUG_EBUS

-#ifdef DEBUG_EBUS
-#define EBUS_DPRINTF(fmt, ...)                                  \
-    do { printf("EBUS: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define EBUS_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_EBUS
+#define DEBUG_EBUS 0
+#endif
+
+#define EBUS_DPRINTF(fmt, ...) do {                     \
+    if (DEBUG_EBUS) {                                   \
+        fprintf(stderr, "EBUS: " fmt , ## __VA_ARGS__); \
+    }                                                   \
+} while (0);

 #define KERNEL_LOAD_ADDR     0x00404000
 #define CMDLINE_ADDR         0x003ff000
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index c136801..bf1cc3a 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -12,18 +12,22 @@
 #include "hw/ssi/ssi.h"
 #include "qemu/log.h"

-//#define DEBUG_PL022 1
-
-#ifdef DEBUG_PL022
-#define DPRINTF(fmt, ...) \
-do { printf("pl022: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "pl022: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "pl022: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#ifndef DEBUG_PL022
+#define DEBUG_PL022  0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (DEBUG_PL022) {                                   \
+        fprintf(stderr, "pl022: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);
+
+#define BADF(fmt, ...) do {                                 \
+    fprintf(stderr, "pl022: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_PL022) {                                   \
+        exit(1);                                            \
+    }                                                       \
+} while (0);

 #define PL022_CR1_LBM 0x01
 #define PL022_CR1_SSE 0x02
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 0c18934..ebda0d3 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -61,15 +61,16 @@

 #include "hw/arm/exynos4210.h"

-//#define DEBUG_MCT

-#ifdef DEBUG_MCT
-#define DPRINTF(fmt, ...) \
-        do { fprintf(stdout, "MCT: [%24s:%5d] " fmt, __func__, __LINE__, \
-                     ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_MCT
+#define DEBUG_MCT 0
+#endif
+
+#define DPRINTF(fmt, ...) do {
           \
+    if (DEBUG_MCT) {
           \
+        fprintf(stdout, "MCT: [%24s:%5d] " fmt, __func__, __LINE__,  ##
__VA_ARGS__); \
+    }
            \
+} while (0);

 #define    MCT_CFG          0x000
 #define    G_CNT_L          0x100
@@ -366,7 +367,7 @@ static void
exynos4210_mct_update_freq(Exynos4210MCTState *s);
 static void exynos4210_gfrc_set_count(Exynos4210MCTGT *s, uint64_t count)
 {
     s->count = count;
-    DPRINTF("global timer frc set count 0x%llx\n", count);
+    DPRINTF("global timer frc set count 0x%lx\n", count);
     ptimer_set_count(s->ptimer_frc, count);
 }

@@ -463,7 +464,7 @@ static int32_t exynos4210_gcomp_find(Exynos4210MCTState
*s)
         res = min_comp_i;
     }

-    DPRINTF("found comparator %d: comp 0x%llx distance 0x%llx, gfrc
0x%llx\n",
+    DPRINTF("found comparator %d: comp 0x%lx distance 0x%lx, gfrc 0x%lx\n",
             res,
             s->g_timer.reg.comp[res],
             distance_min,
@@ -902,7 +903,7 @@ static void exynos4210_ltick_event(void *opaque)
         if (s->reg.int_enb & L_INT_INTENB_ICNTEIE) {
 #ifdef DEBUG_MCT
             time2[s->id] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            DPRINTF("local timer[%d] IRQ: %llx\n", s->id,
+            DPRINTF("local timer[%d] IRQ: %lx\n", s->id,
                     time2[s->id] - time1[s->id]);
             time1[s->id] = time2[s->id];
 #endif
@@ -1006,7 +1007,7 @@ static uint64_t exynos4210_mct_read(void *opaque,
hwaddr offset,
         shift = 8 * (offset & 0x4);
         count = exynos4210_gfrc_get_count(&s->g_timer);
         value = UINT32_MAX & (count >> shift);
-        DPRINTF("read FRC=0x%llx\n", count);
+        DPRINTF("read FRC=0x%lx\n", count);
         break;

     case G_CNT_WSTAT:
@@ -1128,14 +1129,14 @@ static void exynos4210_mct_write(void *opaque,
hwaddr offset,
     case G_CNT_U:
         if (offset == G_CNT_L) {

-            DPRINTF("global timer write to reg.cntl %llx\n", value);
+            DPRINTF("global timer write to reg.cntl %lx\n", value);

             new_frc = (s->g_timer.reg.cnt & (uint64_t)UINT32_MAX << 32) +
value;
             s->g_timer.reg.cnt_wstat |= G_CNT_WSTAT_L;
         }
         if (offset == G_CNT_U) {

-            DPRINTF("global timer write to reg.cntu %llx\n", value);
+            DPRINTF("global timer write to reg.cntu %lx\n", value);

             new_frc = (s->g_timer.reg.cnt & UINT32_MAX) +
                     ((uint64_t)value << 32);
@@ -1159,7 +1160,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
             (((uint64_t)UINT32_MAX << 32) >> shift)) +
             (value << shift);

-    DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
+    DPRINTF("comparator %d write 0x%lx val << %d\n", index, value, shift);

     if (offset&0x4) {
         s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
@@ -1175,7 +1176,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
         s->g_timer.reg.tcon = value;
         s->g_timer.reg.wstat |= G_WSTAT_TCON_WRITE;

-        DPRINTF("global timer write to reg.g_tcon %llx\n", value);
+        DPRINTF("global timer write to reg.g_tcon %lx\n", value);

         /* Start FRC if transition from disabled to enabled */
         if ((value & G_TCON_TIMER_ENABLE) > (old_val &
@@ -1222,7 +1223,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
             }
         }

-        DPRINTF("global timer INT enable %llx\n", value);
+        DPRINTF("global timer INT enable %lx\n", value);
         s->g_timer.reg.int_enb = value;
         break;

@@ -1309,7 +1310,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
         if (tcntb_max[lt_i] < value) {
             tcntb_max[lt_i] = value;
         }
-        DPRINTF("local timer[%d] TCNTB write %llx; max=%x, min=%x\n",
+        DPRINTF("local timer[%d] TCNTB write %lx; max=%x, min=%x\n",
                 lt_i, value, tcntb_max[lt_i], tcntb_min[lt_i]);
 #endif
         break;
@@ -1352,7 +1353,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
         if (icntb_max[lt_i] < value) {
             icntb_max[lt_i] = value;
         }
-DPRINTF("local timer[%d] ICNTB write %llx; max=%x, min=%x\n\n",
+DPRINTF("local timer[%d] ICNTB write %lx; max=%x, min=%x\n\n",
         lt_i, value, icntb_max[lt_i], icntb_min[lt_i]);
 #endif
 break;
@@ -1362,7 +1363,7 @@ break;
         lt_i = GET_L_TIMER_IDX(offset);
         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);

-        DPRINTF("local timer[%d] FRCNTB write %llx\n", lt_i, value);
+        DPRINTF("local timer[%d] FRCNTB write %lx\n", lt_i, value);

         s->l_timer[lt_i].reg.wstat |= L_WSTAT_FRCCNTB_WRITE;
         s->l_timer[lt_i].reg.cnt[L_REG_CNT_FRCCNTB] = value;
@@ -1379,7 +1380,7 @@ break;
     case L0_INT_CSTAT: case L1_INT_CSTAT:
         lt_i = GET_L_TIMER_IDX(offset);

-        DPRINTF("local timer[%d] CSTAT write %llx\n", lt_i, value);
+        DPRINTF("local timer[%d] CSTAT write %lx\n", lt_i, value);

         s->l_timer[lt_i].reg.int_cstat &= ~value;
         if (!s->l_timer[lt_i].reg.int_cstat) {
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index f576507..1dbff74 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -29,15 +29,15 @@

 #include "hw/arm/exynos4210.h"

-//#define DEBUG_PWM
-
-#ifdef DEBUG_PWM
-#define DPRINTF(fmt, ...) \
-        do { fprintf(stdout, "PWM: [%24s:%5d] " fmt, __func__, __LINE__, \
-                ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_PWM
+#define DEBUG_PWM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {
           \
+    if (DEBUG_PWM) {
           \
+         fprintf(stdout, "PWM: [%24s:%5d] " fmt, __func__, __LINE__, ##
__VA_ARGS__); \
+    }
            \
+} while (0);

 #define     EXYNOS4210_PWM_TIMERS_NUM      5
 #define     EXYNOS4210_PWM_REG_MEM_SIZE    0x50
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index 1a648c5..4436043 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -39,13 +39,11 @@

 #define DEBUG_RTC 0

-#if DEBUG_RTC
-#define DPRINTF(fmt, ...) \
-        do { fprintf(stdout, "RTC: [%24s:%5d] " fmt, __func__, __LINE__, \
-                ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#define DPRINTF(fmt, ...) do {
           \
+    if (DEBUG_RTC) {
           \
+        fprintf(stdout, "RTC: [%24s:%5d] " fmt, __func__, __LINE__,  ##
__VA_ARGS__); \
+    }
            \
+} while (0);

 #define     EXYNOS4210_RTC_REG_MEM_SIZE     0x0100

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index a2c18b3..38167a7 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -36,12 +36,16 @@
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"

-//#define HPET_DEBUG
-#ifdef HPET_DEBUG
-#define DPRINTF printf
-#else
-#define DPRINTF(...)
-#endif
+
+#ifndef HPET_DEBUG
+#define HPET_DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                 \
+    if (HPET_DEBUG) {                          \
+        fprintf(stderr, fmt , ## __VA_ARGS__); \
+    }                                          \
+} while (0);

 #define HPET_MSI_SUPPORT        0

@@ -387,7 +391,7 @@ static void hpet_del_timer(HPETTimer *t)
     update_irq(t, 0);
 }

-#ifdef HPET_DEBUG
+#if HPET_DEBUG
 static uint32_t hpet_ram_readb(void *opaque, hwaddr addr)
 {
     printf("qemu: hpet_read b at %" PRIx64 "\n", addr);
@@ -480,7 +484,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     HPETState *s = opaque;
     uint64_t old_val, new_val, val, index;

-    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr,
value);
+    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#lx\n", addr,
value);
     index = addr;
     old_val = hpet_ram_read(opaque, addr, 4);
     new_val = value;
@@ -622,7 +626,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffff00000000ULL) | value;
-            DPRINTF("qemu: HPET counter written. ctr = %#x -> %" PRIx64
"\n",
+            DPRINTF("qemu: HPET counter written. ctr = %#lx -> %" PRIx64
"\n",
                     value, s->hpet_counter);
             break;
         case HPET_COUNTER + 4:
@@ -631,7 +635,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) <<
32);
-            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %"
PRIx64 "\n",
+            DPRINTF("qemu: HPET counter + 4 written. ctr = %#lx -> %"
PRIx64 "\n",
                     value, s->hpet_counter);
             break;
         default:
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 4165450..dbf3dcc 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -37,20 +37,25 @@
 #include "hw/i386/apic.h"
 #endif

-//#define DEBUG_CMOS
-//#define DEBUG_COALESCED
-
-#ifdef DEBUG_CMOS
-# define CMOS_DPRINTF(format, ...)      printf(format, ## __VA_ARGS__)
-#else
-# define CMOS_DPRINTF(format, ...)      do { } while (0)
-#endif
-
-#ifdef DEBUG_COALESCED
-# define DPRINTF_C(format, ...)      printf(format, ## __VA_ARGS__)
-#else
-# define DPRINTF_C(format, ...)      do { } while (0)
-#endif
+#ifndef DEBUG_CMOS
+#define DEBUG_CMOS 0
+#endif
+
+#ifndef DEBUG_COALESCED
+#define DEBUG_COALESCED 0
+#endif
+
+#define CMOS_DPRINTF(fmt, ...) do {           \
+    if (DEBUG_CMOS) {                         \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);
+
+#define DPRINTF_C(fmt, ...) do {              \
+    if (DEBUG_COALESCED) {                    \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define SEC_PER_MIN     60
 #define MIN_PER_HOUR    60
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index dbbeb9b..08533de 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -18,14 +18,15 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"

-//#define DEBUG_PL031
-
-#ifdef DEBUG_PL031
-#define DPRINTF(fmt, ...) \
-do { printf("pl031: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_PL031
+#define DEBUG_PL031 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (DEBUG_PL031) {                                   \
+        fprintf(stderr, "pl031: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);

 #define RTC_DR      0x00    /* Data read register */
 #define RTC_MR      0x04    /* Match register */
diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 0b3d717..11af32d 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -53,7 +53,7 @@ static uint64_t puv3_ost_read(void *opaque, hwaddr offset,
     default:
         DPRINTF("Bad offset %x\n", (int)offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    DPRINTF("offset 0x%lx, value 0x%x\n", offset, ret);
     return ret;
 }

@@ -62,7 +62,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
 {
     PUV3OSTState *s = opaque;

-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    DPRINTF("offset 0x%lx, value 0x%lx\n", offset, value);
     switch (offset) {
     case 0x00: /* Match Register 0 */
         s->reg_OSMR0 = value;
diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index 31052322..db68561 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -15,14 +15,16 @@
 #include "qemu/timer.h"
 #include "hw/timer/sun4v-rtc.h"

-//#define DEBUG_SUN4V_RTC
-
-#ifdef DEBUG_SUN4V_RTC
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("sun4v_rtc: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+
+#ifndef DEBUG_SUN4V_RTC
+#define DEBUG_SUN4V_RTC 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                               \
+    if (DEBUG_SUN4V_RTC) {                                   \
+        fprintf(stderr, "sun4v_rtc: " fmt , ## __VA_ARGS__); \
+    }                                                        \
+} while (0);

 #define TYPE_SUN4V_RTC "sun4v_rtc"
 #define SUN4V_RTC(obj) OBJECT_CHECK(Sun4vRtc, (obj), TYPE_SUN4V_RTC)
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 6d51373..739e79b 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -17,14 +17,15 @@
 #include "hw/usb/desc.h"
 #include "sysemu/char.h"

-//#define DEBUG_Serial
-
-#ifdef DEBUG_Serial
-#define DPRINTF(fmt, ...) \
-do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_Serial
+#define DEBUG_Serial 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                              \
+    if (DEBUG_Serial) {                                     \
+        fprintf(stderr, "usb-serial: " fmt,## __VA_ARGS__); \
+    }                                                       \
+} while (0);

 #define RECV_BUF 384

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8a61ec9..b85c006 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -24,14 +24,15 @@
 #include "qapi/visitor.h"
 #include "qemu/cutils.h"

-//#define DEBUG_MSD
-
-#ifdef DEBUG_MSD
-#define DPRINTF(fmt, ...) \
-do { printf("usb-msd: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_MSD
+#define DEBUG_MSD 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                             \
+    if (DEBUG_MSD) {                                       \
+        fprintf(stderr, "usb-msd: " fmt , ## __VA_ARGS__); \
+    }                                                      \
+} while (0);

 /* USB requests.  */
 #define MassStorageReset  0xff
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 938d8aa..ca6094e 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -30,11 +30,11 @@
 #define EHCI_DEBUG   0
 #endif

-#if EHCI_DEBUG
-#define DPRINTF printf
-#else
-#define DPRINTF(...)
-#endif
+#define DPRINTF(fmt, ...) do {                \
+    if (EHCI_DEBUG) {                         \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define MMIO_SIZE        0x1000
 #define CAPA_SIZE        0x10
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f0af852..9f5e5b2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -32,11 +32,16 @@
 //#define DEBUG_XHCI
 //#define DEBUG_DATA

-#ifdef DEBUG_XHCI
-#define DPRINTF(...) fprintf(stderr, __VA_ARGS__)
-#else
-#define DPRINTF(...) do {} while (0)
-#endif
+#ifndef DEBUG_XHCI
+#define DEBUG_XHCI 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                 \
+    if (DEBUG_XHCI) {                          \
+        fprintf(stderr, fmt , ## __VA_ARGS__); \
+    }                                          \
+} while (0);
+
 #define FIXME(_msg) do { fprintf(stderr, "FIXME %s:%d %s\n", \
                                  __func__, __LINE__, _msg); abort(); }
while (0)

@@ -1806,7 +1811,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
         ep = xhci_epid_to_usbep(xfer->epctx);
         if (!ep) {
             DPRINTF("xhci: slot %d has no device\n",
-                    xfer->slotid);
+                    xfer->epctx->slotid);
             return -1;
         }
     }
@@ -1980,7 +1985,7 @@ static int xhci_submit(XHCIState *xhci, XHCITransfer
*xfer, XHCIEPContext *epctx
 {
     uint64_t mfindex;

-    DPRINTF("xhci_submit(slotid=%d,epid=%d)\n", xfer->slotid, xfer->epid);
+    DPRINTF("xhci_submit(slotid=%d,epid=%d)\n", xfer->epctx->slotid,
xfer->epctx->epid);

     xfer->in_xfer = epctx->type>>2;

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 3042232..35cfef5 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -31,15 +31,20 @@
 #include "hw/virtio/virtio.h"
 #include "exec/address-spaces.h"

+
 /* #define DEBUG_VIRTIO_BUS */

-#ifdef DEBUG_VIRTIO_BUS
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_bus: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
+#ifndef DEBUG_VIRTIO_BUS
+#define DEBUG_VIRTIO_BUS 0
 #endif

+#define DPRINTF(fmt, ...)                                        \
+    do {                                                         \
+        if (DEBUG_VIRTIO_BUS) {                                  \
+            fprintf(stderr, "virtio_bus: " fmt, ## __VA_ARGS__); \
+        }                                                        \
+    } while (0)
+
 /* A VirtIODevice is being plugged */
 void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
 {
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa8..31e3094 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -30,13 +30,16 @@

 /* #define DEBUG_VIRTIO_MMIO */

-#ifdef DEBUG_VIRTIO_MMIO
-
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_VIRTIO_MMIO
+#define DEBUG_VIRTIO_MMIO  0
+#endif
+
+#define DPRINTF(fmt, ...)                                         \
+    do {                                                          \
+        if (DEBUG_VIRTIO_MMIO) {                                  \
+            fprintf(stderr, "virtio_mmio: " fmt, ## __VA_ARGS__); \
+        }                                                         \
+    } while (0)

 /* QOM macros */
 /* virtio-mmio-bus */
diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
index 5a4839f..e9e3ae6 100644
--- a/include/hw/unicore32/puv3.h
+++ b/include/hw/unicore32/puv3.h
@@ -41,10 +41,15 @@
 #define PUV3_IRQS_OST0          (26)

 /* All puv3_*.c use DPRINTF for debug. */
-#ifdef DEBUG_PUV3
-#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+
+#ifndef DEBUG_PUV3
+#define DEBUG_PUV3 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                 \
+    if (DEBUG_PUV3) {                                          \
+        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
+    }                                                          \
+} while (0);

 #endif /* QEMU_HW_PUV3_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c582de1..3d3cc89 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -33,14 +33,15 @@
 #define ERR_PREFIX "vfio error: %s: "
 #define WARN_PREFIX "vfio warning: %s: "

-/*#define DEBUG_VFIO*/
-#ifdef DEBUG_VFIO
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_VFIO
+#define DEBUG_VFIO 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                         \
+    if (DEBUG_VFIO) {                                  \
+        fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); \
+    }                                                  \
+} while (0);

 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
diff --git a/kvm-all.c b/kvm-all.c
index 90b8573..47940b5 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -50,16 +50,16 @@
  */
 #define PAGE_SIZE getpagesize()

-//#define DEBUG_KVM
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
+#ifndef DEBUG_KVM
+#define DEBUG_KVM 0
 #endif

+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                        \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);
+
 #define KVM_MSI_HASHTAB_SIZE    256

 struct KVMParkedVcpu {
diff --git a/migration/block.c b/migration/block.c
index 7734ff7..a5b4e49 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -42,13 +42,15 @@

 //#define DEBUG_BLK_MIGRATION

-#ifdef DEBUG_BLK_MIGRATION
-#define DPRINTF(fmt, ...) \
-    do { printf("blk_migration: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_BLK_MIGRATION
+#define DEBUG_BLK_MIGRATION 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                  \
+    if (DEBUG_BLK_MIGRATION) {                                  \
+        fprintf(stderr, "blk_migration: " fmt, ## __VA_ARGS__); \
+    }                                                           \
+} while (0);

 typedef struct BlkMigDevState {
     /* Written during setup phase.  Can be read without a lock.  */
diff --git a/page_cache.c b/page_cache.c
index 5f85787..783a9a4 100644
--- a/page_cache.c
+++ b/page_cache.c
@@ -18,13 +18,16 @@
 #include "qemu/host-utils.h"
 #include "migration/page_cache.h"

-#ifdef DEBUG_CACHE
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stdout, "cache: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+
+#ifndef DEBUG_CACHE
+#define DEBUG_CACHE 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                          \
+    if (DEBUG_CACHE) {                                  \
+        fprintf(stderr, "cache: " fmt, ## __VA_ARGS__); \
+    }                                                   \
+} while (0);

 /* the page in cache will not be replaced in two cycles */
 #define CACHED_PAGE_LIFETIME 2
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55865db..46762e2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -47,15 +47,15 @@
 #include "exec/memattrs.h"
 #include "trace.h"

-//#define DEBUG_KVM
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_KVM
+#define DEBUG_KVM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                         \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define MSR_KVM_WALL_CLOCK  0x11
 #define MSR_KVM_SYSTEM_TIME 0x12
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9f1f132..5425055 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -50,15 +50,15 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #endif

-//#define DEBUG_KVM
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_KVM
+#define DEBUG_KVM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                         \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ac47154..ac994fe 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -47,15 +47,15 @@
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"

-/* #define DEBUG_KVM */
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_KVM
+#define DEBUG_KVM  0
+#endif
+
+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                          \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define kvm_vm_check_mem_attr(s, attr) \
     kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 57968d9..7fe9b85 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -25,38 +25,49 @@
 #include "exec/cpu_ldst.h"
 #include "asi.h"

-//#define DEBUG_MMU
-//#define DEBUG_MXCC
 //#define DEBUG_UNALIGNED
 //#define DEBUG_UNASSIGNED
-//#define DEBUG_ASI
-//#define DEBUG_CACHE_CONTROL

-#ifdef DEBUG_MMU
-#define DPRINTF_MMU(fmt, ...)                                   \
-    do { printf("MMU: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF_MMU(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_MMU
+#define DEBUG_MMU 0
+#endif

-#ifdef DEBUG_MXCC
-#define DPRINTF_MXCC(fmt, ...)                                  \
-    do { printf("MXCC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF_MXCC(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_MXCC
+#define DEBUG_MXCC 0
+#endif

-#ifdef DEBUG_ASI
-#define DPRINTF_ASI(fmt, ...)                                   \
-    do { printf("ASI: " fmt , ## __VA_ARGS__); } while (0)
-#endif
+#ifndef DEBUG_ASI
+#define DEBUG_ASI 0
+#endif

-#ifdef DEBUG_CACHE_CONTROL
-#define DPRINTF_CACHE_CONTROL(fmt, ...)                                 \
-    do { printf("CACHE_CONTROL: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF_CACHE_CONTROL(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_CACHE_CONTROL
+#define DEBUG_CACHE_CONTROL 0
+#endif
+
+
+#define DPRINTF_MMU(fmt, ...) do {                    \
+    if (DEBUG_MMU) {                                  \
+        fprintf(stderr, "MMU: " fmt, ## __VA_ARGS__); \
+    }                                                 \
+} while (0);
+
+#define DPRINTF_MXCC(fmt, ...) do {                    \
+    if (DEBUG_MXCC) {                                  \
+        fprintf(stderr, "MXCC: " fmt, ## __VA_ARGS__); \
+    }                                                  \
+} while (0);
+
+#define DPRINTF_ASI(fmt, ...) do {                    \
+    if (DEBUG_ASI) {                                  \
+        fprintf(stderr, "ASI: " fmt, ## __VA_ARGS__); \
+    }                                                 \
+} while (0);
+
+#define DPRINTF_CACHE_CONTROL(fmt, ...) do {                    \
+    if (DEBUG_CACHE_CONTROL) {                                  \
+        fprintf(stderr, "CACHE_CONTROL: " fmt, ## __VA_ARGS__); \
+    }                                                           \
+} while (0);

 #ifdef TARGET_SPARC64
 #ifndef TARGET_ABI32
@@ -1631,7 +1642,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong
addr, target_ulong val,

             if (oldreg != env->immu.mmuregs[reg]) {
                 DPRINTF_MMU("immu change reg[%d]: 0x%016" PRIx64 " ->
0x%016"
-                            PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
+                            PRIx64 "\n", reg, oldreg,
env->immu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(stdout, fprintf, env);
@@ -1715,7 +1726,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong
addr, target_ulong val,

             if (oldreg != env->dmmu.mmuregs[reg]) {
                 DPRINTF_MMU("dmmu change reg[%d]: 0x%016" PRIx64 " ->
0x%016"
-                            PRIx64 "\n", reg, oldreg, env->dmmuregs[reg]);
+                            PRIx64 "\n", reg, oldreg,
env->dmmu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
             dump_mmu(stdout, fprintf, env);
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index f9239dc..5df8de0 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -19,13 +19,15 @@
 #include "ui/console.h"
 #endif

-#undef DEBUG_UC32
-
-#ifdef DEBUG_UC32
-#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_UC32
+#define DEBUG_UC32 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                 \
+    if (DEBUG_UC32) {                                          \
+        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
+    }                                                          \
+} while (0);

 UniCore32CPU *uc32_cpu_init(const char *cpu_model)
 {
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index e7152e7..173875b 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -16,13 +16,15 @@
 #include "cpu.h"
 #include "exec/exec-all.h"

-#undef DEBUG_UC32
+#ifndef DEBUG_UC32
+#define DEBUG_UC32 0
+#endif

-#ifdef DEBUG_UC32
-#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#define DPRINTF(fmt, ...) do {                                 \
+    if (DEBUG_UC32) {                                          \
+        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
+    }                                                          \
+} while (0);

 #define SUPERPAGE_SIZE             (1 << 22)
 #define UC32_PAGETABLE_READ        (1 << 8)
diff --git a/xen-common.c b/xen-common.c
index fd2c928..9361974 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -15,15 +15,15 @@
 #include "sysemu/accel.h"
 #include "migration/migration.h"

-//#define DEBUG_XEN
-
-#ifdef DEBUG_XEN
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_XEN
+#define DEBUG_XEN 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                        \
+    if (DEBUG_XEN) {                                  \
+        fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); \
+    }                                                 \
+} while (0);

 static int store_dev_info(int domid, Chardev *cs, const char *string)
 {
diff --git a/xen-hvm.c b/xen-hvm.c
index 5043beb..abf0f72 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -29,15 +29,15 @@
 #include <xen/hvm/params.h>
 #include <xen/hvm/e820.h>

-//#define DEBUG_XEN_HVM
-
-#ifdef DEBUG_XEN_HVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_XEN_HVM
+#define DEBUG_XEN_HVM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                        \
+    if (DEBUG_XEN_HVM) {                              \
+        fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); \
+    }                                                 \
+} while (0);

 static MemoryRegion ram_memory, ram_640k, ram_lo, ram_hi;
 static MemoryRegion *framebuffer;
diff --git a/xen-mapcache.c b/xen-mapcache.c
index 1a96d2e..c2d1e6f 100644
--- a/xen-mapcache.c
+++ b/xen-mapcache.c
@@ -22,15 +22,15 @@
 #include "trace-root.h"


-//#define MAPCACHE_DEBUG
-
-#ifdef MAPCACHE_DEBUG
-#  define DPRINTF(fmt, ...) do { \
-    fprintf(stderr, "xen_mapcache: " fmt, ## __VA_ARGS__); \
-} while (0)
-#else
-#  define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef MAPCACHE_DEBUG
+#define MAPCACHE_DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                 \
+    if (MAPCACHE_DEBUG) {                                      \
+        fprintf(stderr, "xen_mapcache: " fmt, ## __VA_ARGS__); \
+    }                                                          \
+} while (0);

 #if HOST_LONG_BITS == 32
 #  define MCACHE_BUCKET_SHIFT 16
-- 
2.9.3
