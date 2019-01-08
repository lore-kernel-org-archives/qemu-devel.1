Received: from eggs.gnu.org ([209.51.188.92]:58124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08y-00068A-Lt
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08t-0006kv-7s
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:42 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:49 +1100
Message-Id: <20190108224600.23125-19-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/29] spapr_pci: Define SPAPR_MAX_PHBS in
 hw/pci-host/spapr.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

PHB hotplug will bring more users for it. Let's define it along with
the PHB defines from which it is derived for simplicity.

While here fix a misleading comment about manual placement, which was
abandoned with 30b3bc5aa9f4.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 2 --
 include/hw/pci-host/spapr.h | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f621032d40..75164ba4fc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3840,8 +3840,6 @@ static void spapr_phb_placement(sPAPRMachineState *=
spapr, uint32_t index,
      * 1TiB 64-bit MMIO windows for each PHB.
      */
     const uint64_t base_buid =3D 0x800000020000000ULL;
-#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
-                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
     int i;
=20
     /* Sanity check natural alignments */
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index a65cfef169..4eb3a2ce3e 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -94,11 +94,13 @@ struct sPAPRPHBState {
     ((1ULL << 32) - SPAPR_PCI_MEM_WIN_BUS_OFFSET)
 #define SPAPR_PCI_MEM64_WIN_SIZE     0x10000000000ULL /* 1 TiB */
=20
-/* Without manual configuration, all PCI outbound windows will be
- * within this range */
+/* All PCI outbound windows will be within this range */
 #define SPAPR_PCI_BASE               (1ULL << 45) /* 32 TiB */
 #define SPAPR_PCI_LIMIT              (1ULL << 46) /* 64 TiB */
=20
+#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
+                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
+
 #define SPAPR_PCI_2_7_MMIO_WIN_SIZE  0xf80000000
 #define SPAPR_PCI_IO_WIN_SIZE        0x10000
=20
--=20
2.20.1
