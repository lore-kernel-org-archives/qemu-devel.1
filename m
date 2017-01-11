Received: from eggs.gnu.org ([2001:4830:134:3::10]:33618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG9A-0001aa-9f
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG99-0003Rb-Fc
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRG99-0003RU-9l
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:47 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7891761B9C
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 10:28:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 11:28:37 +0100
Message-Id: <1484130518-18873-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
References: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] virtio-gpu: tag as not hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

qemu can't hotplug display devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 1483970138-20360-1-git-send-email-kraxel@redhat.com
---
 hw/display/virtio-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index cef736c..7a15c61 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1299,6 +1299,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
 
     dc->props = virtio_gpu_properties;
     dc->vmsd = &vmstate_virtio_gpu;
+    dc->hotpluggable = false;
 }
 
 static const TypeInfo virtio_gpu_info = {
-- 
1.8.3.1
