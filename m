Received: from eggs.gnu.org ([2001:4830:134:3::10]:41179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHV-0003EG-Ip
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHT-0006pM-SI
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:27:49 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:04 -0300
Message-Id: <20180305112732.26471-3-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 02/30] hw: include "qemu/cunits.h" and
 clean unused "qemu/cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paul Burton <paul.burton@mips.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>

These files were including "qemu/cutils.h" to use the byte-based size
definitions, now available in "qemu/cunits.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

Thomas suggested:

    Instead of adding this to a header and creating yet another possible
    recompile-the-world dependency this way, wouldn't it be better to
    include the cunits.h only from the .c files that need the definitions?

 include/hw/hw.h       | 1 +
 hw/arm/msf2-soc.c     | 1 -
 hw/arm/msf2-som.c     | 1 -
 hw/core/loader-fit.c  | 1 -
 hw/core/loader.c      | 1 -
 hw/core/machine.c     | 1 -
 hw/cris/boot.c        | 1 -
 hw/display/sm501.c    | 1 -
 hw/hppa/machine.c     | 1 -
 hw/lm32/milkymist.c   | 1 -
 hw/microblaze/boot.c  | 1 -
 hw/mips/boston.c      | 1 -
 hw/misc/mos6522.c     | 1 -
 hw/nios2/boot.c       | 1 -
 hw/ppc/mac_newworld.c | 1 -
 hw/ppc/mac_oldworld.c | 1 -
 hw/ppc/pnv.c          | 1 -
 hw/ppc/prep.c         | 1 -
 hw/ppc/spapr_rtas.c   | 1 -
 hw/sd/sdhci.c         | 1 -
 hw/sparc/sun4m.c      | 1 -
 hw/sparc64/sun4u.c    | 1 -
 hw/usb/dev-serial.c   | 1 -
 hw/usb/dev-storage.c  | 1 -
 24 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/include/hw/hw.h b/include/hw/hw.h
index ab4950c312..8249448cac 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -14,6 +14,7 @@
 #include "migration/qemu-file-types.h"
 #include "qemu/module.h"
 #include "sysemu/reset.h"
+#include "qemu/cunits.h"
 
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index a8ec2cdf36..952cda45ed 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -30,7 +30,6 @@
 #include "hw/char/serial.h"
 #include "hw/boards.h"
 #include "sysemu/block-backend.h"
-#include "qemu/cutils.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 0795a3a3a1..d3e6ed00fe 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -28,7 +28,6 @@
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 #include "hw/arm/msf2-soc.h"
 #include "cpu.h"
 
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 0c4a7207f4..0208e5b357 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -22,7 +22,6 @@
 #include "exec/memory.h"
 #include "hw/loader.h"
 #include "hw/loader-fit.h"
-#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 76b244c508..ce0aefe5c2 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -54,7 +54,6 @@
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
-#include "qemu/cutils.h"
 
 #include <zlib.h>
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5d445839e8..7a7ec0c1e1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -19,7 +19,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "qemu/error-report.h"
-#include "qemu/cutils.h"
 #include "sysemu/qtest.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index f896ed7f86..7d423ed92f 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -29,7 +29,6 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "boot.h"
-#include "qemu/cutils.h"
 
 static void main_cpu_reset(void *opaque)
 {
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index f4bb33c279..00cf8358e2 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -24,7 +24,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 19033e268d..22a15112df 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -17,7 +17,6 @@
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
 #include "hw/hppa/hppa_sys.h"
-#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 85d64fe58d..471a74eaa1 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -34,7 +34,6 @@
 #include "milkymist-hw.h"
 #include "lm32.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 
 #define BIOS_FILENAME    "mmone-bios.bin"
 #define BIOS_OFFSET      0x00860000
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 35bfeda7aa..5b30d63c17 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -34,7 +34,6 @@
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "qemu/cutils.h"
 
 #include "boot.h"
 
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index fb23161b33..e99f3638cf 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -32,7 +32,6 @@
 #include "hw/mips/cpudevs.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "qapi/error.h"
-#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 8ad9fc831e..b55e6acbe2 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -29,7 +29,6 @@
 #include "hw/misc/mos6522.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
-#include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "trace.h"
 
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 94f436e7fb..771e00267b 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -38,7 +38,6 @@
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "qemu/cutils.h"
 
 #include "boot.h"
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 4e1298ee50..77d4e9b013 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -71,7 +71,6 @@
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"
-#include "qemu/cutils.h"
 #include "trace.h"
 
 #define MAX_IDE_BUS 2
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index d0d21d2392..c245251c5c 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -45,7 +45,6 @@
 #include "kvm_ppc.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 98ee3c607a..3d943dd71b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -31,7 +31,6 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 #include "qapi/visitor.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 096d4d4cfb..f7c0a48558 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -50,7 +50,6 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
 #include "elf.h"
-#include "qemu/cutils.h"
 #include "kvm_ppc.h"
 
 /* SMP is not enabled, for now */
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 4bb939d3d1..7e26a9fb5a 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -43,7 +43,6 @@
 
 #include <libfdt.h>
 #include "hw/ppc/spapr_drc.h"
-#include "qemu/cutils.h"
 #include "trace.h"
 #include "hw/ppc/fdt.h"
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 97b4a473c8..cf935c2008 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -34,7 +34,6 @@
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 #include "qemu/log.h"
-#include "qemu/cutils.h"
 #include "trace.h"
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 61eb424bbc..9d82490794 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -46,7 +46,6 @@
 #include "elf.h"
 #include "sysemu/block-backend.h"
 #include "trace.h"
-#include "qemu/cutils.h"
 
 /*
  * Sun4m architecture was used in the following machines:
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index da28ab9413..b84589e0b6 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -50,7 +50,6 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "trace.h"
-#include "qemu/cutils.h"
 
 #define KERNEL_LOAD_ADDR     0x00404000
 #define CMDLINE_ADDR         0x003ff000
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 2829dda391..5e610722ee 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index b56c75a73a..d02c5d76c6 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -22,7 +22,6 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "qapi/visitor.h"
-#include "qemu/cutils.h"
 
 //#define DEBUG_MSD
 
-- 
2.16.2
