Received: from eggs.gnu.org ([2001:4830:134:3::10]:58927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZS-0000rk-AZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZQ-0001o2-4R
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:41 +1000
Message-Id: <20180427092126.24812-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/49] uninorth: remove stray PCIBus realize
 from mac_newworld.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

After QOMification this is clearly no longer needed (and possibly hasn't been
for some time).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 39944203a4..4ff1c293a8 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -350,7 +350,6 @@ static void ppc_core99_init(MachineState *machine)
         pci_bus = pci_pmac_init(pic, get_system_memory(), get_system_io());
         machine_arch = ARCH_MAC99;
     }
-    object_property_set_bool(OBJECT(pci_bus), true, "realized", &error_abort);
 
     machine->usb |= defaults_enabled() && !machine->usb_disabled;
 
-- 
2.14.3
