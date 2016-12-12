Received: from eggs.gnu.org ([2001:4830:134:3::10]:51601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGa1V-0008P8-Gx
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 18:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGa1U-00072u-Qq
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 18:28:45 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 13 Dec 2016 00:28:35 +0100
Message-Id: <1481585316-31612-4-git-send-email-lvivier@redhat.com>
In-Reply-To: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
References: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] libqos: fix spapr qpci_map()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
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
2.7.4
