Received: from eggs.gnu.org ([209.51.188.92]:36325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gyuwf-00044h-Ew
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gyuwe-0004Bv-CB
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:52:05 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 27 Feb 2019 19:51:44 +1100
Message-Id: <20190227085149.38596-2-aik@ozlabs.ru>
In-Reply-To: <20190227085149.38596-1-aik@ozlabs.ru>
References: <20190227085149.38596-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 1/6] pci: Move NVIDIA vendor id to the
 rest of ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>

sPAPR code will use it too so move it from VFIO to the common code.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/pci/pci_ids.h | 2 ++
 hw/vfio/pci-quirks.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index eeb3301..0abe27a 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -271,4 +271,6 @@
 
 #define PCI_VENDOR_ID_SYNOPSYS           0x16C3
 
+#define PCI_VENDOR_ID_NVIDIA             0x10de
+
 #endif
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index eae31c7..40a1200 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -526,8 +526,6 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *vdev, int nr)
  * note it for future reference.
  */
 
-#define PCI_VENDOR_ID_NVIDIA                    0x10de
-
 /*
  * Nvidia has several different methods to get to config space, the
  * nouveu project has several of these documented here:
-- 
2.17.1
