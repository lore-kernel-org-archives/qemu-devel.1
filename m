Received: from eggs.gnu.org ([2001:4830:134:3::10]:34934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMm-0000hv-8h
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMk-0003gX-A8
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:40 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:21 -0800
Message-ID: <f3216f23f78da16fcf77a9757d2323d03afc08a3.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 31/45] hw/ppc: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, qemu-ppc@nongnu.org

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-ppc@nongnu.org
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
V2:
 - Split hw patch into individual directories

 hw/ppc/e500.c          | 22 +++++++++++-----------
 hw/ppc/mac_newworld.c  |  2 +-
 hw/ppc/mac_oldworld.c  |  2 +-
 hw/ppc/mpc8544_guts.c  |  5 +++--
 hw/ppc/ppc405_boards.c | 15 ++++++---------
 hw/ppc/ppc440_bamboo.c | 22 +++++++++++-----------
 hw/ppc/ppc4xx_pci.c    |  3 ++-
 hw/ppc/prep.c          |  4 ++--
 hw/ppc/virtex_ml507.c  |  4 ++--
 9 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 9178e70132..e488fb4f3a 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -333,13 +333,13 @@ static int ppce500_load_device_tree(MachineState *machine,
         ret = qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
                                     initrd_base);
         if (ret < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
+            error_report("couldn't set /chosen/linux,initrd-start");
         }
 
         ret = qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
                                     (initrd_base + initrd_size));
         if (ret < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
+            error_report("couldn't set /chosen/linux,initrd-end");
         }
 
     }
@@ -353,7 +353,7 @@ static int ppce500_load_device_tree(MachineState *machine,
     ret = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                       machine->kernel_cmdline);
     if (ret < 0)
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        error_report("couldn't set /chosen/bootargs");
 
     if (kvm_enabled()) {
         /* Read out host's frequencies */
@@ -720,7 +720,7 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Params *params,
 
     CPU_FOREACH(cs) {
         if (kvm_openpic_connect_vcpu(dev, cs)) {
-            fprintf(stderr, "%s: failed to connect vcpu to irqchip\n",
+            error_report("%s: failed to connect vcpu to irqchip",
                     __func__);
             abort();
         }
@@ -815,7 +815,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         cs = CPU(cpu);
 
         if (env->mmu_model != POWERPC_MMU_BOOKE206) {
-            fprintf(stderr, "MMU model %i not supported by this machine.\n",
+            error_report("MMU model %i not supported by this machine.",
                 env->mmu_model);
             exit(1);
         }
@@ -961,8 +961,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                           cur_base,
                                           ram_size - cur_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    machine->kernel_filename);
+            error_report("could not load kernel '%s'",
+                         machine->kernel_filename);
             exit(1);
         }
 
@@ -976,8 +976,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                           ram_size - initrd_base);
 
         if (initrd_size < 0) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
-                    machine->initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         machine->initrd_filename);
             exit(1);
         }
 
@@ -1018,7 +1018,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         kernel_size = load_uimage(filename, &bios_entry, &loadaddr, NULL,
                                   NULL, NULL);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load firmware '%s'\n", filename);
+            error_report("could not load firmware '%s'", filename);
             exit(1);
         }
     }
@@ -1031,7 +1031,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                        initrd_base, initrd_size,
                                        kernel_base, kernel_size);
     if (dt_size < 0) {
-        fprintf(stderr, "couldn't load device tree\n");
+        error_report("couldn't load device tree");
         exit(1);
     }
     assert(dt_size < DTB_MAX_SIZE);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3fa7c429d5..b832417a56 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -270,7 +270,7 @@ static void ppc_core99_init(MachineState *machine)
             }
         }
         if (ppc_boot_device == '\0') {
-            fprintf(stderr, "No valid boot device for Mac99 machine\n");
+            error_report("No valid boot device for Mac99 machine");
             exit(1);
         }
     }
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 010ea36bf2..d1f4546613 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -218,7 +218,7 @@ static void ppc_heathrow_init(MachineState *machine)
 #endif
         }
         if (ppc_boot_device == '\0') {
-            fprintf(stderr, "No valid boot device for G3 Beige machine\n");
+            error_report("No valid boot device for G3 Beige machine");
             exit(1);
         }
     }
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index ce1254b5d4..3a2c49e3fd 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -83,7 +84,7 @@ static uint64_t mpc8544_guts_read(void *opaque, hwaddr addr,
         value = env->spr[SPR_E500_SVR];
         break;
     default:
-        fprintf(stderr, "guts: Unknown register read: %x\n", (int)addr);
+        error_report("guts: Unknown register read: %x", (int)addr);
         break;
     }
 
@@ -102,7 +103,7 @@ static void mpc8544_guts_write(void *opaque, hwaddr addr,
         }
         break;
     default:
-        fprintf(stderr, "guts: Unknown register write: %x = %x\n",
+        error_report("guts: Unknown register write: %x = %x",
                 (int)addr, (unsigned)value);
         break;
     }
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e92db2c66a..fae9c76174 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -324,8 +324,7 @@ static void ref405ep_init(MachineState *machine)
         kernel_size = load_image_targphys(kernel_filename, kernel_base,
                                           ram_size - kernel_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
         printf("Load kernel size %ld at " TARGET_FMT_lx,
@@ -336,8 +335,8 @@ static void ref405ep_init(MachineState *machine)
             initrd_size = load_image_targphys(initrd_filename, initrd_base,
                                               ram_size - initrd_base);
             if (initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
-                        initrd_filename);
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         } else {
@@ -607,8 +606,7 @@ static void taihu_405ep_init(MachineState *machine)
         kernel_size = load_image_targphys(kernel_filename, kernel_base,
                                           ram_size - kernel_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
         /* load initrd */
@@ -617,9 +615,8 @@ static void taihu_405ep_init(MachineState *machine)
             initrd_size = load_image_targphys(initrd_filename, initrd_base,
                                               ram_size - initrd_base);
             if (initrd_size < 0) {
-                fprintf(stderr,
-                        "qemu: could not load initial ram disk '%s'\n",
-                        initrd_filename);
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         } else {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 693c215108..12f92b9f2c 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "net/net.h"
 #include "hw/hw.h"
@@ -80,22 +81,22 @@ static int bamboo_load_device_tree(hwaddr addr,
     ret = qemu_fdt_setprop(fdt, "/memory", "reg", mem_reg_property,
                            sizeof(mem_reg_property));
     if (ret < 0)
-        fprintf(stderr, "couldn't set /memory/reg\n");
+        error_report("couldn't set /memory/reg");
 
     ret = qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
                                 initrd_base);
     if (ret < 0)
-        fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
+        error_report("couldn't set /chosen/linux,initrd-start");
 
     ret = qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
                                 (initrd_base + initrd_size));
     if (ret < 0)
-        fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
+        error_report("couldn't set /chosen/linux,initrd-end");
 
     ret = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                   kernel_cmdline);
     if (ret < 0)
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        error_report("couldn't set /chosen/bootargs");
 
     /* Copy data from the host device tree into the guest. Since the guest can
      * directly access the timebase without host involvement, we must expose
@@ -186,7 +187,7 @@ static void bamboo_init(MachineState *machine)
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
-        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+        error_report("MMU model %i not supported by this machine.",
             env->mmu_model);
         exit(1);
     }
@@ -220,7 +221,7 @@ static void bamboo_init(MachineState *machine)
                                 NULL);
     pcibus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (!pcibus) {
-        fprintf(stderr, "couldn't create PCI controller!\n");
+        error_report("couldn't create PCI controller!");
         exit(1);
     }
 
@@ -261,8 +262,7 @@ static void bamboo_init(MachineState *machine)
         }
         /* XXX try again as binary */
         if (success < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
     }
@@ -273,8 +273,8 @@ static void bamboo_init(MachineState *machine)
                                           ram_size - RAMDISK_ADDR);
 
         if (initrd_size < 0) {
-            fprintf(stderr, "qemu: could not load ram disk '%s' at %x\n",
-                    initrd_filename, RAMDISK_ADDR);
+            error_report("could not load ram disk '%s' at %x",
+                         initrd_filename, RAMDISK_ADDR);
             exit(1);
         }
     }
@@ -283,7 +283,7 @@ static void bamboo_init(MachineState *machine)
     if (kernel_filename) {
         if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
                                     initrd_size, kernel_cmdline) < 0) {
-            fprintf(stderr, "couldn't load device tree\n");
+            error_report("couldn't load device tree");
             exit(1);
         }
     }
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 4765dcecca..807e91b8fa 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -20,6 +20,7 @@
  * 4xx SoCs, such as the 440EP. */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
@@ -254,7 +255,7 @@ static void ppc4xx_pci_set_irq(void *opaque, int irq_num, int level)
 
     trace_ppc4xx_pci_set_irq(irq_num);
     if (irq_num < 0) {
-        fprintf(stderr, "%s: PCI irq %d\n", __func__, irq_num);
+        error_report("%s: PCI irq %d", __func__, irq_num);
         return;
     }
     qemu_set_irq(pci_irqs[irq_num], level);
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 6f8accc397..17d6d1960b 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -573,7 +573,7 @@ static void ppc_prep_init(MachineState *machine)
             }
         }
         if (ppc_boot_device == '\0') {
-            fprintf(stderr, "No valid boot device for Mac99 machine\n");
+            error_report("No valid boot device for Mac99 machine");
             exit(1);
         }
     }
@@ -594,7 +594,7 @@ static void ppc_prep_init(MachineState *machine)
     qdev_init_nofail(dev);
     pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (pci_bus == NULL) {
-        fprintf(stderr, "Couldn't create PCI host controller.\n");
+        error_report("Couldn't create PCI host controller.");
         exit(1);
     }
     sysctrl->contiguous_map_irq = qdev_get_gpio_in(dev, 0);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 5ac4f76613..c1cac864c6 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -187,7 +187,7 @@ static int xilinx_load_device_tree(hwaddr addr,
 
     r = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", kernel_cmdline);
     if (r < 0)
-        fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        error_report("couldn't set /chosen/bootargs");
     cpu_physical_memory_write(addr, fdt, fdt_size);
     return fdt_size;
 }
@@ -215,7 +215,7 @@ static void virtex_init(MachineState *machine)
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
-        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+        error_report("MMU model %i not supported by this machine.",
             env->mmu_model);
         exit(1);
     }
-- 
2.14.1
