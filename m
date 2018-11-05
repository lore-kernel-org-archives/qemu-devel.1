Received: from eggs.gnu.org ([2001:4830:134:3::10]:60708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQt-00085z-4N
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQs-0003Nj-8t
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQs-0003N3-20
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:02 -0500
Date: Mon, 5 Nov 2018 13:17:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-29-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/33] hw/pci: Add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Noted while refactoring:

      CC      mips-softmmu/hw/mips/gt64xxx_pci.o
    In file included from include/hw/pci-host/gt64xxx.h:2,
                     from hw/mips/gt64xxx_pci.c:30:
    include/hw/pci/pci_bus.h:23:5: error: unknown type name =E2=80=98PCII=
OMMUFunc=E2=80=99
         PCIIOMMUFunc iommu_fn;
         ^~~~~~~~~~~~
    include/hw/pci/pci_bus.h:27:5: error: unknown type name =E2=80=98pci_=
set_irq_fn=E2=80=99
         pci_set_irq_fn set_irq;
         ^~~~~~~~~~~~~~
    include/hw/pci/pci_bus.h:28:5: error: unknown type name =E2=80=98pci_=
map_irq_fn=E2=80=99
         pci_map_irq_fn map_irq;
         ^~~~~~~~~~~~~~
    include/hw/pci/pci_bus.h:29:5: error: unknown type name =E2=80=98pci_=
route_irq_fn=E2=80=99
         pci_route_irq_fn route_intx_to_irq;
         ^~~~~~~~~~~~~~~~
    include/hw/pci/pci_bus.h:31:24: error: =E2=80=98PCI_SLOT_MAX=E2=80=99=
 undeclared here (not in a function)
         PCIDevice *devices[PCI_SLOT_MAX * PCI_FUNC_MAX];
                            ^~~~~~~~~~~~
    include/hw/pci/pci_bus.h:31:39: error: =E2=80=98PCI_FUNC_MAX=E2=80=99=
 undeclared here (not in a function)
         PCIDevice *devices[PCI_SLOT_MAX * PCI_FUNC_MAX];
                                           ^~~~~~~~~~~~
    make[1]: *** [rules.mak:69: hw/mips/gt64xxx_pci.o] Error 1
    make: *** [Makefile:482: subdir-mips-softmmu] Error 2

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
=20
+#include "hw/pci/pci.h"
+
 /*
  * PCI Bus datastructures.
  *
--=20
MST
