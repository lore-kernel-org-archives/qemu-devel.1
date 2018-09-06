Received: from eggs.gnu.org ([2001:4830:134:3::10]:41423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxnIo-0008Es-69
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxnIn-0008Uh-CT
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:58:02 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  6 Sep 2018 06:57:36 +0100
Message-Id: <20180906055736.20256-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/3] scsi: remove unused lsi53c895a_create()
 and lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Now that these functions are no longer required they can be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/lsi53c895a.c | 14 --------------
 include/hw/pci/pci.h |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index edb0b13e23..2094b1ebc6 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2162,17 +2162,3 @@ static void lsi53c895a_register_types(void)
 }
 
 type_init(lsi53c895a_register_types)
-
-void lsi53c895a_create(PCIBus *bus)
-{
-    LSIState *s = LSI53C895A(pci_create_simple(bus, -1, "lsi53c895a"));
-
-    scsi_bus_legacy_handle_cmdline(&s->bus);
-}
-
-void lsi53c810_create(PCIBus *bus, int devfn)
-{
-    LSIState *s = LSI53C895A(pci_create_simple(bus, devfn, "lsi53c810"));
-
-    scsi_bus_legacy_handle_cmdline(&s->bus);
-}
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 990d6fcbde..cb9d023f87 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -707,9 +707,6 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
 PCIDevice *pci_create(PCIBus *bus, int devfn, const char *name);
 PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
 
-void lsi53c895a_create(PCIBus *bus);
-void lsi53c810_create(PCIBus *bus, int devfn);
-
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
 
-- 
2.11.0
