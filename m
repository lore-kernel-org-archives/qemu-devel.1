Received: from eggs.gnu.org ([2001:4830:134:3::10]:42989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDE-0003lQ-NL
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDD-0000FT-GD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:40 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDNDD-0008Qq-4L
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id y11-v6so15348814plt.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:20:27 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Oct 2018 22:20:06 -0700
Message-Id: <1539926412-21831-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 1/7] vfio-pci: make "vfio-pci-nohotplug" as
 MACRO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/vfio/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8b73582..1f05b57 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -40,6 +40,8 @@
 #define TYPE_VFIO_PCI "vfio-pci"
 #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
 
+#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
+
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 
@@ -3277,8 +3279,8 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo vfio_pci_nohotplug_dev_info = {
-    .name = "vfio-pci-nohotplug",
-    .parent = "vfio-pci",
+    .name = TYPE_VFIO_PCI_NOHOTPLUG,
+    .parent = TYPE_VFIO_PCI,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_nohotplug_dev_class_init,
 };
-- 
1.8.3.1
