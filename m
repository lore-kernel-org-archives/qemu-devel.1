Received: from eggs.gnu.org ([2001:4830:134:3::10]:57926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQh-00018u-J5
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQg-00019z-Pg
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQg-00019F-Fy
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id 185-v6so7298261wmt.2
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:54:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 Oct 2018 23:53:55 +0200
Message-Id: <20181010215355.16221-4-f4bug@amsat.org>
In-Reply-To: <20181010215355.16221-1-f4bug@amsat.org>
References: <20181010215355.16221-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] hw/pci: Add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Noted while refactoring:

      CC      mips-softmmu/hw/mips/gt64xxx_pci.o
    In file included from include/hw/pci-host/gt64xxx.h:2,
                     from hw/mips/gt64xxx_pci.c:30:
    include/hw/pci/pci_bus.h:23:5: error: unknown type name ‘PCIIOMMUFunc’
         PCIIOMMUFunc iommu_fn;
         ^~~~~~~~~~~~
    include/hw/pci/pci_bus.h:27:5: error: unknown type name ‘pci_set_irq_fn’
         pci_set_irq_fn set_irq;
         ^~~~~~~~~~~~~~
    include/hw/pci/pci_bus.h:28:5: error: unknown type name ‘pci_map_irq_fn’
         pci_map_irq_fn map_irq;
         ^~~~~~~~~~~~~~
    include/hw/pci/pci_bus.h:29:5: error: unknown type name ‘pci_route_irq_fn’
         pci_route_irq_fn route_intx_to_irq;
         ^~~~~~~~~~~~~~~~
    include/hw/pci/pci_bus.h:31:24: error: ‘PCI_SLOT_MAX’ undeclared here (not in a function)
         PCIDevice *devices[PCI_SLOT_MAX * PCI_FUNC_MAX];
                            ^~~~~~~~~~~~
    include/hw/pci/pci_bus.h:31:39: error: ‘PCI_FUNC_MAX’ undeclared here (not in a function)
         PCIDevice *devices[PCI_SLOT_MAX * PCI_FUNC_MAX];
                                           ^~~~~~~~~~~~
    make[1]: *** [rules.mak:69: hw/mips/gt64xxx_pci.o] Error 1
    make: *** [Makefile:482: subdir-mips-softmmu] Error 2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/pci/pci_bus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index b7da8f555b..dfb75752cb 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_PCI_BUS_H
 #define QEMU_PCI_BUS_H
 
+#include "hw/pci/pci.h"
+
 /*
  * PCI Bus datastructures.
  *
-- 
2.19.1
