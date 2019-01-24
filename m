Received: from eggs.gnu.org ([209.51.188.92]:50616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gmgH4-0002T3-Vw
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gmgH1-00052y-IN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:46:33 -0500
From: kumar sourav <sourav.jb1988@gmail.com>
Date: Thu, 24 Jan 2019 20:16:06 +0530
Message-Id: <20190124144606.4352-1-sourav.jb1988@gmail.com>
Subject: [Qemu-devel] [PATCH] hw: edu: set category of the edu device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: jslaby@suse.cz, qemu-devel@nongnu.org, thuth@redhat.com

Sets the category of edu device as DEVICE_CATEGORY_MISC.
Devices should be assigned to one of DEVICE_CATEGORY_XXXX.

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
---
 hw/misc/edu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index ceaf688bfb..91af452c9e 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -399,6 +399,7 @@ static void edu_instance_init(Object *obj)
 
 static void edu_class_init(ObjectClass *class, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
 
     k->realize = pci_edu_realize;
@@ -407,6 +408,7 @@ static void edu_class_init(ObjectClass *class, void *data)
     k->device_id = 0x11e8;
     k->revision = 0x10;
     k->class_id = PCI_CLASS_OTHERS;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static void pci_edu_register_types(void)
-- 
2.17.1
