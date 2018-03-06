Received: from eggs.gnu.org ([2001:4830:134:3::10]:42482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJF6-0000UC-A2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJF5-0005Xr-Jt
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:24 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:30:48 +0000
Message-Id: <20180306203103.25563-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 04/19] uninorth: remove stray PCIBus realize
 from mac_newworld.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

After QOMification this is clearly no longer needed (and possibly hasn't been
for some time).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_newworld.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 1eba79d54b..3410bb13ad 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -351,7 +351,6 @@ static void ppc_core99_init(MachineState *machine)
         pci_bus = pci_pmac_init(pic, get_system_memory(), get_system_io());
         machine_arch = ARCH_MAC99;
     }
-    object_property_set_bool(OBJECT(pci_bus), true, "realized", &error_abort);
 
     machine->usb |= defaults_enabled() && !machine->usb_disabled;
 
-- 
2.11.0
