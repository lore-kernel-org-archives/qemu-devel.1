Received: from eggs.gnu.org ([209.51.188.92]:36781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjDjd-0007oY-Gl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjDer-0008Q8-0W
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:36:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjDeq-0008Nf-Nk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:36:48 -0500
Date: Mon, 14 Jan 2019 20:36:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115003812.11329-34-mst@redhat.com>
References: <20190115003812.11329-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115003812.11329-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 33/44] virtio: virtio 9p really requires
 CONFIG_VIRTFS to work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 default-configs/virtio.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index 5ae4a61018..ecb4420e74 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -1,7 +1,7 @@
 CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VIRTIO=y
-CONFIG_VIRTIO_9P=y
+CONFIG_VIRTIO_9P=$(CONFIG_VIRTFS)
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_VIRTIO_CRYPTO=y
-- 
MST
