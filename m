Received: from eggs.gnu.org ([2001:4830:134:3::10]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKU-0005zc-E1
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKR-0001O5-CJ
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:56 -0300
Message-Id: <20180415234307.28132-31-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 30/41] hw/arm: Use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Antony Pavlov <antonynpavlov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Chubb <peter.chubb@nicta.com.au>, Andrzej Zaborowski <balrogg@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 include/hw/arm/fsl-imx7.h      |  5 +++--
 include/hw/arm/stm32f205_soc.h |  5 +++--
 hw/arm/bcm2835_peripherals.c   |  3 ++-
 hw/arm/boot.c                  |  7 ++++---
 hw/arm/collie.c                |  5 +++--
 hw/arm/digic_boards.c          |  7 ++++---
 hw/arm/exynos4_boards.c        |  3 ++-
 hw/arm/gumstix.c               |  3 ++-
 hw/arm/imx25_pdk.c             |  1 +
 hw/arm/integratorcp.c          |  3 ++-
 hw/arm/mainstone.c             |  3 ++-
 hw/arm/msf2-soc.c              |  2 +-
 hw/arm/msf2-som.c              |  2 +-
 hw/arm/musicpal.c              |  9 +++++----
 hw/arm/omap_sx1.c              | 11 ++++++-----
 hw/arm/raspi.c                 |  5 +++--
 hw/arm/stellaris.c             |  5 +++--
 hw/arm/versatilepb.c           |  5 +++--
 hw/arm/vexpress.c              |  7 ++++---
 hw/arm/virt.c                  |  5 +++--
 hw/arm/xilinx_zynq.c           |  7 ++++---
 hw/misc/aspeed_sdmc.c          |  9 +++++----
 hw/misc/imx7_gpr.c             |  3 ++-
 hw/misc/omap_gpmc.c            |  5 +++--
 hw/pci-host/gpex.c             |  3 ++-
 hw/ssi/aspeed_smc.c            | 29 +++++++++++++++--------------
 26 files changed, 88 insertions(+), 64 deletions(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index d848262bfd..fa6bf1c455 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -19,6 +19,7 @@
 #ifndef FSL_IMX7_H
 #define FSL_IMX7_H
 
+#include "qemu/units.h"
 #include "hw/arm/arm.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/intc/imx_gpcv2.h"
@@ -86,7 +87,7 @@ typedef struct FslIMX7State {
 
 enum FslIMX7MemoryMap {
     FSL_IMX7_MMDC_ADDR            = 0x80000000,
-    FSL_IMX7_MMDC_SIZE            = 2 * 1024 * 1024 * 1024UL,
+    FSL_IMX7_MMDC_SIZE            = 2 * G_BYTE,
 
     FSL_IMX7_GPIO1_ADDR           = 0x30200000,
     FSL_IMX7_GPIO2_ADDR           = 0x30210000,
@@ -176,7 +177,7 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_A7MPCORE_DAP_ADDR    = 0x30000000,
 
     FSL_IMX7_PCIE_REG_ADDR        = 0x33800000,
-    FSL_IMX7_PCIE_REG_SIZE        = 16 * 1024,
+    FSL_IMX7_PCIE_REG_SIZE        = 16 * K_BYTE,
 
     FSL_IMX7_GPR_ADDR             = 0x30340000,
 };
diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 922a733f88..aeac3338d0 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -25,6 +25,7 @@
 #ifndef HW_ARM_STM32F205_SOC_H
 #define HW_ARM_STM32F205_SOC_H
 
+#include "qemu/units.h"
 #include "hw/misc/stm32f2xx_syscfg.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "hw/char/stm32f2xx_usart.h"
@@ -43,9 +44,9 @@
 #define STM_NUM_SPIS 3
 
 #define FLASH_BASE_ADDRESS 0x08000000
-#define FLASH_SIZE (1024 * 1024)
+#define FLASH_SIZE (1 * M_BYTE)
 #define SRAM_BASE_ADDRESS 0x20000000
-#define SRAM_SIZE (128 * 1024)
+#define SRAM_SIZE (128 * K_BYTE)
 
 typedef struct STM32F205State {
     /*< private >*/
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 13b63970d7..2db04bff6e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
@@ -150,7 +151,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     for (n = 0; n < 4; n++) {
         memory_region_init_alias(&s->ram_alias[n], OBJECT(s),
                                  "bcm2835-gpu-ram-alias[*]", ram, 0, ram_size);
-        memory_region_add_subregion_overlap(&s->gpu_bus_mr, (hwaddr)n << 30,
+        memory_region_add_subregion_overlap(&s->gpu_bus_mr, n * G_BYTE,
                                             &s->ram_alias[n], 0);
     }
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 26184bcd7c..ad169708d8 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include <libfdt.h>
@@ -1039,7 +1040,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
      * the initrd at 128MB.
      */
     info->initrd_start = info->loader_start +
-        MIN(info->ram_size / 2, 128 * 1024 * 1024);
+        MIN(info->ram_size / 2, 128 * M_BYTE);
 
     /* Assume that raw images are linux kernels, and ELF images are not.  */
     kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
@@ -1126,13 +1127,13 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
                  *
                  * Let's play safe and prealign it to 2MB to give us some space.
                  */
-                align = 2 * 1024 * 1024;
+                align = 2 * M_BYTE;
             } else {
                 /*
                  * Some 32bit kernels will trash anything in the 4K page the
                  * initrd ends in, so make sure the DTB isn't caught up in that.
                  */
-                align = 4096;
+                align = 4 * K_BYTE;
             }
 
             /* Place the DTB after the initrd in memory with alignment. */
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index f8c566e2e5..767a45f138 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -9,6 +9,7 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
@@ -39,12 +40,12 @@ static void collie_init(MachineState *machine)
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, NULL, "collie.fl1", 0x02000000,
                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                    (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
+                    64 * K_BYTE, 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
 
     dinfo = drive_get(IF_PFLASH, 0, 1);
     pflash_cfi01_register(SA_CS1, NULL, "collie.fl2", 0x02000000,
                     dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                    (64 * 1024), 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
+                    64 * K_BYTE, 512, 4, 0x00, 0x00, 0x00, 0x00, 0);
 
     sysbus_create_simple("scoop", 0x40800000, NULL);
 
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 9f11dcd11f..0a865f6e45 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -126,8 +127,8 @@ static void digic_load_rom(DigicBoardState *s, hwaddr addr,
 static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
                                       const char *def_filename)
 {
-#define FLASH_K8P3215UQB_SIZE (4 * 1024 * 1024)
-#define FLASH_K8P3215UQB_SECTOR_SIZE (64 * 1024)
+#define FLASH_K8P3215UQB_SIZE (4 * M_BYTE)
+#define FLASH_K8P3215UQB_SECTOR_SIZE (64 * K_BYTE)
 
     pflash_cfi02_register(addr, NULL, "pflash", FLASH_K8P3215UQB_SIZE,
                           NULL, FLASH_K8P3215UQB_SECTOR_SIZE,
@@ -141,7 +142,7 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
 }
 
 static DigicBoard digic4_board_canon_a1100 = {
-    .ram_size = 64 * 1024 * 1024,
+    .ram_size = 64 * M_BYTE,
     .add_rom1 = digic4_add_k8p3215uqb_rom,
     .rom1_def_filename = "canon-a1100-rom1.bin",
 };
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 750162cc95..11f5e44eb2 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu-common.h"
@@ -143,7 +144,7 @@ exynos4_boards_init_common(MachineState *machine,
             " kernel_filename: %s\n"
             " kernel_cmdline: %s\n"
             " initrd_filename: %s\n",
-            exynos4_board_ram_size[board_type] / 1048576,
+            exynos4_board_ram_size[board_type] / M_BYTE,
             exynos4_board_ram_size[board_type],
             machine->kernel_filename,
             machine->kernel_cmdline,
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index ea2a3c532d..88c5ac2f62 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -35,6 +35,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
@@ -47,7 +48,7 @@
 #include "sysemu/qtest.h"
 #include "cpu.h"
 
-static const int sector_len = 128 * 1024;
+static const int sector_len = 128 * K_BYTE;
 
 static void connex_init(MachineState *machine)
 {
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 9f3ee14739..29f907cedf 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 58b40efc19..466ba9dcb0 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -616,7 +617,7 @@ static void integratorcp_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias);
 
     dev = qdev_create(NULL, TYPE_INTEGRATOR_CM);
-    qdev_prop_set_uint32(dev, "memsz", ram_size >> 20);
+    qdev_prop_set_uint32(dev, "memsz", ram_size / M_BYTE);
     qdev_init_nofail(dev);
     sysbus_mmio_map((SysBusDevice *)dev, 0, 0x10000000);
 
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 4215c025fc..a89627c036 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -12,6 +12,7 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
@@ -115,7 +116,7 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
                                   MachineState *machine,
                                   enum mainstone_model_e model, int arm_id)
 {
-    uint32_t sector_len = 256 * 1024;
+    uint32_t sector_len = 256 * K_BYTE;
     hwaddr mainstone_flash_base[] = { MST_FLASH_0, MST_FLASH_1 };
     PXA2xxState *mpu;
     DeviceState *mst_irq;
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index f68df56b97..993cee37c5 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -23,13 +23,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
 #include "hw/char/serial.h"
 #include "hw/boards.h"
-#include "qemu/cutils.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 0795a3a3a1..829c5da65a 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -23,12 +23,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
-#include "qemu/cutils.h"
 #include "hw/arm/msf2-soc.h"
 #include "cpu.h"
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 38d7322a19..4bc47d39eb 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -62,8 +63,8 @@
 #define MP_SRAM_BASE            0xC0000000
 #define MP_SRAM_SIZE            0x00020000
 
-#define MP_RAM_DEFAULT_SIZE     32*1024*1024
-#define MP_FLASH_SIZE_MAX       32*1024*1024
+#define MP_RAM_DEFAULT_SIZE     (32 * M_BYTE)
+#define MP_FLASH_SIZE_MAX       (32 * M_BYTE)
 
 #define MP_TIMER1_IRQ           4
 #define MP_TIMER2_IRQ           5
@@ -1625,8 +1626,8 @@ static void musicpal_init(MachineState *machine)
         BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
 
         flash_size = blk_getlength(blk);
-        if (flash_size != 8*1024*1024 && flash_size != 16*1024*1024 &&
-            flash_size != 32*1024*1024) {
+        if (flash_size != 8 * M_BYTE && flash_size != 16 * M_BYTE &&
+            flash_size != 32 * M_BYTE) {
             error_report("Invalid flash image size");
             exit(1);
         }
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index eccc19c77b..5acb0055d3 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -26,6 +26,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "ui/console.h"
@@ -87,11 +88,11 @@ static const MemoryRegionOps static_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-#define sdram_size	0x02000000
-#define sector_size	(128 * 1024)
-#define flash0_size	(16 * 1024 * 1024)
-#define flash1_size	( 8 * 1024 * 1024)
-#define flash2_size	(32 * 1024 * 1024)
+#define sdram_size      (32 * M_BYTE)
+#define sector_size     (128 * K_BYTE)
+#define flash0_size     (16 * M_BYTE)
+#define flash1_size     (8 * M_BYTE)
+#define flash2_size     (32 * M_BYTE)
 #define total_ram_v1	(sdram_size + flash0_size + flash1_size + OMAP15XX_SRAM_SIZE)
 #define total_ram_v2	(sdram_size + flash2_size + OMAP15XX_SRAM_SIZE)
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 955a7c4e80..e406e47793 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -230,7 +231,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * G_BYTE;
     mc->ignore_memory_transaction_failures = true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
@@ -253,7 +254,7 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * G_BYTE;
 }
 DEFINE_MACHINE("raspi3", raspi3_machine_init)
 #endif
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index de7c0fc4a6..9971556f0e 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/ssi/ssi.h"
@@ -1284,8 +1285,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *system_memory = get_system_memory();
 
-    flash_size = (((board->dc0 & 0xffff) + 1) << 1) * 1024;
-    sram_size = ((board->dc0 >> 18) + 1) * 1024;
+    flash_size = (((board->dc0 & 0xffff) + 1) << 1) * K_BYTE;
+    sram_size = ((board->dc0 >> 18) + 1) * K_BYTE;
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
     memory_region_init_ram(flash, NULL, "stellaris.flash", flash_size,
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 418792cd02..312ea97719 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -26,8 +27,8 @@
 #include "hw/char/pl011.h"
 
 #define VERSATILE_FLASH_ADDR 0x34000000
-#define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
-#define VERSATILE_FLASH_SECT_SIZE (256 * 1024)
+#define VERSATILE_FLASH_SIZE (64 * M_BYTE)
+#define VERSATILE_FLASH_SECT_SIZE (256 * K_BYTE)
 
 /* Primary interrupt controller.  */
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 9fad79177a..d0899278bd 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -45,8 +46,8 @@
 #include "hw/cpu/a15mpcore.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
-#define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
-#define VEXPRESS_FLASH_SECT_SIZE (256 * 1024)
+#define VEXPRESS_FLASH_SIZE (64 * M_BYTE)
+#define VEXPRESS_FLASH_SECT_SIZE (256 * K_BYTE)
 
 /* Number of virtio transports to create (0..8; limited by
  * number of available IRQ lines).
@@ -355,7 +356,7 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
          * warning if we are on a host where ram_addr_t is 32 bits.
          */
         uint64_t rsz = ram_size;
-        if (rsz > (30ULL * 1024 * 1024 * 1024)) {
+        if (rsz > 30 * G_BYTE) {
             error_report("vexpress-a15: cannot model more than 30GB RAM");
             exit(1);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 94dcb125d3..23679ff1ae 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
@@ -110,7 +111,7 @@ static ARMPlatformBusSystemParams platform_bus_params;
  * terabyte of physical address space.)
  */
 #define RAMLIMIT_GB 255
-#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
+#define RAMLIMIT_BYTES (RAMLIMIT_GB * G_BYTE)
 
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
@@ -784,7 +785,7 @@ static void create_one_flash(const char *name, hwaddr flashbase,
     DriveInfo *dinfo = drive_get_next(IF_PFLASH);
     DeviceState *dev = qdev_create(NULL, "cfi.pflash01");
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    const uint64_t sectorlength = 256 * 1024;
+    const uint64_t sectorlength = 256 * K_BYTE;
 
     if (dinfo) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0f76333770..0810038689 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -40,8 +41,8 @@
 #define NUM_QSPI_FLASHES 2
 #define NUM_QSPI_BUSSES 2
 
-#define FLASH_SIZE (64 * 1024 * 1024)
-#define FLASH_SECTOR_SIZE (128 * 1024)
+#define FLASH_SIZE (64 * M_BYTE)
+#define FLASH_SECTOR_SIZE (128 * K_BYTE)
 
 #define IRQ_OFFSET 32 /* pic interrupts start from index 32 */
 
@@ -199,7 +200,7 @@ static void zynq_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ext_ram);
 
     /* 256K of on-chip memory */
-    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 << 10,
+    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * K_BYTE,
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
 
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0df008e52a..0b89a6c5f1 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/misc/aspeed_sdmc.h"
@@ -149,7 +150,7 @@ static const MemoryRegionOps aspeed_sdmc_ops = {
 
 static int ast2400_rambits(AspeedSDMCState *s)
 {
-    switch (s->ram_size >> 20) {
+    switch (s->ram_size / M_BYTE) {
     case 64:
         return ASPEED_SDMC_DRAM_64MB;
     case 128:
@@ -165,13 +166,13 @@ static int ast2400_rambits(AspeedSDMCState *s)
     /* use a common default */
     warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 256M",
                 s->ram_size);
-    s->ram_size = 256 << 20;
+    s->ram_size = 256 * M_BYTE;
     return ASPEED_SDMC_DRAM_256MB;
 }
 
 static int ast2500_rambits(AspeedSDMCState *s)
 {
-    switch (s->ram_size >> 20) {
+    switch (s->ram_size / M_BYTE) {
     case 128:
         return ASPEED_SDMC_AST2500_128MB;
     case 256:
@@ -187,7 +188,7 @@ static int ast2500_rambits(AspeedSDMCState *s)
     /* use a common default */
     warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
                 s->ram_size);
-    s->ram_size = 512 << 20;
+    s->ram_size = 512 * M_BYTE;
     return ASPEED_SDMC_AST2500_512MB;
 }
 
diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
index c2a9df29c6..b784cf05f2 100644
--- a/hw/misc/imx7_gpr.c
+++ b/hw/misc/imx7_gpr.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/misc/imx7_gpr.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
@@ -98,7 +99,7 @@ static void imx7_gpr_init(Object *obj)
     IMX7GPRState *s = IMX7_GPR(obj);
 
     memory_region_init_io(&s->mmio, obj, &imx7_gpr_ops, s,
-                          TYPE_IMX7_GPR, 64 * 1024);
+                          TYPE_IMX7_GPR, 64 * K_BYTE);
     sysbus_init_mmio(sd, &s->mmio);
 }
 
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 84f9e4c612..94960774f4 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -19,6 +19,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/block/flash.h"
 #include "hw/arm/omap.h"
@@ -850,11 +851,11 @@ struct omap_gpmc_s *omap_gpmc_init(struct omap_mpu_state_s *mpu,
                               &omap_nand_ops,
                               &s->cs_file[cs],
                               "omap-nand",
-                              256 * 1024 * 1024);
+                              256 * M_BYTE);
     }
 
     memory_region_init_io(&s->prefetch.iomem, NULL, &omap_prefetch_ops, s,
-                          "omap-gpmc-prefetch", 256 * 1024 * 1024);
+                          "omap-gpmc-prefetch", 256 * M_BYTE);
     return s;
 }
 
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 2583b151a4..21993d5e83 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -29,6 +29,7 @@
  * http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/pci-host/gpex.h"
 
@@ -79,7 +80,7 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
 
     pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
     memory_region_init(&s->io_mmio, OBJECT(s), "gpex_mmio", UINT64_MAX);
-    memory_region_init(&s->io_ioport, OBJECT(s), "gpex_ioport", 64 * 1024);
+    memory_region_init(&s->io_ioport, OBJECT(s), "gpex_ioport", 64 * K_BYTE);
 
     sysbus_init_mmio(sbd, &pex->mmio);
     sysbus_init_mmio(sbd, &s->io_mmio);
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 5059396bc6..df21fdf8d3 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
@@ -149,35 +150,35 @@
  * Segment Address Registers.
  */
 static const AspeedSegments aspeed_segments_legacy[] = {
-    { 0x10000000, 32 * 1024 * 1024 },
+    { 0x10000000, 32 * M_BYTE },
 };
 
 static const AspeedSegments aspeed_segments_fmc[] = {
-    { 0x20000000, 64 * 1024 * 1024 }, /* start address is readonly */
-    { 0x24000000, 32 * 1024 * 1024 },
-    { 0x26000000, 32 * 1024 * 1024 },
-    { 0x28000000, 32 * 1024 * 1024 },
-    { 0x2A000000, 32 * 1024 * 1024 }
+    { 0x20000000,  64 * M_BYTE }, /* start address is readonly */
+    { 0x24000000,  32 * M_BYTE },
+    { 0x26000000,  32 * M_BYTE },
+    { 0x28000000,  32 * M_BYTE },
+    { 0x2A000000,  32 * M_BYTE }
 };
 
 static const AspeedSegments aspeed_segments_spi[] = {
-    { 0x30000000, 64 * 1024 * 1024 },
+    { 0x30000000,  64 * M_BYTE },
 };
 
 static const AspeedSegments aspeed_segments_ast2500_fmc[] = {
-    { 0x20000000, 128 * 1024 * 1024 }, /* start address is readonly */
-    { 0x28000000,  32 * 1024 * 1024 },
-    { 0x2A000000,  32 * 1024 * 1024 },
+    { 0x20000000, 128 * M_BYTE }, /* start address is readonly */
+    { 0x28000000,  32 * M_BYTE },
+    { 0x2A000000,  32 * M_BYTE },
 };
 
 static const AspeedSegments aspeed_segments_ast2500_spi1[] = {
-    { 0x30000000, 32 * 1024 * 1024 }, /* start address is readonly */
-    { 0x32000000, 96 * 1024 * 1024 }, /* end address is readonly */
+    { 0x30000000,  32 * M_BYTE }, /* start address is readonly */
+    { 0x32000000,  96 * M_BYTE }, /* end address is readonly */
 };
 
 static const AspeedSegments aspeed_segments_ast2500_spi2[] = {
-    { 0x38000000, 32 * 1024 * 1024 }, /* start address is readonly */
-    { 0x3A000000, 96 * 1024 * 1024 }, /* end address is readonly */
+    { 0x38000000,  32 * M_BYTE }, /* start address is readonly */
+    { 0x3A000000,  96 * M_BYTE }, /* end address is readonly */
 };
 
 static const AspeedSMCController controllers[] = {
-- 
2.17.0
