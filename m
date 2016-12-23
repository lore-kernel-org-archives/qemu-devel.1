Received: from eggs.gnu.org ([2001:4830:134:3::10]:44174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cKFL4-0002er-8k
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 21:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cKFL1-0002eP-0I
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 21:12:06 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Fri, 23 Dec 2016 10:16:30 +0800
Message-ID: <1482459390-14386-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] pcie: remove duplicate assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, qemu-trivial@nongnu.org

"size >= 8" connote "size > 0"

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/pci/pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 39b10b852d91..f864c5cd5458 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -668,7 +668,6 @@ void pcie_add_capability(PCIDevice *dev,
     uint16_t next;
 
     assert(offset >= PCI_CONFIG_SPACE_SIZE);
-    assert(offset < offset + size);
     assert(offset + size <= PCIE_CONFIG_SPACE_SIZE);
     assert(size >= 8);
     assert(pci_is_express(dev));
-- 
2.1.0
