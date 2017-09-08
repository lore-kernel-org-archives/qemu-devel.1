Received: from eggs.gnu.org ([2001:4830:134:3::10]:49125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7z-0006je-6A
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7y-00055s-EZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK7y-00055B-8I
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:26 -0400
Date: Fri, 8 Sep 2017 17:19:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-12-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 11/17] acpi/vmgenid: change device category to
 misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yoni Bettan <ybettan@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

From: Yoni Bettan <ybettan@redhat.com>

Moved vmgenid from uncategorized to misc category in QEMU help menu

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/vmgenid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index a32b847..876723a 100644
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
MST
