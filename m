Received: from eggs.gnu.org ([2001:4830:134:3::10]:58209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXTR1-0006st-LC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXTQs-0004hS-3n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXTQr-0004gw-U8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 18 Jul 2017 16:24:47 +0200
Message-Id: <20170718142455.32676-2-cohuck@redhat.com>
In-Reply-To: <20170718142455.32676-1-cohuck@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 1/9] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

The msi routing code in kvm calls some pci functions: provide
some stubs to enable builds without pci.

Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/pci/pci-stub.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index ecad664946..bc228ce91e 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -23,6 +23,7 @@
 #include "monitor/monitor.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
 #include "qmp-commands.h"
 #include "hw/pci/msi.h"
 
@@ -38,3 +39,14 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "PCI devices not supported\n");
 }
+
+/* kvm-all wants this */
+MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
+{
+    assert(false);
+}
+
+uint16_t pci_requester_id(PCIDevice *dev)
+{
+    assert(false);
+}
-- 
2.13.3
