Received: from eggs.gnu.org ([2001:4830:134:3::10]:54944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQIEW-0003vG-CJ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQIES-0003M2-Th
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:07:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fQIES-0003Ky-L9
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:07:04 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A16C30A8389
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 20:07:03 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 05 Jun 2018 14:07:00 -0600
Message-ID: <20180605200700.24323.45867.stgit@gimli.home>
In-Reply-To: <20180605200425.24323.56023.stgit@gimli.home>
References: <20180605200425.24323.56023.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 6/6] vfio/pci: Default display option to "off"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
