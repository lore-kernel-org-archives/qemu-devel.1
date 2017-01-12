Received: from eggs.gnu.org ([2001:4830:134:3::10]:46664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk8-00037c-8g
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk5-0006fS-Jb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:56 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:59 +1100
Message-Id: <20170112020327.24882-40-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 39/67] libqos: fix spapr qpci_map()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/libqos/pci-spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 1e5d015..2043f1e 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -193,8 +193,8 @@ QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
     ret->pio.size = SPAPR_PCI_IO_WIN_SIZE;
 
     /* 32-bit portion of the MMIO window is at PCI address 2..4 GiB */
-    ret->mmio32_cpu_base = SPAPR_PCI_BASE + SPAPR_PCI_MMIO32_WIN_SIZE;
-    ret->mmio32.pci_base = 0x80000000; /* 2 GiB */
+    ret->mmio32_cpu_base = SPAPR_PCI_BASE;
+    ret->mmio32.pci_base = SPAPR_PCI_MMIO32_WIN_SIZE;
     ret->mmio32.size = SPAPR_PCI_MMIO32_WIN_SIZE;
 
     ret->bus.pio_alloc_ptr = 0xc000;
-- 
2.9.3
