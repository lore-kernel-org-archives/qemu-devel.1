Received: from eggs.gnu.org ([2001:4830:134:3::10]:54573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTc-00061B-Cd
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTX-000465-DC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTW-00040L-JR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:19 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:49 +0100
Message-Id: <1499438577-7674-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/11] memory: Rename memory_region_init_ram()
 to memory_region_init_ram_nomigrate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Rename memory_region_init_ram() to memory_region_init_ram_nomigrate().
This leaves the way clear for us to provide a memory_region_init_ram()
which does handle migration.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h                    | 15 ++++++++-------
 backends/hostmem-ram.c                   |  2 +-
 hw/arm/aspeed_soc.c                      |  2 +-
 hw/arm/exynos4210.c                      |  4 ++--
 hw/arm/exynos4_boards.c                  |  4 ++--
 hw/arm/fsl-imx25.c                       |  2 +-
 hw/arm/fsl-imx31.c                       |  2 +-
 hw/arm/fsl-imx6.c                        |  2 +-
 hw/arm/highbank.c                        |  2 +-
 hw/arm/integratorcp.c                    |  2 +-
 hw/arm/mainstone.c                       |  2 +-
 hw/arm/musicpal.c                        |  2 +-
 hw/arm/omap1.c                           |  2 +-
 hw/arm/omap2.c                           |  2 +-
 hw/arm/omap_sx1.c                        |  4 ++--
 hw/arm/palm.c                            |  2 +-
 hw/arm/pxa2xx.c                          |  8 ++++----
 hw/arm/realview.c                        |  6 +++---
 hw/arm/spitz.c                           |  2 +-
 hw/arm/stellaris.c                       |  4 ++--
 hw/arm/stm32f205_soc.c                   |  4 ++--
 hw/arm/tosa.c                            |  2 +-
 hw/arm/vexpress.c                        |  6 +++---
 hw/arm/virt.c                            |  2 +-
 hw/arm/xilinx_zynq.c                     |  2 +-
 hw/arm/xlnx-zynqmp.c                     |  2 +-
 hw/block/onenand.c                       |  2 +-
 hw/cris/axis_dev88.c                     |  2 +-
 hw/display/cg3.c                         |  4 ++--
 hw/display/qxl.c                         |  6 +++---
 hw/display/sm501.c                       |  2 +-
 hw/display/tc6393xb.c                    |  2 +-
 hw/display/tcx.c                         |  4 ++--
 hw/display/vga.c                         |  2 +-
 hw/display/vmware_vga.c                  |  2 +-
 hw/i386/pc.c                             |  2 +-
 hw/i386/pc_sysfw.c                       |  4 ++--
 hw/i386/pci-assign-load-rom.c            |  2 +-
 hw/i386/xen/xen-hvm.c                    |  2 +-
 hw/input/milkymist-softusb.c             |  4 ++--
 hw/m68k/an5206.c                         |  2 +-
 hw/m68k/mcf5208.c                        |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c      |  4 ++--
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  4 ++--
 hw/mips/mips_fulong2e.c                  |  2 +-
 hw/mips/mips_jazz.c                      |  4 ++--
 hw/mips/mips_malta.c                     |  2 +-
 hw/mips/mips_mipssim.c                   |  2 +-
 hw/mips/mips_r4k.c                       |  2 +-
 hw/moxie/moxiesim.c                      |  4 ++--
 hw/net/dp8393x.c                         |  2 +-
 hw/net/milkymist-minimac2.c              |  2 +-
 hw/nios2/10m50_devboard.c                |  4 ++--
 hw/openrisc/openrisc_sim.c               |  2 +-
 hw/pci-host/prep.c                       |  2 +-
 hw/pci-host/xilinx-pcie.c                |  2 +-
 hw/ppc/mac_newworld.c                    |  2 +-
 hw/ppc/mac_oldworld.c                    |  2 +-
 hw/ppc/ppc405_boards.c                   |  6 +++---
 hw/ppc/ppc405_uc.c                       |  2 +-
 hw/s390x/sclp.c                          |  2 +-
 hw/sh4/r2d.c                             |  2 +-
 hw/sh4/shix.c                            |  6 +++---
 hw/sparc/leon3.c                         |  2 +-
 hw/sparc/sun4m.c                         |  6 +++---
 hw/sparc64/sun4u.c                       |  4 ++--
 hw/tricore/tricore_testboard.c           | 12 ++++++------
 hw/unicore32/puv3.c                      |  2 +-
 hw/xtensa/sim.c                          |  2 +-
 hw/xtensa/xtfpga.c                       |  6 +++---
 memory.c                                 | 10 +++++-----
 numa.c                                   |  4 ++--
 72 files changed, 121 insertions(+), 120 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 55cb5e7..2ef3e4f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -403,8 +403,9 @@ void memory_region_init_io(MemoryRegion *mr,
                            uint64_t size);
 
 /**
- * memory_region_init_ram:  Initialize RAM memory region.  Accesses into the
- *                          region will modify memory directly.
+ * memory_region_init_ram_nomigrate:  Initialize RAM memory region.  Accesses
+ *                                    into the region will modify memory
+ *                                    directly.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
@@ -416,11 +417,11 @@ void memory_region_init_io(MemoryRegion *mr,
  * Note that this function does not do anything to cause the data in the
  * RAM memory region to be migrated; that is the responsibility of the caller.
  */
-void memory_region_init_ram(MemoryRegion *mr,
-                            struct Object *owner,
-                            const char *name,
-                            uint64_t size,
-                            Error **errp);
+void memory_region_init_ram_nomigrate(MemoryRegion *mr,
+                                      struct Object *owner,
+                                      const char *name,
+                                      uint64_t size,
+                                      Error **errp);
 
 /**
  * memory_region_init_resizeable_ram:  Initialize memory region with resizeable
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 04a7ac3..38977be 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -28,7 +28,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     }
 
     path = object_get_canonical_path_component(OBJECT(backend));
-    memory_region_init_ram(&backend->mr, OBJECT(backend), path,
+    memory_region_init_ram_nomigrate(&backend->mr, OBJECT(backend), path,
                            backend->size, errp);
     g_free(path);
 }
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 4937e2b..e34a424 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -205,7 +205,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SRAM */
-    memory_region_init_ram(&s->sram, OBJECT(dev), "aspeed.sram",
+    memory_region_init_ram_nomigrate(&s->sram, OBJECT(dev), "aspeed.sram",
                            sc->info->sram_size, &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 0050626..a12615c 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -276,7 +276,7 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
                                 &s->chipid_mem);
 
     /* Internal ROM */
-    memory_region_init_ram(&s->irom_mem, NULL, "exynos4210.irom",
+    memory_region_init_ram_nomigrate(&s->irom_mem, NULL, "exynos4210.irom",
                            EXYNOS4210_IROM_SIZE, &error_fatal);
     vmstate_register_ram_global(&s->irom_mem);
     memory_region_set_readonly(&s->irom_mem, true);
@@ -292,7 +292,7 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
                                 &s->irom_alias_mem);
 
     /* Internal RAM */
-    memory_region_init_ram(&s->iram_mem, NULL, "exynos4210.iram",
+    memory_region_init_ram_nomigrate(&s->iram_mem, NULL, "exynos4210.iram",
                            EXYNOS4210_IRAM_SIZE, &error_fatal);
     vmstate_register_ram_global(&s->iram_mem);
     memory_region_add_subregion(system_mem, EXYNOS4210_IRAM_BASE_ADDR,
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 6240b26..c3b0d2e 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -110,7 +110,7 @@ static void exynos4_boards_init_ram(Exynos4BoardState *s,
     unsigned long mem_size = ram_size;
 
     if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
-        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210.dram1",
+        memory_region_init_ram_nomigrate(&s->dram1_mem, NULL, "exynos4210.dram1",
                                mem_size - EXYNOS4210_DRAM_MAX_SIZE,
                                &error_fatal);
         vmstate_register_ram_global(&s->dram1_mem);
@@ -119,7 +119,7 @@ static void exynos4_boards_init_ram(Exynos4BoardState *s,
         mem_size = EXYNOS4210_DRAM_MAX_SIZE;
     }
 
-    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210.dram0", mem_size,
+    memory_region_init_ram_nomigrate(&s->dram0_mem, NULL, "exynos4210.dram0", mem_size,
                            &error_fatal);
     vmstate_register_ram_global(&s->dram0_mem);
     memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 40666b6..0455c2b 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -267,7 +267,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                 &s->rom[1]);
 
     /* initialize internal RAM (128 KB) */
-    memory_region_init_ram(&s->iram, NULL, "imx25.iram", FSL_IMX25_IRAM_SIZE,
+    memory_region_init_ram_nomigrate(&s->iram, NULL, "imx25.iram", FSL_IMX25_IRAM_SIZE,
                            &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index c301306..35ad1e7 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -239,7 +239,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->rom);
 
     /* initialize internal RAM (16 KB) */
-    memory_region_init_ram(&s->iram, NULL, "imx31.iram", FSL_IMX31_IRAM_SIZE,
+    memory_region_init_ram_nomigrate(&s->iram, NULL, "imx31.iram", FSL_IMX31_IRAM_SIZE,
                            &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 27773c9..7234950 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -419,7 +419,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->caam);
 
     /* OCRAM memory */
-    memory_region_init_ram(&s->ocram, NULL, "imx6.ocram", FSL_IMX6_OCRAM_SIZE,
+    memory_region_init_ram_nomigrate(&s->ocram, NULL, "imx6.ocram", FSL_IMX6_OCRAM_SIZE,
                            &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index d209b97..012bb64 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -276,7 +276,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     memory_region_add_subregion(sysmem, 0, dram);
 
     sysram = g_new(MemoryRegion, 1);
-    memory_region_init_ram(sysram, NULL, "highbank.sysram", 0x8000,
+    memory_region_init_ram_nomigrate(sysram, NULL, "highbank.sysram", 0x8000,
                            &error_fatal);
     memory_region_add_subregion(sysmem, 0xfff88000, sysram);
     if (bios_name != NULL) {
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index ca3eca1..d79221d 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -276,7 +276,7 @@ static void integratorcm_init(Object *obj)
     s->cm_init = 0x00000112;
     s->cm_refcnt_offset = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), 24,
                                    1000);
-    memory_region_init_ram(&s->flash, obj, "integrator.flash", 0x100000,
+    memory_region_init_ram_nomigrate(&s->flash, obj, "integrator.flash", 0x100000,
                            &error_fatal);
     vmstate_register_ram_global(&s->flash);
 
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index f962236..4ade8a2 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -128,7 +128,7 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
 
     /* Setup CPU & memory */
     mpu = pxa270_init(address_space_mem, mainstone_binfo.ram_size, cpu_model);
-    memory_region_init_ram(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
+    memory_region_init_ram_nomigrate(rom, NULL, "mainstone.rom", MAINSTONE_ROM,
                            &error_fatal);
     vmstate_register_ram_global(rom);
     memory_region_set_readonly(rom, true);
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9c710f7..ee5dfed 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1604,7 +1604,7 @@ static void musicpal_init(MachineState *machine)
                                          MP_RAM_DEFAULT_SIZE);
     memory_region_add_subregion(address_space_mem, 0, ram);
 
-    memory_region_init_ram(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
+    memory_region_init_ram_nomigrate(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(address_space_mem, MP_SRAM_BASE, sram);
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 54582bd..f4afb88 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3880,7 +3880,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
     memory_region_allocate_system_memory(&s->emiff_ram, NULL, "omap1.dram",
                                          s->sdram_size);
     memory_region_add_subregion(system_memory, OMAP_EMIFF_BASE, &s->emiff_ram);
-    memory_region_init_ram(&s->imif_ram, NULL, "omap1.sram", s->sram_size,
+    memory_region_init_ram_nomigrate(&s->imif_ram, NULL, "omap1.sram", s->sram_size,
                            &error_fatal);
     vmstate_register_ram_global(&s->imif_ram);
     memory_region_add_subregion(system_memory, OMAP_IMIF_BASE, &s->imif_ram);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 91f5733..504bfe1 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2278,7 +2278,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
     memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
                                          s->sdram_size);
     memory_region_add_subregion(sysmem, OMAP2_Q2_BASE, &s->sdram);
-    memory_region_init_ram(&s->sram, NULL, "omap2.sram", s->sram_size,
+    memory_region_init_ram_nomigrate(&s->sram, NULL, "omap2.sram", s->sram_size,
                            &error_fatal);
     vmstate_register_ram_global(&s->sram);
     memory_region_add_subregion(sysmem, OMAP2_SRAM_BASE, &s->sram);
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 5d74026..d70c6b6 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -123,7 +123,7 @@ static void sx1_init(MachineState *machine, const int version)
                            machine->cpu_model);
 
     /* External Flash (EMIFS) */
-    memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size,
+    memory_region_init_ram_nomigrate(flash, NULL, "omap_sx1.flash0-0", flash_size,
                            &error_fatal);
     vmstate_register_ram_global(flash);
     memory_region_set_readonly(flash, true);
@@ -167,7 +167,7 @@ static void sx1_init(MachineState *machine, const int version)
     if ((version == 1) &&
             (dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
         MemoryRegion *flash_1 = g_new(MemoryRegion, 1);
-        memory_region_init_ram(flash_1, NULL, "omap_sx1.flash1-0", flash1_size,
+        memory_region_init_ram_nomigrate(flash_1, NULL, "omap_sx1.flash1-0", flash1_size,
                                &error_fatal);
         vmstate_register_ram_global(flash_1);
         memory_region_set_readonly(flash_1, true);
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 7f46073..abacdff 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -214,7 +214,7 @@ static void palmte_init(MachineState *machine)
     mpu = omap310_mpu_init(address_space_mem, sdram_size, cpu_model);
 
     /* External Flash (EMIFS) */
-    memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
+    memory_region_init_ram_nomigrate(flash, NULL, "palmte.flash", flash_size,
                            &error_fatal);
     vmstate_register_ram_global(flash);
     memory_region_set_readonly(flash, true);
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 629e6c6..ae46659 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2073,11 +2073,11 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
     s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
 
     /* SDRAM & Internal Memory Storage */
-    memory_region_init_ram(&s->sdram, NULL, "pxa270.sdram", sdram_size,
+    memory_region_init_ram_nomigrate(&s->sdram, NULL, "pxa270.sdram", sdram_size,
                            &error_fatal);
     vmstate_register_ram_global(&s->sdram);
     memory_region_add_subregion(address_space, PXA2XX_SDRAM_BASE, &s->sdram);
-    memory_region_init_ram(&s->internal, NULL, "pxa270.internal", 0x40000,
+    memory_region_init_ram_nomigrate(&s->internal, NULL, "pxa270.internal", 0x40000,
                            &error_fatal);
     vmstate_register_ram_global(&s->internal);
     memory_region_add_subregion(address_space, PXA2XX_INTERNAL_BASE,
@@ -2205,11 +2205,11 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
     s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
 
     /* SDRAM & Internal Memory Storage */
-    memory_region_init_ram(&s->sdram, NULL, "pxa255.sdram", sdram_size,
+    memory_region_init_ram_nomigrate(&s->sdram, NULL, "pxa255.sdram", sdram_size,
                            &error_fatal);
     vmstate_register_ram_global(&s->sdram);
     memory_region_add_subregion(address_space, PXA2XX_SDRAM_BASE, &s->sdram);
-    memory_region_init_ram(&s->internal, NULL, "pxa255.internal",
+    memory_region_init_ram_nomigrate(&s->internal, NULL, "pxa255.internal",
                            PXA2XX_INTERNAL_SIZE, &error_fatal);
     vmstate_register_ram_global(&s->internal);
     memory_region_add_subregion(address_space, PXA2XX_INTERNAL_BASE,
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b7d4753..a5e8f86 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -143,13 +143,13 @@ static void realview_init(MachineState *machine,
         ram_lo = g_new(MemoryRegion, 1);
         low_ram_size = ram_size - 0x20000000;
         ram_size = 0x20000000;
-        memory_region_init_ram(ram_lo, NULL, "realview.lowmem", low_ram_size,
+        memory_region_init_ram_nomigrate(ram_lo, NULL, "realview.lowmem", low_ram_size,
                                &error_fatal);
         vmstate_register_ram_global(ram_lo);
         memory_region_add_subregion(sysmem, 0x20000000, ram_lo);
     }
 
-    memory_region_init_ram(ram_hi, NULL, "realview.highmem", ram_size,
+    memory_region_init_ram_nomigrate(ram_hi, NULL, "realview.highmem", ram_size,
                            &error_fatal);
     vmstate_register_ram_global(ram_hi);
     low_ram_size = ram_size;
@@ -345,7 +345,7 @@ static void realview_init(MachineState *machine,
        startup code.  I guess this works on real hardware because the
        BootROM happens to be in ROM/flash or in memory that isn't clobbered
        until after Linux boots the secondary CPUs.  */
-    memory_region_init_ram(ram_hack, NULL, "realview.hack", 0x1000,
+    memory_region_init_ram_nomigrate(ram_hack, NULL, "realview.hack", 0x1000,
                            &error_fatal);
     vmstate_register_ram_global(ram_hack);
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 93bde14..f89584c 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -919,7 +919,7 @@ static void spitz_common_init(MachineState *machine,
 
     sl_flash_register(mpu, (model == spitz) ? FLASH_128M : FLASH_1024M);
 
-    memory_region_init_ram(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal);
+    memory_region_init_ram_nomigrate(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal);
     vmstate_register_ram_global(rom);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index cf6e7be..ce23f36 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1288,13 +1288,13 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
-    memory_region_init_ram(flash, NULL, "stellaris.flash", flash_size,
+    memory_region_init_ram_nomigrate(flash, NULL, "stellaris.flash", flash_size,
                            &error_fatal);
     vmstate_register_ram_global(flash);
     memory_region_set_readonly(flash, true);
     memory_region_add_subregion(system_memory, 0, flash);
 
-    memory_region_init_ram(sram, NULL, "stellaris.sram", sram_size,
+    memory_region_init_ram_nomigrate(sram, NULL, "stellaris.sram", sram_size,
                            &error_fatal);
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(system_memory, 0x20000000, sram);
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 6e1260d..2e9dff1 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -95,7 +95,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *flash_alias = g_new(MemoryRegion, 1);
 
-    memory_region_init_ram(flash, NULL, "STM32F205.flash", FLASH_SIZE,
+    memory_region_init_ram_nomigrate(flash, NULL, "STM32F205.flash", FLASH_SIZE,
                            &error_fatal);
     memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
                              flash, 0, FLASH_SIZE);
@@ -108,7 +108,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
     memory_region_add_subregion(system_memory, 0, flash_alias);
 
-    memory_region_init_ram(sram, NULL, "STM32F205.sram", SRAM_SIZE,
+    memory_region_init_ram_nomigrate(sram, NULL, "STM32F205.sram", SRAM_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 2421b81..bfd1153 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -234,7 +234,7 @@ static void tosa_init(MachineState *machine)
 
     mpu = pxa255_init(address_space_mem, tosa_binfo.ram_size);
 
-    memory_region_init_ram(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
+    memory_region_init_ram_nomigrate(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
     vmstate_register_ram_global(rom);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index c6b1e67..874d885 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -390,7 +390,7 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
     /* 0x2b060000: SP805 watchdog: not modelled */
     /* 0x2b0a0000: PL341 dynamic memory controller: not modelled */
     /* 0x2e000000: system SRAM */
-    memory_region_init_ram(sram, NULL, "vexpress.a15sram", 0x10000,
+    memory_region_init_ram_nomigrate(sram, NULL, "vexpress.a15sram", 0x10000,
                            &error_fatal);
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(sysmem, 0x2e000000, sram);
@@ -673,13 +673,13 @@ static void vexpress_common_init(MachineState *machine)
     }
 
     sram_size = 0x2000000;
-    memory_region_init_ram(sram, NULL, "vexpress.sram", sram_size,
+    memory_region_init_ram_nomigrate(sram, NULL, "vexpress.sram", sram_size,
                            &error_fatal);
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(sysmem, map[VE_SRAM], sram);
 
     vram_size = 0x800000;
-    memory_region_init_ram(vram, NULL, "vexpress.vram", vram_size,
+    memory_region_init_ram_nomigrate(vram, NULL, "vexpress.vram", vram_size,
                            &error_fatal);
     vmstate_register_ram_global(vram);
     memory_region_add_subregion(sysmem, map[VE_VIDEORAM], vram);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 010f724..30f010a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1155,7 +1155,7 @@ static void create_secure_ram(VirtMachineState *vms,
     hwaddr base = vms->memmap[VIRT_SECURE_MEM].base;
     hwaddr size = vms->memmap[VIRT_SECURE_MEM].size;
 
-    memory_region_init_ram(secram, NULL, "virt.secure-ram", size, &error_fatal);
+    memory_region_init_ram_nomigrate(secram, NULL, "virt.secure-ram", size, &error_fatal);
     vmstate_register_ram_global(secram);
     memory_region_add_subregion(secure_sysmem, base, secram);
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3985356..8ae6535 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -204,7 +204,7 @@ static void zynq_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ext_ram);
 
     /* 256K of on-chip memory */
-    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 << 10,
+    memory_region_init_ram_nomigrate(ocm_ram, NULL, "zynq.ocm_ram", 256 << 10,
                            &error_fatal);
     vmstate_register_ram_global(ocm_ram);
     memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 64f52f8..d6f73d7 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -226,7 +226,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_OCM_BANKS; i++) {
         char *ocm_name = g_strdup_printf("zynqmp.ocm_ram_bank_%d", i);
 
-        memory_region_init_ram(&s->ocm_ram[i], NULL, ocm_name,
+        memory_region_init_ram_nomigrate(&s->ocm_ram[i], NULL, ocm_name,
                                XLNX_ZYNQMP_OCM_RAM_SIZE, &error_fatal);
         vmstate_register_ram_global(&s->ocm_ram[i]);
         memory_region_add_subregion(get_system_memory(),
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index ddf5492..b742360 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -807,7 +807,7 @@ static int onenand_initfn(SysBusDevice *sbd)
     }
     s->otp = memset(g_malloc((64 + 2) << PAGE_SHIFT),
                     0xff, (64 + 2) << PAGE_SHIFT);
-    memory_region_init_ram(&s->ram, OBJECT(s), "onenand.ram",
+    memory_region_init_ram_nomigrate(&s->ram, OBJECT(s), "onenand.ram",
                            0xc000 << s->shift, &error_fatal);
     vmstate_register_ram_global(&s->ram);
     ram = memory_region_get_ram_ptr(&s->ram);
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 60df887..8a2564d 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -281,7 +281,7 @@ void axisdev88_init(MachineState *machine)
 
     /* The ETRAX-FS has 128Kb on chip ram, the docs refer to it as the 
        internal memory.  */
-    memory_region_init_ram(phys_intmem, NULL, "axisdev88.chipram", INTMEM_SIZE,
+    memory_region_init_ram_nomigrate(phys_intmem, NULL, "axisdev88.chipram", INTMEM_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(phys_intmem);
     memory_region_add_subregion(address_space_mem, 0x38000000, phys_intmem);
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 1de15a1..54439b2 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -283,7 +283,7 @@ static void cg3_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     CG3State *s = CG3(obj);
 
-    memory_region_init_ram(&s->rom, obj, "cg3.prom", FCODE_MAX_ROM_SIZE,
+    memory_region_init_ram_nomigrate(&s->rom, obj, "cg3.prom", FCODE_MAX_ROM_SIZE,
                            &error_fatal);
     memory_region_set_readonly(&s->rom, true);
     sysbus_init_mmio(sbd, &s->rom);
@@ -311,7 +311,7 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    memory_region_init_ram(&s->vram_mem, NULL, "cg3.vram", s->vram_size,
+    memory_region_init_ram_nomigrate(&s->vram_mem, NULL, "cg3.vram", s->vram_size,
                            &error_fatal);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
     vmstate_register_ram_global(&s->vram_mem);
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 3c1688e..40e9372 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2089,14 +2089,14 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     pci_set_byte(&config[PCI_INTERRUPT_PIN], 1);
 
     qxl->rom_size = qxl_rom_size();
-    memory_region_init_ram(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
+    memory_region_init_ram_nomigrate(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
                            qxl->rom_size, &error_fatal);
     vmstate_register_ram(&qxl->rom_bar, &qxl->pci.qdev);
     init_qxl_rom(qxl);
     init_qxl_ram(qxl);
 
     qxl->guest_surfaces.cmds = g_new0(QXLPHYSICAL, qxl->ssd.num_surfaces);
-    memory_region_init_ram(&qxl->vram_bar, OBJECT(qxl), "qxl.vram",
+    memory_region_init_ram_nomigrate(&qxl->vram_bar, OBJECT(qxl), "qxl.vram",
                            qxl->vram_size, &error_fatal);
     vmstate_register_ram(&qxl->vram_bar, &qxl->pci.qdev);
     memory_region_init_alias(&qxl->vram32_bar, OBJECT(qxl), "qxl.vram32",
@@ -2198,7 +2198,7 @@ static void qxl_realize_secondary(PCIDevice *dev, Error **errp)
 
     qxl->id = device_id++;
     qxl_init_ramsize(qxl);
-    memory_region_init_ram(&qxl->vga.vram, OBJECT(dev), "qxl.vgavram",
+    memory_region_init_ram_nomigrate(&qxl->vga.vram, OBJECT(dev), "qxl.vgavram",
                            qxl->vga.vram_size, &error_fatal);
     vmstate_register_ram(&qxl->vga.vram, &qxl->pci.qdev);
     qxl->vga.vram_ptr = memory_region_get_ram_ptr(&qxl->vga.vram);
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 9d254ef..af792c5 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1578,7 +1578,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
                   s->local_mem_size_index);
 
     /* local memory */
-    memory_region_init_ram(&s->local_mem_region, OBJECT(dev), "sm501.local",
+    memory_region_init_ram_nomigrate(&s->local_mem_region, OBJECT(dev), "sm501.local",
                            get_local_mem_size(s), &error_fatal);
     vmstate_register_ram_global(&s->local_mem_region);
     memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 92f7120..762e370 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -586,7 +586,7 @@ TC6393xbState *tc6393xb_init(MemoryRegion *sysmem, uint32_t base, qemu_irq irq)
     memory_region_init_io(&s->iomem, NULL, &tc6393xb_ops, s, "tc6393xb", 0x10000);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
-    memory_region_init_ram(&s->vram, NULL, "tc6393xb.vram", 0x100000,
+    memory_region_init_ram_nomigrate(&s->vram, NULL, "tc6393xb.vram", 0x100000,
                            &error_fatal);
     vmstate_register_ram_global(&s->vram);
     s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 6593c1d..daa93e0 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -752,7 +752,7 @@ static void tcx_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     TCXState *s = TCX(obj);
 
-    memory_region_init_ram(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
+    memory_region_init_ram_nomigrate(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
                            &error_fatal);
     memory_region_set_readonly(&s->rom, true);
     sysbus_init_mmio(sbd, &s->rom);
@@ -812,7 +812,7 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     uint8_t *vram_base;
     char *fcode_filename;
 
-    memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
+    memory_region_init_ram_nomigrate(&s->vram_mem, OBJECT(s), "tcx.vram",
                            s->vram_size * (1 + 4 + 4), &error_fatal);
     vmstate_register_ram_global(&s->vram_mem);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 80508b8..63421f9 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2166,7 +2166,7 @@ void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
     }
 
     s->is_vbe_vmstate = 1;
-    memory_region_init_ram(&s->vram, obj, "vga.vram", s->vram_size,
+    memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size,
                            &error_fatal);
     vmstate_register_ram(&s->vram, global_vmstate ? NULL : DEVICE(obj));
     xen_register_framebuffer(&s->vram);
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index c989cef..120b0dd 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1239,7 +1239,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
     s->vga.con = graphic_console_init(dev, 0, &vmsvga_ops, s);
 
     s->fifo_size = SVGA_FIFO_SIZE;
-    memory_region_init_ram(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
+    memory_region_init_ram_nomigrate(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
                            &error_fatal);
     vmstate_register_ram_global(&s->fifo_ram);
     s->fifo_ptr = memory_region_get_ram_ptr(&s->fifo_ram);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 224fe58..72c03ec 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1442,7 +1442,7 @@ void pc_memory_init(PCMachineState *pcms,
     pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
 
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+    memory_region_init_ram_nomigrate(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(option_rom_mr);
     memory_region_add_subregion_overlap(rom_memory,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index f915ad0..fbfd0c4 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -57,7 +57,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * 1024);
     isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
+    memory_region_init_ram_nomigrate(isa_bios, NULL, "isa-bios", isa_bios_size,
                            &error_fatal);
     vmstate_register_ram_global(isa_bios);
     memory_region_add_subregion_overlap(rom_memory,
@@ -195,7 +195,7 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
         goto bios_error;
     }
     bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    memory_region_init_ram_nomigrate(bios, NULL, "pc.bios", bios_size, &error_fatal);
     vmstate_register_ram_global(bios);
     if (!isapc_ram_fw) {
         memory_region_set_readonly(bios, true);
diff --git a/hw/i386/pci-assign-load-rom.c b/hw/i386/pci-assign-load-rom.c
index fd59076..43429b6 100644
--- a/hw/i386/pci-assign-load-rom.c
+++ b/hw/i386/pci-assign-load-rom.c
@@ -59,7 +59,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev, struct Object *owner,
     fseek(fp, 0, SEEK_SET);
 
     snprintf(name, sizeof(name), "%s.rom", object_get_typename(owner));
-    memory_region_init_ram(&dev->rom, owner, name, st.st_size, &error_abort);
+    memory_region_init_ram_nomigrate(&dev->rom, owner, name, st.st_size, &error_abort);
     vmstate_register_ram(&dev->rom, &dev->qdev);
     ptr = memory_region_get_ram_ptr(&dev->rom);
     memset(ptr, 0xff, st.st_size);
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index cffa7e2..55ec96d 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -212,7 +212,7 @@ static void xen_ram_init(PCMachineState *pcms,
          */
         block_len = (1ULL << 32) + pcms->above_4g_mem_size;
     }
-    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
+    memory_region_init_ram_nomigrate(&ram_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
     *ram_memory_p = &ram_memory;
     vmstate_register_ram_global(&ram_memory);
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 40dfca1..ef8f47c 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -256,12 +256,12 @@ static int milkymist_softusb_init(SysBusDevice *dev)
     sysbus_init_mmio(dev, &s->regs_region);
 
     /* register pmem and dmem */
-    memory_region_init_ram(&s->pmem, OBJECT(s), "milkymist-softusb.pmem",
+    memory_region_init_ram_nomigrate(&s->pmem, OBJECT(s), "milkymist-softusb.pmem",
                            s->pmem_size, &error_fatal);
     vmstate_register_ram_global(&s->pmem);
     s->pmem_ptr = memory_region_get_ram_ptr(&s->pmem);
     sysbus_init_mmio(dev, &s->pmem);
-    memory_region_init_ram(&s->dmem, OBJECT(s), "milkymist-softusb.dmem",
+    memory_region_init_ram_nomigrate(&s->dmem, OBJECT(s), "milkymist-softusb.dmem",
                            s->dmem_size, &error_fatal);
     vmstate_register_ram_global(&s->dmem);
     s->dmem_ptr = memory_region_get_ram_ptr(&s->dmem);
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 142bab9..6fd3c6f 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -60,7 +60,7 @@ static void an5206_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ram);
 
     /* Internal SRAM.  */
-    memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
+    memory_region_init_ram_nomigrate(sram, NULL, "an5206.sram", 512, &error_fatal);
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(address_space_mem, AN5206_RAMBAR_ADDR, sram);
 
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 6563518..f4abe1d 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -248,7 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0x40000000, ram);
 
     /* Internal SRAM.  */
-    memory_region_init_ram(sram, NULL, "mcf5208.sram", 16384, &error_fatal);
+    memory_region_init_ram_nomigrate(sram, NULL, "mcf5208.sram", 16384, &error_fatal);
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(address_space_mem, 0x80000000, sram);
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 4968bdb..fb022cd 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -96,12 +96,12 @@ petalogix_ml605_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram(phys_lmb_bram, NULL, "petalogix_ml605.lmb_bram",
+    memory_region_init_ram_nomigrate(phys_lmb_bram, NULL, "petalogix_ml605.lmb_bram",
                            LMB_BRAM_SIZE, &error_fatal);
     vmstate_register_ram_global(phys_lmb_bram);
     memory_region_add_subregion(address_space_mem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram(phys_ram, NULL, "petalogix_ml605.ram", ram_size,
+    memory_region_init_ram_nomigrate(phys_ram, NULL, "petalogix_ml605.ram", ram_size,
                            &error_fatal);
     vmstate_register_ram_global(phys_ram);
     memory_region_add_subregion(address_space_mem, MEMORY_BASEADDR, phys_ram);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 423bcd7..d71fcd5 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -75,13 +75,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), true, "realized", &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram(phys_lmb_bram, NULL,
+    memory_region_init_ram_nomigrate(phys_lmb_bram, NULL,
                            "petalogix_s3adsp1800.lmb_bram", LMB_BRAM_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(phys_lmb_bram);
     memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram(phys_ram, NULL, "petalogix_s3adsp1800.ram",
+    memory_region_init_ram_nomigrate(phys_ram, NULL, "petalogix_s3adsp1800.ram",
                            ram_size, &error_fatal);
     vmstate_register_ram_global(phys_ram);
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index dbe2805..def3717 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -294,7 +294,7 @@ static void mips_fulong2e_init(MachineState *machine)
 
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
-    memory_region_init_ram(bios, NULL, "fulong2e.bios", bios_size,
+    memory_region_init_ram_nomigrate(bios, NULL, "fulong2e.bios", bios_size,
                            &error_fatal);
     vmstate_register_ram_global(bios);
     memory_region_set_readonly(bios, true);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 1cef581..fcf0529 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -175,7 +175,7 @@ static void mips_jazz_init(MachineState *machine,
                                          machine->ram_size);
     memory_region_add_subregion(address_space, 0, ram);
 
-    memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
+    memory_region_init_ram_nomigrate(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(bios);
     memory_region_set_readonly(bios, true);
@@ -242,7 +242,7 @@ static void mips_jazz_init(MachineState *machine,
         {
             /* Simple ROM, so user doesn't have to provide one */
             MemoryRegion *rom_mr = g_new(MemoryRegion, 1);
-            memory_region_init_ram(rom_mr, NULL, "g364fb.rom", 0x80000,
+            memory_region_init_ram_nomigrate(rom_mr, NULL, "g364fb.rom", 0x80000,
                                    &error_fatal);
             vmstate_register_ram_global(rom_mr);
             memory_region_set_readonly(rom_mr, true);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 95cdabb..8b805dc 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1177,7 +1177,7 @@ void mips_malta_init(MachineState *machine)
      * handled by an overlapping region as the resulting ROM code subpage
      * regions are not executable.
      */
-    memory_region_init_ram(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
+    memory_region_init_ram_nomigrate(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
                            &error_fatal);
     if (!rom_copy(memory_region_get_ram_ptr(bios_copy),
                   FLASH_ADDRESS, BIOS_SIZE)) {
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 1b91195..da8dd81 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -177,7 +177,7 @@ mips_mipssim_init(MachineState *machine)
     /* Allocate RAM. */
     memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
                                          ram_size);
-    memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
+    memory_region_init_ram_nomigrate(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(bios);
     memory_region_set_readonly(bios, true);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index f4de9fc..a2f790b 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -236,7 +236,7 @@ void mips_r4k_init(MachineState *machine)
 #endif
     if ((bios_size > 0) && (bios_size <= BIOS_SIZE)) {
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
+        memory_region_init_ram_nomigrate(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
                                &error_fatal);
         vmstate_register_ram_global(bios);
         memory_region_set_readonly(bios, true);
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 3069834..e18fb74 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -128,11 +128,11 @@ static void moxiesim_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, cpu);
 
     /* Allocate RAM. */
-    memory_region_init_ram(ram, NULL, "moxiesim.ram", ram_size, &error_fatal);
+    memory_region_init_ram_nomigrate(ram, NULL, "moxiesim.ram", ram_size, &error_fatal);
     vmstate_register_ram_global(ram);
     memory_region_add_subregion(address_space_mem, ram_base, ram);
 
-    memory_region_init_ram(rom, NULL, "moxie.rom", 128*0x1000, &error_fatal);
+    memory_region_init_ram_nomigrate(rom, NULL, "moxie.rom", 128*0x1000, &error_fatal);
     vmstate_register_ram_global(rom);
     memory_region_add_subregion(get_system_memory(), 0x1000, rom);
 
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b53fcaa..f2d2ce3 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -887,7 +887,7 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
     s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
     s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
 
-    memory_region_init_ram(&s->prom, OBJECT(dev),
+    memory_region_init_ram_nomigrate(&s->prom, OBJECT(dev),
                            "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index c3a12e1..3eaa19d 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -466,7 +466,7 @@ static int milkymist_minimac2_init(SysBusDevice *sbd)
     sysbus_init_mmio(sbd, &s->regs_region);
 
     /* register buffers memory */
-    memory_region_init_ram(&s->buffers, OBJECT(dev), "milkymist-minimac2.buffers",
+    memory_region_init_ram_nomigrate(&s->buffers, OBJECT(dev), "milkymist-minimac2.buffers",
                            buffers_size, &error_fatal);
     vmstate_register_ram_global(&s->buffers);
     s->rx0_buf = memory_region_get_ram_ptr(&s->buffers);
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 051be73..4f1ea2d 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -57,7 +57,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
     int i;
 
     /* Physical TCM (tb_ram_1k) with alias at 0xc0000000 */
-    memory_region_init_ram(phys_tcm, NULL, "nios2.tcm", tcm_size, &error_abort);
+    memory_region_init_ram_nomigrate(phys_tcm, NULL, "nios2.tcm", tcm_size, &error_abort);
     memory_region_init_alias(phys_tcm_alias, NULL, "nios2.tcm.alias",
                              phys_tcm, 0, tcm_size);
     vmstate_register_ram_global(phys_tcm);
@@ -66,7 +66,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
                                 phys_tcm_alias);
 
     /* Physical DRAM with alias at 0xc0000000 */
-    memory_region_init_ram(phys_ram, NULL, "nios2.ram", ram_size, &error_abort);
+    memory_region_init_ram_nomigrate(phys_ram, NULL, "nios2.ram", ram_size, &error_abort);
     memory_region_init_alias(phys_ram_alias, NULL, "nios2.ram.alias",
                              phys_ram, 0, ram_size);
     vmstate_register_ram_global(phys_ram);
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index fc0d096..73d8d7a 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -119,7 +119,7 @@ static void openrisc_sim_init(MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
+    memory_region_init_ram_nomigrate(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
     vmstate_register_ram_global(ram);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 900a6ed..8b293ba 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -304,7 +304,7 @@ static void raven_realize(PCIDevice *d, Error **errp)
     d->config[0x0D] = 0x10; // latency_timer
     d->config[0x34] = 0x00; // capabilities_pointer
 
-    memory_region_init_ram(&s->bios, OBJECT(s), "bios", BIOS_SIZE,
+    memory_region_init_ram_nomigrate(&s->bios, OBJECT(s), "bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(&s->bios, true);
     memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE),
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 2c78dcf..4613dda 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -120,7 +120,7 @@ static void xilinx_pcie_host_realize(DeviceState *dev, Error **errp)
     memory_region_set_enabled(&s->mmio, false);
 
     /* dummy I/O region */
-    memory_region_init_ram(&s->io, OBJECT(s), "io", 16, NULL);
+    memory_region_init_ram_nomigrate(&s->io, OBJECT(s), "io", 16, NULL);
     memory_region_set_enabled(&s->io, false);
 
     /* interrupt out */
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index bae1c0a..0b35ef1 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -204,7 +204,7 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     /* allocate and load BIOS */
-    memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
+    memory_region_init_ram_nomigrate(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(bios);
 
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 97bb854..ac604cb 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -141,7 +141,7 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0, ram);
 
     /* allocate and load BIOS */
-    memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
+    memory_region_init_ram_nomigrate(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
                            &error_fatal);
     vmstate_register_ram_global(bios);
 
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index d01798f..c0146e8 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -218,7 +218,7 @@ static void ref405ep_init(MachineState *machine)
                         33333333, &pic, kernel_filename == NULL ? 0 : 1);
     /* allocate SRAM */
     sram_size = 512 * 1024;
-    memory_region_init_ram(sram, NULL, "ef405ep.sram", sram_size,
+    memory_region_init_ram_nomigrate(sram, NULL, "ef405ep.sram", sram_size,
                            &error_fatal);
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(sysmem, 0xFFF00000, sram);
@@ -253,7 +253,7 @@ static void ref405ep_init(MachineState *machine)
         printf("Load BIOS from file\n");
 #endif
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "ef405ep.bios", BIOS_SIZE,
+        memory_region_init_ram_nomigrate(bios, NULL, "ef405ep.bios", BIOS_SIZE,
                                &error_fatal);
         vmstate_register_ram_global(bios);
 
@@ -554,7 +554,7 @@ static void taihu_405ep_init(MachineState *machine)
         if (bios_name == NULL)
             bios_name = BIOS_FILENAME;
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
+        memory_region_init_ram_nomigrate(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
                                &error_fatal);
         vmstate_register_ram_global(bios);
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index fc32e96..d5cf07e 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -978,7 +978,7 @@ static void ppc405_ocm_init(CPUPPCState *env)
 
     ocm = g_malloc0(sizeof(ppc405_ocm_t));
     /* XXX: Size is 4096 or 0x04000000 */
-    memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
+    memory_region_init_ram_nomigrate(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
                            &error_fatal);
     vmstate_register_ram_global(&ocm->isarc_ram);
     memory_region_init_alias(&ocm->dsarc_ram, NULL, "ppc405.dsarc", &ocm->isarc_ram,
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 83d6023..6e7c0ba 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -266,7 +266,7 @@ static void assign_storage(SCLPDevice *sclp, SCCB *sccb)
                 this_subregion_size = mhd->standby_subregion_size;
             }
 
-            memory_region_init_ram(standby_ram, NULL, id, this_subregion_size,
+            memory_region_init_ram_nomigrate(standby_ram, NULL, id, this_subregion_size,
                                    &error_fatal);
             /* This is a hack to make memory hotunplug work again. Once we have
              * subdevices, we have to unparent them when unassigning memory,
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e6fc74e..82e3b19 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -259,7 +259,7 @@ static void r2d_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate memory space */
-    memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_SIZE, &error_fatal);
+    memory_region_init_ram_nomigrate(sdram, NULL, "r2d.sdram", SDRAM_SIZE, &error_fatal);
     vmstate_register_ram_global(sdram);
     memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
     /* Register peripherals */
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index fd00cc5..bf0d8c3 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -63,15 +63,15 @@ static void shix_init(MachineState *machine)
     }
 
     /* Allocate memory space */
-    memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
+    memory_region_init_ram_nomigrate(rom, NULL, "shix.rom", 0x4000, &error_fatal);
     vmstate_register_ram_global(rom);
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(sysmem, 0x00000000, rom);
-    memory_region_init_ram(&sdram[0], NULL, "shix.sdram1", 0x01000000,
+    memory_region_init_ram_nomigrate(&sdram[0], NULL, "shix.sdram1", 0x01000000,
                            &error_fatal);
     vmstate_register_ram_global(&sdram[0]);
     memory_region_add_subregion(sysmem, 0x08000000, &sdram[0]);
-    memory_region_init_ram(&sdram[1], NULL, "shix.sdram2", 0x01000000,
+    memory_region_init_ram_nomigrate(&sdram[1], NULL, "shix.sdram2", 0x01000000,
                            &error_fatal);
     vmstate_register_ram_global(&sdram[1]);
     memory_region_add_subregion(sysmem, 0x0c000000, &sdram[1]);
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f415997..6758ba6 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -159,7 +159,7 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate BIOS */
     prom_size = 8 * 1024 * 1024; /* 8Mb */
-    memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
+    memory_region_init_ram_nomigrate(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
     vmstate_register_ram_global(prom);
     memory_region_set_readonly(prom, true);
     memory_region_add_subregion(address_space_mem, 0x00000000, prom);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0faff46..89dd8a9 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -590,7 +590,7 @@ static void idreg_init1(Object *obj)
     IDRegState *s = MACIO_ID_REGISTER(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->mem, obj,
+    memory_region_init_ram_nomigrate(&s->mem, obj,
                            "sun4m.idreg", sizeof(idreg_data), &error_fatal);
     vmstate_register_ram_global(&s->mem);
     memory_region_set_readonly(&s->mem, true);
@@ -631,7 +631,7 @@ static void afx_init1(Object *obj)
     AFXState *s = TCX_AFX(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->mem, obj, "sun4m.afx", 4, &error_fatal);
+    memory_region_init_ram_nomigrate(&s->mem, obj, "sun4m.afx", 4, &error_fatal);
     vmstate_register_ram_global(&s->mem);
     sysbus_init_mmio(dev, &s->mem);
 }
@@ -698,7 +698,7 @@ static void prom_init1(Object *obj)
     PROMState *s = OPENPROM(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->prom, obj, "sun4m.prom", PROM_SIZE_MAX,
+    memory_region_init_ram_nomigrate(&s->prom, obj, "sun4m.prom", PROM_SIZE_MAX,
                            &error_fatal);
     vmstate_register_ram_global(&s->prom);
     memory_region_set_readonly(&s->prom, true);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 69f565d..bbdb40c 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -334,7 +334,7 @@ static void prom_init1(Object *obj)
     PROMState *s = OPENPROM(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_ram(&s->prom, obj, "sun4u.prom", PROM_SIZE_MAX,
+    memory_region_init_ram_nomigrate(&s->prom, obj, "sun4u.prom", PROM_SIZE_MAX,
                            &error_fatal);
     vmstate_register_ram_global(&s->prom);
     memory_region_set_readonly(&s->prom, true);
@@ -377,7 +377,7 @@ static void ram_realize(DeviceState *dev, Error **errp)
     RamDevice *d = SUN4U_RAM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_init_ram(&d->ram, OBJECT(d), "sun4u.ram", d->size,
+    memory_region_init_ram_nomigrate(&d->ram, OBJECT(d), "sun4u.ram", d->size,
                            &error_fatal);
     vmstate_register_ram_global(&d->ram);
     sysbus_init_mmio(sbd, &d->ram);
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 8910bf0..94b185e 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -80,22 +80,22 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
         exit(1);
     }
     env = &cpu->env;
-    memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram", 2*1024*1024,
+    memory_region_init_ram_nomigrate(ext_cram, NULL, "powerlink_ext_c.ram", 2*1024*1024,
                            &error_fatal);
     vmstate_register_ram_global(ext_cram);
-    memory_region_init_ram(ext_dram, NULL, "powerlink_ext_d.ram", 4*1024*1024,
+    memory_region_init_ram_nomigrate(ext_dram, NULL, "powerlink_ext_d.ram", 4*1024*1024,
                            &error_fatal);
     vmstate_register_ram_global(ext_dram);
-    memory_region_init_ram(int_cram, NULL, "powerlink_int_c.ram", 48*1024,
+    memory_region_init_ram_nomigrate(int_cram, NULL, "powerlink_int_c.ram", 48*1024,
                            &error_fatal);
     vmstate_register_ram_global(int_cram);
-    memory_region_init_ram(int_dram, NULL, "powerlink_int_d.ram", 48*1024,
+    memory_region_init_ram_nomigrate(int_dram, NULL, "powerlink_int_d.ram", 48*1024,
                            &error_fatal);
     vmstate_register_ram_global(int_dram);
-    memory_region_init_ram(pcp_data, NULL, "powerlink_pcp_data.ram", 16*1024,
+    memory_region_init_ram_nomigrate(pcp_data, NULL, "powerlink_pcp_data.ram", 16*1024,
                            &error_fatal);
     vmstate_register_ram_global(pcp_data);
-    memory_region_init_ram(pcp_text, NULL, "powerlink_pcp_text.ram", 32*1024,
+    memory_region_init_ram_nomigrate(pcp_text, NULL, "powerlink_pcp_text.ram", 32*1024,
                            &error_fatal);
     vmstate_register_ram_global(pcp_text);
 
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 032078fd..291d75f 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -78,7 +78,7 @@ static void puv3_board_init(CPUUniCore32State *env, ram_addr_t ram_size)
     MemoryRegion *ram_memory = g_new(MemoryRegion, 1);
 
     /* SDRAM at address zero.  */
-    memory_region_init_ram(ram_memory, NULL, "puv3.ram", ram_size,
+    memory_region_init_ram_nomigrate(ram_memory, NULL, "puv3.ram", ram_size,
                            &error_fatal);
     vmstate_register_ram_global(ram_memory);
     memory_region_add_subregion(get_system_memory(), 0, ram_memory);
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 5521e91..3c6447b 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -48,7 +48,7 @@ static void xtensa_create_memory_regions(const XtensaMemory *memory,
 
         g_string_printf(num_name, "%s%u", name, i);
         m = g_new(MemoryRegion, 1);
-        memory_region_init_ram(m, NULL, num_name->str,
+        memory_region_init_ram_nomigrate(m, NULL, num_name->str,
                                memory->location[i].size,
                                &error_fatal);
         vmstate_register_ram_global(m);
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d5ac080..0c91c37 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -147,7 +147,7 @@ static void lx60_net_init(MemoryRegion *address_space,
             sysbus_mmio_get_region(s, 1));
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, OBJECT(s), "open_eth.ram", 16384,
+    memory_region_init_ram_nomigrate(ram, OBJECT(s), "open_eth.ram", 16384,
                            &error_fatal);
     vmstate_register_ram_global(ram);
     memory_region_add_subregion(address_space, buffers, ram);
@@ -249,7 +249,7 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "lx60.dram", machine->ram_size,
+    memory_region_init_ram_nomigrate(ram, NULL, "lx60.dram", machine->ram_size,
                            &error_fatal);
     vmstate_register_ram_global(ram);
     memory_region_add_subregion(system_memory, 0, ram);
@@ -292,7 +292,7 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
         uint32_t cur_lowmem = QEMU_ALIGN_UP(lowmem_end / 2, 4096);
 
         rom = g_malloc(sizeof(*rom));
-        memory_region_init_ram(rom, NULL, "lx60.sram", board->sram_size,
+        memory_region_init_ram_nomigrate(rom, NULL, "lx60.sram", board->sram_size,
                                &error_fatal);
         vmstate_register_ram_global(rom);
         memory_region_add_subregion(system_memory, 0xfe000000, rom);
diff --git a/memory.c b/memory.c
index 1044bba..9267745 100644
--- a/memory.c
+++ b/memory.c
@@ -1350,11 +1350,11 @@ void memory_region_init_io(MemoryRegion *mr,
     mr->terminates = true;
 }
 
-void memory_region_init_ram(MemoryRegion *mr,
-                            Object *owner,
-                            const char *name,
-                            uint64_t size,
-                            Error **errp)
+void memory_region_init_ram_nomigrate(MemoryRegion *mr,
+                                      Object *owner,
+                                      const char *name,
+                                      uint64_t size,
+                                      Error **errp)
 {
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
diff --git a/numa.c b/numa.c
index b0e75f6..e32af04 100644
--- a/numa.c
+++ b/numa.c
@@ -542,14 +542,14 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
             /* Legacy behavior: if allocation failed, fall back to
              * regular RAM allocation.
              */
-            memory_region_init_ram(mr, owner, name, ram_size, &error_fatal);
+            memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
         }
 #else
         fprintf(stderr, "-mem-path not supported on this host\n");
         exit(1);
 #endif
     } else {
-        memory_region_init_ram(mr, owner, name, ram_size, &error_fatal);
+        memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
     }
     vmstate_register_ram_global(mr);
 }
-- 
2.7.4
