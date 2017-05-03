Received: from eggs.gnu.org ([2001:4830:134:3::10]:54826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611p-0003Ns-Hk
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d611n-0003Bf-PA
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d611n-0003AK-KM
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:37:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 May 2017 17:36:02 -0300
Message-Id: <20170503203604.31462-20-ehabkost@redhat.com>
In-Reply-To: <20170503203604.31462-1-ehabkost@redhat.com>
References: <20170503203604.31462-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND v2 19/21] virtio-mmio: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>

virtio-mmio needs to be wired and mapped by other device or board
code, and won't work with -device. Remove the user_creatable flag
from the device class.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 hw/virtio/virtio-mmio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 6491a771ff..5807aa87fe 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -450,11 +450,6 @@ static void virtio_mmio_class_init(ObjectClass *klass, void *data)
     dc->reset = virtio_mmio_reset;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = virtio_mmio_properties;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo virtio_mmio_info = {
-- 
2.11.0.259.g40922b1
