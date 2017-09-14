Received: from eggs.gnu.org ([2001:4830:134:3::10]:46542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJb-000879-8o
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJZ-00080I-V3
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJZ-0007vb-NL
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJS-0005qK-1V
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:30 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:43 +0100
Message-Id: <1505411573-27848-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/18] xlnx-ep108: Rename to ZCU102
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

The EP108 is a early access development board. Now that silicon is in
production people have access to the ZCU102. Let's rename the internal
QEMU files and variables to use the ZCU102.

There is no functional change here as the EP108 is still a valid board
option.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs                   |  2 +-
 hw/arm/{xlnx-ep108.c => xlnx-zcu102.c} | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)
 rename hw/arm/{xlnx-ep108.c => xlnx-zcu102.c} (85%)

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index a2e56ec..5ee6f7d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -13,7 +13,7 @@ obj-y += omap1.o omap2.o strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp.o xlnx-ep108.o
+obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
diff --git a/hw/arm/xlnx-ep108.c b/hw/arm/xlnx-zcu102.c
similarity index 85%
rename from hw/arm/xlnx-ep108.c
rename to hw/arm/xlnx-zcu102.c
index c339cd4..e9702ed 100644
--- a/hw/arm/xlnx-ep108.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -1,5 +1,5 @@
 /*
- * Xilinx ZynqMP EP108 board
+ * Xilinx ZynqMP ZCU102 board
  *
  * Copyright (C) 2015 Xilinx Inc
  * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
@@ -25,16 +25,16 @@
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
 
-typedef struct XlnxEP108 {
+typedef struct XlnxZCU102 {
     XlnxZynqMPState soc;
     MemoryRegion ddr_ram;
-} XlnxEP108;
+} XlnxZCU102;
 
-static struct arm_boot_info xlnx_ep108_binfo;
+static struct arm_boot_info xlnx_zcu102_binfo;
 
-static void xlnx_ep108_init(MachineState *machine)
+static void xlnx_zcu102_init(MachineState *machine)
 {
-    XlnxEP108 *s = g_new0(XlnxEP108, 1);
+    XlnxZCU102 *s = g_new0(XlnxZCU102, 1);
     int i;
     uint64_t ram_size = machine->ram_size;
 
@@ -47,7 +47,7 @@ static void xlnx_ep108_init(MachineState *machine)
     }
 
     if (ram_size < 0x08000000) {
-        qemu_log("WARNING: RAM size 0x%" PRIx64 " is small for EP108",
+        qemu_log("WARNING: RAM size 0x%" PRIx64 " is small for ZCU102",
                  ram_size);
     }
 
@@ -108,18 +108,18 @@ static void xlnx_ep108_init(MachineState *machine)
 
     /* TODO create and connect IDE devices for ide_drive_get() */
 
-    xlnx_ep108_binfo.ram_size = ram_size;
-    xlnx_ep108_binfo.kernel_filename = machine->kernel_filename;
-    xlnx_ep108_binfo.kernel_cmdline = machine->kernel_cmdline;
-    xlnx_ep108_binfo.initrd_filename = machine->initrd_filename;
-    xlnx_ep108_binfo.loader_start = 0;
-    arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_ep108_binfo);
+    xlnx_zcu102_binfo.ram_size = ram_size;
+    xlnx_zcu102_binfo.kernel_filename = machine->kernel_filename;
+    xlnx_zcu102_binfo.kernel_cmdline = machine->kernel_cmdline;
+    xlnx_zcu102_binfo.initrd_filename = machine->initrd_filename;
+    xlnx_zcu102_binfo.loader_start = 0;
+    arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
 }
 
 static void xlnx_ep108_machine_init(MachineClass *mc)
 {
     mc->desc = "Xilinx ZynqMP EP108 board";
-    mc->init = xlnx_ep108_init;
+    mc->init = xlnx_zcu102_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
@@ -130,7 +130,7 @@ DEFINE_MACHINE("xlnx-ep108", xlnx_ep108_machine_init)
 static void xlnx_zcu102_machine_init(MachineClass *mc)
 {
     mc->desc = "Xilinx ZynqMP ZCU102 board";
-    mc->init = xlnx_ep108_init;
+    mc->init = xlnx_zcu102_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
-- 
2.7.4
