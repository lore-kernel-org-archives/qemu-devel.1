Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fNgOF-0006wC-Nc
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fNgOB-0001Eg-N9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:18:23 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 29 May 2018 09:18:10 -0600
Message-ID: <20180529151753.22912.14813.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vfio/pci: Default display option to "off"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Commit a9994687cb9b ("vfio/display: core & wireup") added display
support to vfio-pci with the default being "auto", which breaks
existing VMs when the vGPU requires GL support but had no previous
requirement for a GL compatible configuration.  "Off" is the safer
default as we impose no new requirements to VM configurations.

Fixes: a9994687cb9b ("vfio/display: core & wireup")
Cc: qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 84e27c7bb2d1..18c493b49ec1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3160,7 +3160,7 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
-                            display, ON_OFF_AUTO_AUTO),
+                            display, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
     DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
