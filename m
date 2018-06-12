Received: from eggs.gnu.org ([2001:4830:134:3::10]:58913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3n-0002k8-GC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3m-0001uH-GQ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:45 +1000
Message-Id: <20180612064503.14282-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/33] ppc: remove obsolete pci_pmac_init()
 definitions from mac.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commits 7b19318bee and 8ce3f743c7 removed the pci_pmac_init() and
pci_pmac_u3_init() functions but missed the header prototypes in mac.h. R=
emove
them since they are no longer needed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 22a7efbed6..dac96317af 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -97,12 +97,6 @@ void macio_init(PCIDevice *dev,
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
=20
-/* UniNorth PCI */
-UNINHostState *pci_pmac_init(qemu_irq *pic,
-                             MemoryRegion *address_space_mem);
-UNINHostState *pci_pmac_u3_init(qemu_irq *pic,
-                                MemoryRegion *address_space_mem);
-
 /* Mac NVRAM */
 #define TYPE_MACIO_NVRAM "macio-nvram"
 #define MACIO_NVRAM(obj) \
--=20
2.17.1
