Received: from eggs.gnu.org ([2001:4830:134:3::10]:35835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQaQK-0008DV-IN
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQaQJ-00073r-FI
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:55:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQaQJ-00073Q-7z
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:55:43 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3466D44811
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 13:55:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Jan 2017 14:55:38 +0100
Message-Id: <1483970138-20360-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu: tag as not hotpluggable
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
---
 hw/display/virtio-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ca88cf4..f410a3e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1282,6 +1282,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
 
     dc->props = virtio_gpu_properties;
     dc->vmsd = &vmstate_virtio_gpu;
+    dc->hotpluggable = false;
 }
 
 static const TypeInfo virtio_gpu_info = {
-- 
1.8.3.1
