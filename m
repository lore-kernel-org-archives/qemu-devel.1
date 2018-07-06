Received: from eggs.gnu.org ([2001:4830:134:3::10]:51646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fbLXI-00048o-U8
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fbLXE-0007I1-No
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:52:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  6 Jul 2018 08:51:55 +0100
Message-Id: <20180706075155.14116-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH for-3.0] ppc: fix default VGA display for PReP
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, ehabkost@redhat.com, kraxel@redhat.com

Commit 29f9cef "ppc: Include vga cirrus card into the compiling process"
changed the default display adapter for all PPC machines to cirrus. Unfortunately
it missed setting the default display type to stdvga for both PReP machines
causing the display to fail to initialise under OpenHackWare.

Update the MachineClass for both prep and 40p machines so that the default
std(vga) display adapter is the default if no options are specified
which fixes the display for the PReP machines.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/prep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 6689407b3d..3401570d98 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -682,6 +682,7 @@ static void prep_machine_init(MachineClass *mc)
     mc->max_cpus = MAX_CPUS;
     mc->default_boot_order = "cad";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("602");
+    mc->default_display = "std";
 }
 
 static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
@@ -888,6 +889,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
+    mc->default_display = "std";
 }
 
 DEFINE_MACHINE("40p", ibm_40p_machine_init)
-- 
2.11.0
