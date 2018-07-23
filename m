Received: from eggs.gnu.org ([2001:4830:134:3::10]:43470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhL9-0004M7-FV
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhL8-0005dn-K3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:55 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:39 -0500
Message-Id: <20180723201748.25573-91-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 90/99] vfio/pci: Default display option to "off"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

Commit a9994687cb9b ("vfio/display: core & wireup") added display
support to vfio-pci with the default being "auto", which breaks
existing VMs when the vGPU requires GL support but had no previous
requirement for a GL compatible configuration.  "Off" is the safer
default as we impose no new requirements to VM configurations.

Fixes: a9994687cb9b ("vfio/display: core & wireup")
Cc: qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
(cherry picked from commit 8151a9c56d31eeeea872b8103c8b86d03c411667)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b9bc6cd310..1a806ea684 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3154,7 +3154,7 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
-                            display, ON_OFF_AUTO_AUTO),
+                            display, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
     DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
-- 
2.17.1
