Received: from eggs.gnu.org ([2001:4830:134:3::10]:50803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1dp9Vg-0004jP-9K
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1dp9VY-0002BI-RE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1dp9VY-0002AH-LW
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 04:46:56 -0400
From: Yoni Bettan <ybettan@redhat.com>
Date: Tue,  5 Sep 2017 11:46:34 +0300
Message-Id: <20170905084634.13182-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH] acpi/vmgenid: change device category to misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, Yoni Bettan <ybettan@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>

Moved vmgenid from uncategorized to misc category in QEMU help menu

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 hw/acpi/vmgenid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index a32b847fe0..876723a4ce 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -240,6 +240,7 @@ static void vmgenid_device_class_init(ObjectClass *klass, void *data)
     dc->realize = vmgenid_realize;
     dc->hotpluggable = false;
     dc->props = vmgenid_properties;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 
     object_class_property_add_str(klass, VMGENID_GUID, NULL,
                                   vmgenid_set_guid, NULL);
-- 
2.13.5
