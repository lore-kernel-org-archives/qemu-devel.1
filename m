Received: from eggs.gnu.org ([2001:4830:134:3::10]:54392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHzK-0006Bu-3K
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHzJ-0002hf-Ba
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZHzJ-0002gv-3m
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:53 -0500
Date: Tue, 18 Dec 2018 11:12:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-17-mst@redhat.com>
References: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 16/30] vfio/pci: Remove PCIe Link Status
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Geoffrey McRae <geoff@hostfission.com>, Eric Auger <eric.auger@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

Now that the downstream port will virtually negotiate itself to the
link status of the downstream device, we can remove this emulation.
It's not clear that it was every terribly useful anyway.

Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 74f9a46b4b..c0cb1ec289 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1901,12 +1901,6 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                            QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
             vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
         }
-
-        /* Mark the Link Status bits as emulated to allow virtual negotiation */
-        vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKSTA,
-                               pci_get_word(vdev->pdev.config + pos +
-                                            PCI_EXP_LNKSTA),
-                               PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
     }
 
     /*
-- 
MST
