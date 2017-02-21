Received: from eggs.gnu.org ([2001:4830:134:3::10]:53871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qf-Ci
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiH-0004SH-J7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:53 +0100
Message-Id: <1487715299-21102-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] ppc: use ppc_graphic_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "open list:New World" <qemu-ppc@nongnu.org>

This switches over ppc to use the new ppc_graphic_* defines.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/ppc/mac_newworld.c |  6 +++---
 hw/ppc/mac_oldworld.c |  6 +++---
 hw/ppc/prep.c         | 10 +++++-----
 hw/ppc/spapr.c        |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 2bfdb64..4722277 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -482,9 +482,9 @@ static void ppc_core99_init(MachineState *machine)
     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
 
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, ppc_graphic_width);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, ppc_graphic_height);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, ppc_graphic_depth);
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
     if (kvm_enabled()) {
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 56282c5..a79f011 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -335,9 +335,9 @@ static void ppc_heathrow_init(MachineState *machine)
     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
 
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, ppc_graphic_width);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, ppc_graphic_height);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, ppc_graphic_depth);
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
     if (kvm_enabled()) {
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index ca7959c..82bf6b5 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -677,7 +677,7 @@ static void ppc_prep_init(MachineState *machine)
                          initrd_base, initrd_size,
                          /* XXX: need an option to load a NVRAM image */
                          0,
-                         graphic_width, graphic_height, graphic_depth);
+                         ppc_graphic_width, ppc_graphic_height, ppc_graphic_depth);
 }
 
 static void prep_machine_init(MachineClass *mc)
@@ -861,9 +861,9 @@ static void ibm_40p_init(MachineState *machine)
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
 
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, ppc_graphic_width);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, ppc_graphic_height);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, ppc_graphic_depth);
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
     if (kvm_enabled()) {
@@ -891,7 +891,7 @@ static void ibm_40p_init(MachineState *machine)
                              initrd_base, initrd_size,
                              /* XXX: need an option to load a NVRAM image */
                              0,
-                             graphic_width, graphic_height, graphic_depth);
+                             ppc_graphic_width, ppc_graphic_height, ppc_graphic_depth);
     }
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e465d7a..ba8f81e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -824,9 +824,9 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
     if (boot_menu) {
         _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", boot_menu)));
     }
-    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic_width));
-    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphic_height));
-    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic_depth));
+    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", ppc_graphic_width));
+    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", ppc_graphic_height));
+    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", ppc_graphic_depth));
 
     if (cb && bootlist) {
         int i;
-- 
1.8.3.1
