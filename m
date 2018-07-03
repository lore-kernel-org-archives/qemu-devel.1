Received: from eggs.gnu.org ([2001:4830:134:3::10]:40042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKb-0002xV-SN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKY-00077N-RY
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:58:04 +1000
Message-Id: <20180703055804.13449-36-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 35/35] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Sebastian Bauer <mail@sebastianbauer.info>, David Gibson <david@gibson.dropbear.id.au>

From: Sebastian Bauer <mail@sebastianbauer.info>

Drivers for this card exists on PPC-based AmigaOS guests so it is useful to
allow users to emulate the graphics card for PPC machines.

As cirrus vga is currently preferred over std(vga) in absence of any user
choice, this change also sets the default display of spapr machines to
std as otherwise qemu refuses to start these machines. Not specifying an
explicit graphics mode is for instance done by 'make check'.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak | 1 +
 hw/ppc/spapr.c                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 7e1a3d8135..6f12bf84f0 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -29,6 +29,7 @@ CONFIG_IDE_SII3112=y
 CONFIG_I2C=y
 CONFIG_BITBANG_I2C=y
 CONFIG_M41T80=y
+CONFIG_VGA_CIRRUS=y
 
 # For Macs
 CONFIG_MAC=y
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 062d9dc346..6e8723d3ba 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3962,6 +3962,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * M_BYTE;
+    mc->default_display = "std";
     mc->kvm_type = spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
     mc->pci_allow_0_address = true;
-- 
2.17.1
