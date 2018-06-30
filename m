Received: from eggs.gnu.org ([2001:4830:134:3::10]:37787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95y-00041j-I1
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95v-0001kb-ST
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:54 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95v-0001j5-H2
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:51 -0400
Received: by mail-wm0-x244.google.com with SMTP id z137-v6so3958248wmc.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:00 +0200
Message-Id: <20180630061040.6018-8-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/47] hw: Use IEC binary prefix definitions
 from "qemu/units.h"
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Code change produced with:

  $ git ls-files | egrep '\.[ch]$' | \
    xargs sed -i -e 's/\(\W[KMGTPE]\)_BYTE/\1iB/g'

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc parts)
Message-Id: <20180625124238.25339-6-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/msf2-soc.c      |  4 ++--
 hw/arm/msf2-som.c      |  6 +++---
 hw/core/loader-fit.c   |  3 ++-
 hw/core/machine.c      |  2 +-
 hw/display/sm501.c     | 14 +++++++-------
 hw/hppa/machine.c      |  2 +-
 hw/mips/boston.c       | 28 ++++++++++++++--------------
 hw/ppc/pnv.c           |  4 ++--
 hw/ppc/ppc440_uc.c     | 26 +++++++++++++-------------
 hw/ppc/prep.c          |  2 +-
 hw/ppc/sam460ex.c      |  2 +-
 hw/ppc/spapr.c         | 10 +++++-----
 hw/ppc/spapr_rtas.c    |  2 +-
 hw/sd/sd.c             |  4 ++--
 hw/sd/sdhci.c          |  2 +-
 include/qemu/cutils.h  |  8 +-------
 tests/test-cutils.c    | 19 ++++++++++---------
 tests/test-keyval.c    |  6 +++---
 tests/test-qemu-opts.c |  7 +++----
 19 files changed, 73 insertions(+), 78 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 75c44ad..530e461 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -40,14 +40,14 @@
 
 #define SRAM_BASE_ADDRESS     0x20000000
 
-#define MSF2_ENVM_MAX_SIZE    (512 * K_BYTE)
+#define MSF2_ENVM_MAX_SIZE    (512 * KiB)
 
 /*
  * eSRAM max size is 80k without SECDED(Single error correction and
  * dual error detection) feature and 64k with SECDED.
  * We do not support SECDED now.
  */
-#define MSF2_ESRAM_MAX_SIZE       (80 * K_BYTE)
+#define MSF2_ESRAM_MAX_SIZE       (80 * KiB)
 
 static const uint32_t spi_addr[MSF2_NUM_SPIS] = { 0x40001000 , 0x40011000 };
 static const uint32_t uart_addr[MSF2_NUM_UARTS] = { 0x40000000 , 0x40010000 };
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 0795a3a..ed533bb 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -33,10 +33,10 @@
 #include "cpu.h"
 
 #define DDR_BASE_ADDRESS      0xA0000000
-#define DDR_SIZE              (64 * M_BYTE)
+#define DDR_SIZE              (64 * MiB)
 
-#define M2S010_ENVM_SIZE      (256 * K_BYTE)
-#define M2S010_ESRAM_SIZE     (64 * K_BYTE)
+#define M2S010_ENVM_SIZE      (256 * KiB)
+#define M2S010_ESRAM_SIZE     (64 * KiB)
 
 static void emcraft_sf2_s2s010_init(MachineState *machine)
 {
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 6387854..447f608 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "exec/memory.h"
 #include "hw/loader.h"
 #include "hw/loader-fit.h"
@@ -194,7 +195,7 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
 
     err = fit_image_addr(itb, img_off, "load", &load_addr);
     if (err == -ENOENT) {
-        load_addr = ROUND_UP(kernel_end, 64 * K_BYTE) + (10 * M_BYTE);
+        load_addr = ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
     } else if (err) {
         ret = err;
         goto out;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 617e5f8..ccf3a4b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -522,7 +522,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     /* Default 128 MB as guest ram size */
-    mc->default_ram_size = 128 * M_BYTE;
+    mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
 
     /* numa node memory size aligned on 8MB by default.
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 8206ae8..3bd8716 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -452,12 +452,12 @@
 
 /* SM501 local memory size taken from "linux/drivers/mfd/sm501.c" */
 static const uint32_t sm501_mem_local_size[] = {
-    [0] = 4 * M_BYTE,
-    [1] = 8 * M_BYTE,
-    [2] = 16 * M_BYTE,
-    [3] = 32 * M_BYTE,
-    [4] = 64 * M_BYTE,
-    [5] = 2 * M_BYTE,
+    [0] = 4 * MiB,
+    [1] = 8 * MiB,
+    [2] = 16 * MiB,
+    [3] = 32 * MiB,
+    [4] = 64 * MiB,
+    [5] = 2 * MiB,
 };
 #define get_local_mem_size(s) sm501_mem_local_size[(s)->local_mem_size_index]
 
@@ -1829,7 +1829,7 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
 }
 
 static Property sm501_pci_properties[] = {
-    DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * M_BYTE),
+    DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index aba269b..2ba2696 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -275,7 +275,7 @@ static void machine_hppa_machine_init(MachineClass *mc)
     mc->max_cpus = HPPA_MAX_CPUS;
     mc->default_cpus = 1;
     mc->is_default = 1;
-    mc->default_ram_size = 512 * M_BYTE;
+    mc->default_ram_size = 512 * MiB;
     mc->default_boot_order = "cd";
 }
 
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 14e6f95..939cef5 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -200,7 +200,7 @@ static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
         val |= PLAT_BUILD_CFG_PCIE2_EN;
         return val;
     case PLAT_DDR_CFG:
-        val = s->mach->ram_size / G_BYTE;
+        val = s->mach->ram_size / GiB;
         assert(!(val & ~PLAT_DDR_CFG_SIZE));
         val |= PLAT_DDR_CFG_MHZ;
         return val;
@@ -355,7 +355,7 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
         return NULL;
     }
 
-    ram_low_sz = MIN(256 * M_BYTE, machine->ram_size);
+    ram_low_sz = MIN(256 * MiB, machine->ram_size);
     ram_high_sz = machine->ram_size - ram_low_sz;
     qemu_fdt_setprop_sized_cells(fdt, "/memory@0", "reg",
                                  1, 0x00000000, 1, ram_low_sz,
@@ -436,8 +436,8 @@ static void boston_mach_init(MachineState *machine)
     int fw_size, fit_err;
     bool is_64b;
 
-    if ((machine->ram_size % G_BYTE) ||
-        (machine->ram_size > (2 * G_BYTE))) {
+    if ((machine->ram_size % GiB) ||
+        (machine->ram_size > (2 * GiB))) {
         error_report("Memory size must be 1GB or 2GB");
         exit(1);
     }
@@ -471,7 +471,7 @@ static void boston_mach_init(MachineState *machine)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
 
     flash =  g_new(MemoryRegion, 1);
-    memory_region_init_rom(flash, NULL, "boston.flash", 128 * M_BYTE, &err);
+    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
 
     ddr = g_new(MemoryRegion, 1);
@@ -481,22 +481,22 @@ static void boston_mach_init(MachineState *machine)
 
     ddr_low_alias = g_new(MemoryRegion, 1);
     memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
-                             ddr, 0, MIN(machine->ram_size, (256 * M_BYTE)));
+                             ddr, 0, MIN(machine->ram_size, (256 * MiB)));
     memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
 
     xilinx_pcie_init(sys_mem, 0,
-                     0x10000000, 32 * M_BYTE,
-                     0x40000000, 1 * G_BYTE,
+                     0x10000000, 32 * MiB,
+                     0x40000000, 1 * GiB,
                      get_cps_irq(s->cps, 2), false);
 
     xilinx_pcie_init(sys_mem, 1,
-                     0x12000000, 32 * M_BYTE,
-                     0x20000000, 512 * M_BYTE,
+                     0x12000000, 32 * MiB,
+                     0x20000000, 512 * MiB,
                      get_cps_irq(s->cps, 1), false);
 
     pcie2 = xilinx_pcie_init(sys_mem, 2,
-                             0x14000000, 32 * M_BYTE,
-                             0x16000000, 1 * M_BYTE,
+                             0x14000000, 32 * MiB,
+                             0x16000000, 1 * MiB,
                              get_cps_irq(s->cps, 0), true);
 
     platreg = g_new(MemoryRegion, 1);
@@ -526,7 +526,7 @@ static void boston_mach_init(MachineState *machine)
 
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
-                                      0x1fc00000, 4 * M_BYTE);
+                                      0x1fc00000, 4 * MiB);
         if (fw_size == -1) {
             error_printf("unable to load firmware image '%s'\n",
                           machine->firmware);
@@ -552,7 +552,7 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->desc = "MIPS Boston";
     mc->init = boston_mach_init;
     mc->block_default_type = IF_IDE;
-    mc->default_ram_size = 1 * G_BYTE;
+    mc->default_ram_size = 1 * GiB;
     mc->max_cpus = 16;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7401ffe..5fdac62 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -556,7 +556,7 @@ static void pnv_init(MachineState *machine)
     char *chip_typename;
 
     /* allocate RAM */
-    if (machine->ram_size < (1 * G_BYTE)) {
+    if (machine->ram_size < (1 * GiB)) {
         warn_report("skiboot may not work with < 1GB of RAM");
     }
 
@@ -1174,7 +1174,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
                                       * storage */
     mc->no_parallel = 1;
     mc->default_boot_order = NULL;
-    mc->default_ram_size = 1 * G_BYTE;
+    mc->default_ram_size = 1 * GiB;
     xic->icp_get = pnv_icp_get;
     xic->ics_get = pnv_ics_get;
     xic->ics_resend = pnv_ics_resend;
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 123f4ac..b5b31b4 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -215,13 +215,13 @@ void ppc4xx_l2sram_init(CPUPPCState *env)
     l2sram = g_malloc0(sizeof(*l2sram));
     /* XXX: Size is 4*64kB for 460ex, cf. U-Boot, ppc4xx-isram.h */
     memory_region_init_ram(&l2sram->bank[0], NULL, "ppc4xx.l2sram_bank0",
-                           64 * K_BYTE, &error_abort);
+                           64 * KiB, &error_abort);
     memory_region_init_ram(&l2sram->bank[1], NULL, "ppc4xx.l2sram_bank1",
-                           64 * K_BYTE, &error_abort);
+                           64 * KiB, &error_abort);
     memory_region_init_ram(&l2sram->bank[2], NULL, "ppc4xx.l2sram_bank2",
-                           64 * K_BYTE, &error_abort);
+                           64 * KiB, &error_abort);
     memory_region_init_ram(&l2sram->bank[3], NULL, "ppc4xx.l2sram_bank3",
-                           64 * K_BYTE, &error_abort);
+                           64 * KiB, &error_abort);
     qemu_register_reset(&l2sram_reset, l2sram);
     ppc_dcr_register(env, DCR_L2CACHE_CFG,
                      l2sram, &dcr_read_l2sram, &dcr_write_l2sram);
@@ -513,28 +513,28 @@ static uint32_t sdram_bcr(hwaddr ram_base, hwaddr ram_size)
     uint32_t bcr;
 
     switch (ram_size) {
-    case (8 * M_BYTE):
+    case (8 * MiB):
         bcr = 0xffc0;
         break;
-    case (16 * M_BYTE):
+    case (16 * MiB):
         bcr = 0xff80;
         break;
-    case (32 * M_BYTE):
+    case (32 * MiB):
         bcr = 0xff00;
         break;
-    case (64 * M_BYTE):
+    case (64 * MiB):
         bcr = 0xfe00;
         break;
-    case (128 * M_BYTE):
+    case (128 * MiB):
         bcr = 0xfc00;
         break;
-    case (256 * M_BYTE):
+    case (256 * MiB):
         bcr = 0xf800;
         break;
-    case (512 * M_BYTE):
+    case (512 * MiB):
         bcr = 0xf000;
         break;
-    case (1 * G_BYTE):
+    case (1 * GiB):
         bcr = 0xe000;
         break;
     default:
@@ -561,7 +561,7 @@ static target_ulong sdram_size(uint32_t bcr)
     if (sh == 0) {
         size = -1;
     } else {
-        size = 8 * M_BYTE * sh;
+        size = 8 * MiB * sh;
     }
 
     return size;
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 5ed0bcd..25ae533 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -884,7 +884,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->desc = "IBM RS/6000 7020 (40p)",
     mc->init = ibm_40p_init;
     mc->max_cpus = 1;
-    mc->default_ram_size = 128 * M_BYTE;
+    mc->default_ram_size = 128 * MiB;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index bdc53d2..2a98c10 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -597,7 +597,7 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->desc = "aCube Sam460ex";
     mc->init = sam460ex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
-    mc->default_ram_size = 512 * M_BYTE;
+    mc->default_ram_size = 512 * MiB;
 }
 
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b32b971..7dbdb4e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2324,7 +2324,7 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
         error_setg(errp, "Memory size 0x" RAM_ADDR_FMT
                    " is not aligned to %llu MiB",
                    machine->ram_size,
-                   SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+                   SPAPR_MEMORY_BLOCK_SIZE / MiB);
         return;
     }
 
@@ -2332,7 +2332,7 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
         error_setg(errp, "Maximum memory size 0x" RAM_ADDR_FMT
                    " is not aligned to %llu MiB",
                    machine->ram_size,
-                   SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+                   SPAPR_MEMORY_BLOCK_SIZE / MiB);
         return;
     }
 
@@ -2342,7 +2342,7 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
                        "Node %d memory size 0x%" PRIx64
                        " is not aligned to %llu MiB",
                        i, numa_info[i].node_mem,
-                       SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+                       SPAPR_MEMORY_BLOCK_SIZE / MiB);
             return;
         }
     }
@@ -3209,7 +3209,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     if (size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Hotplugged memory size must be a multiple of "
-                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
+                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
         return;
     }
 
@@ -3961,7 +3961,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1024;
     mc->no_parallel = 1;
     mc->default_boot_order = "";
-    mc->default_ram_size = 512 * M_BYTE;
+    mc->default_ram_size = 512 * MiB;
     mc->kvm_type = spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
     mc->pci_allow_0_address = true;
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 7f9738d..f32740b 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -241,7 +241,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           "DesProcs=%d,"
                                           "MaxPlatProcs=%d",
                                           max_cpus,
-                                          current_machine->ram_size / M_BYTE,
+                                          current_machine->ram_size / MiB,
                                           smp_cpus,
                                           max_cpus);
         ret = sysparm_st(buffer, length, param_val, strlen(param_val) + 1);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 540bccb..9a16b76 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -305,7 +305,7 @@ static void sd_ocr_powerup(void *opaque)
     /* card power-up OK */
     sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
 
-    if (sd->size > 1 * G_BYTE) {
+    if (sd->size > 1 * GiB) {
         sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
     }
 }
@@ -377,7 +377,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
     uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
 
-    if (size <= 1 * G_BYTE) { /* Standard Capacity SD */
+    if (size <= 1 * GiB) { /* Standard Capacity SD */
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 3017e5a..a11e802 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -414,7 +414,7 @@ static void sdhci_end_transfer(SDHCIState *s)
 /*
  * Programmed i/o data transfer
  */
-#define BLOCK_SIZE_MASK (4 * K_BYTE - 1)
+#define BLOCK_SIZE_MASK (4 * KiB - 1)
 
 /* Fill host controller's read buffer with BLKSIZE bytes of data from card */
 static void sdhci_read_block_from_card(SDHCIState *s)
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index a663340..056e662 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -2,6 +2,7 @@
 #define QEMU_CUTILS_H
 
 #include "qemu/fprintf-fn.h"
+#include "qemu/units.h"
 
 /**
  * pstrcpy:
@@ -147,13 +148,6 @@ int qemu_strtosz(const char *nptr, char **end, uint64_t *result);
 int qemu_strtosz_MiB(const char *nptr, char **end, uint64_t *result);
 int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result);
 
-#define K_BYTE     (1ULL << 10)
-#define M_BYTE     (1ULL << 20)
-#define G_BYTE     (1ULL << 30)
-#define T_BYTE     (1ULL << 40)
-#define P_BYTE     (1ULL << 50)
-#define E_BYTE     (1ULL << 60)
-
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 64a489c..a6e5fe4 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu/cutils.h"
+#include "qemu/units.h"
 
 static void test_parse_uint_null(void)
 {
@@ -2022,7 +2023,7 @@ static void test_qemu_strtosz_units(void)
     /* default is M */
     err = qemu_strtosz_MiB(none, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, M_BYTE);
+    g_assert_cmpint(res, ==, MiB);
     g_assert(endptr == none + 1);
 
     err = qemu_strtosz(b, &endptr, &res);
@@ -2032,32 +2033,32 @@ static void test_qemu_strtosz_units(void)
 
     err = qemu_strtosz(k, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, K_BYTE);
+    g_assert_cmpint(res, ==, KiB);
     g_assert(endptr == k + 2);
 
     err = qemu_strtosz(m, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, M_BYTE);
+    g_assert_cmpint(res, ==, MiB);
     g_assert(endptr == m + 2);
 
     err = qemu_strtosz(g, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, G_BYTE);
+    g_assert_cmpint(res, ==, GiB);
     g_assert(endptr == g + 2);
 
     err = qemu_strtosz(t, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, T_BYTE);
+    g_assert_cmpint(res, ==, TiB);
     g_assert(endptr == t + 2);
 
     err = qemu_strtosz(p, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, P_BYTE);
+    g_assert_cmpint(res, ==, PiB);
     g_assert(endptr == p + 2);
 
     err = qemu_strtosz(e, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, E_BYTE);
+    g_assert_cmpint(res, ==, EiB);
     g_assert(endptr == e + 2);
 }
 
@@ -2070,7 +2071,7 @@ static void test_qemu_strtosz_float(void)
 
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12.345 * M_BYTE);
+    g_assert_cmpint(res, ==, 12.345 * MiB);
     g_assert(endptr == str + 7);
 }
 
@@ -2106,7 +2107,7 @@ static void test_qemu_strtosz_trailing(void)
 
     str = "123xxx";
     err = qemu_strtosz_MiB(str, &endptr, &res);
-    g_assert_cmpint(res, ==, 123 * M_BYTE);
+    g_assert_cmpint(res, ==, 123 * MiB);
     g_assert(endptr == str + 3);
 
     err = qemu_strtosz(str, NULL, &res);
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 63cb146..92d8e9f 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -457,11 +457,11 @@ static void test_keyval_visit_size(void)
     visit_type_size(v, "sz2", &sz, &error_abort);
     g_assert_cmpuint(sz, ==, 1536);
     visit_type_size(v, "sz3", &sz, &error_abort);
-    g_assert_cmphex(sz, ==, 2 * M_BYTE);
+    g_assert_cmphex(sz, ==, 2 * MiB);
     visit_type_size(v, "sz4", &sz, &error_abort);
-    g_assert_cmphex(sz, ==, G_BYTE / 10);
+    g_assert_cmphex(sz, ==, GiB / 10);
     visit_type_size(v, "sz5", &sz, &error_abort);
-    g_assert_cmphex(sz, ==, 16777215 * T_BYTE);
+    g_assert_cmphex(sz, ==, 16777215 * TiB);
     visit_check_struct(v, &error_abort);
     visit_end_struct(v, NULL);
     visit_free(v);
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 7092e21..fd4d848 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -704,13 +704,12 @@ static void test_opts_parse_size(void)
     g_assert_cmpuint(opts_count(opts), ==, 3);
     g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), ==, 8);
     g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 1536);
-    g_assert_cmphex(qemu_opt_get_size(opts, "size3", 0), ==, 2 * M_BYTE);
+    g_assert_cmphex(qemu_opt_get_size(opts, "size3", 0), ==, 2 * MiB);
     opts = qemu_opts_parse(&opts_list_02, "size1=0.1G,size2=16777215T",
                            false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 2);
-    g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), ==, G_BYTE / 10);
-    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0),
-                     ==, 16777215 * T_BYTE);
+    g_assert_cmphex(qemu_opt_get_size(opts, "size1", 0), ==, GiB / 10);
+    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 16777215U * TiB);
 
     /* Beyond limit with suffix */
     opts = qemu_opts_parse(&opts_list_02, "size1=16777216T",
-- 
1.8.3.1
