Received: from eggs.gnu.org ([2001:4830:134:3::10]:60391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyGK6-0000bz-3h
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyGK4-0007XV-UA
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:57:17 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Sep 2018 13:56:51 +0100
Message-Id: <20180907125653.5010-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
References: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 1/3] scsi: add
 lsi53c8xx_handle_legacy_cmdline() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is the function that will soon be used to replace lsi53c895a_create() and
lsi53c810_create().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/lsi53c895a.c | 7 +++++++
 include/hw/pci/pci.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 955ba94800..8f5ab82d57 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2290,3 +2290,10 @@ void lsi53c810_create(PCIBus *bus, int devfn)
 
     scsi_bus_legacy_handle_cmdline(&s->bus);
 }
+
+void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev)
+{
+    LSIState *s = LSI53C895A(lsi_dev);
+
+    scsi_bus_legacy_handle_cmdline(&s->bus);
+}
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 990d6fcbde..0d907dc084 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -709,6 +709,7 @@ PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
 
 void lsi53c895a_create(PCIBus *bus);
 void lsi53c810_create(PCIBus *bus, int devfn);
+void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
 
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
-- 
2.11.0
