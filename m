Received: from eggs.gnu.org ([2001:4830:134:3::10]:34413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMsyz-0008F0-RD
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMsyz-0008BS-5Z
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMsyy-0008BJ-W8
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:13 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:55:53 +0800
Message-Id: <1483088160-6714-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 1/8] pci: introduce
 pci_intx_line()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, agordeev@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com

To fetch INTx irq line number.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/pci.c | 5 +++++
 lib/pci.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/lib/pci.c b/lib/pci.c
index 6416191..a7cfacb 100644
--- a/lib/pci.c
+++ b/lib/pci.c
@@ -327,6 +327,11 @@ void pci_scan_bars(struct pci_dev *dev)
 	}
 }
 
+uint8_t pci_intx_line(struct pci_dev *dev)
+{
+	return pci_config_readb(dev->bdf, PCI_INTERRUPT_LINE);
+}
+
 void pci_enable_defaults(struct pci_dev *dev)
 {
 	pci_scan_bars(dev);
diff --git a/lib/pci.h b/lib/pci.h
index e71a05d..df86951 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -64,6 +64,7 @@ extern bool pci_bar_is_memory(struct pci_dev *dev, int bar_num);
 extern bool pci_bar_is_valid(struct pci_dev *dev, int bar_num);
 extern void pci_bar_print(struct pci_dev *dev, int bar_num);
 extern void pci_dev_print_id(pcidevaddr_t dev);
+extern uint8_t pci_intx_line(struct pci_dev *dev);
 
 extern int pci_testdev(void);
 
-- 
2.7.4
