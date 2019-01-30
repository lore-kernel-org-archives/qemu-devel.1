Received: from eggs.gnu.org ([209.51.188.92]:36822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppp-0001TO-8Q
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppl-0006Ty-I8
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:21 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 30 Jan 2019 14:22:02 +0100
Message-Id: <20190130132214.25493-2-laurent@vivier.eu>
In-Reply-To: <20190130132214.25493-1-laurent@vivier.eu>
References: <20190130132214.25493-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/13] hw: edu: set category of the edu device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Hajnoczi <stefanha@redhat.com>, Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, kumar sourav <sourav.jb1988@gmail.com>, Thomas Huth <thuth@redhat.com>

From: kumar sourav <sourav.jb1988@gmail.com>

Sets the category of edu device as DEVICE_CATEGORY_MISC.
Devices should be assigned to one of DEVICE_CATEGORY_XXXX.

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190124144606.4352-1-sourav.jb1988@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
2.20.1
