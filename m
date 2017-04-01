Received: from eggs.gnu.org ([2001:4830:134:3::10]:52079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7D0-0005TD-Aj
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Cy-0007HS-1f
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:48:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7Cx-0007H0-Rd
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:24 -0300
Message-Id: <20170401004624.30886-20-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 19/19] virtio-mmio: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>

virtio-mmio needs to be wired and mapped by other device or board
code, and won't work with -device. Remove the user_creatable flag
from the device class.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/virtio/virtio-mmio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index b595512a3d..5807aa87fe 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -450,11 +450,6 @@ static void virtio_mmio_class_init(ObjectClass *klass, void *data)
     dc->reset = virtio_mmio_reset;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = virtio_mmio_properties;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo virtio_mmio_info = {
-- 
2.11.0.259.g40922b1
