Received: from eggs.gnu.org ([2001:4830:134:3::10]:44152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq7-00052x-Ab
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq4-0002AG-8H
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:07 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:35 +1000
Message-Id: <20180709074350.27086-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/16] ppc: fix default VGA display for Mac
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commit 29f9cef39e "ppc: Include vga cirrus card into the compiling process"
changed the default display adapter for all PPC machines to cirrus. Unfortunately
it missed setting the default display type to stdvga for both Mac machines
causing the display to fail to initialise under OpenBIOS.

Update the MachineClass for both Old World and New World Macs so that the
default std(vga) display adapter is the default if no options are specified
which fixes the display for the Mac machines.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 1 +
 hw/ppc/mac_oldworld.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index d11980166f..2ca294664b 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -525,6 +525,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->max_cpus = MAX_CPUS;
     mc->default_boot_order = "cd";
+    mc->default_display = "std";
     mc->kvm_type = core99_kvm_type;
 #ifdef TARGET_PPC64
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 06ed6f660e..064d7eb30a 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -383,6 +383,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->kvm_type = heathrow_kvm_type;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("750_v3.1");
+    mc->default_display = "std";
 }
 
 static const TypeInfo ppc_heathrow_machine_info = {
-- 
2.17.1
