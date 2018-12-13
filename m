Received: from eggs.gnu.org ([2001:4830:134:3::10]:38688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY7E-0001kT-Pn
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY7D-0004kP-0t
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:52 -0500
Received: from trasno.trasno.org ([83.165.45.250]:42324 helo=mail.trasno.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@trasno.org>) id 1gXY7C-0004Ef-O5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:50 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Dec 2018 22:00:57 +0100
Message-Id: <20181213210057.3676-17-quintela@redhat.com>
In-Reply-To: <20181213210057.3676-1-quintela@redhat.com>
References: <20181213210057.3676-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 16/16] virtio: virtio 9p really requires
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
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
2.19.2
