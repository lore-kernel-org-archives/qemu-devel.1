Received: from eggs.gnu.org ([2001:4830:134:3::10]:52729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5g-0007JH-9X
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5e-0008GI-LZ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN5e-0008G0-E9
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F4B3308124B
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:02:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 21:00:09 +0100
Message-Id: <20181126200009.862-17-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/16] virtio: virtio 9p really requires
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Otherwise, it has no implementation.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 default-configs/virtio.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index 5ae4a61018..ecb4420e74 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -1,7 +1,7 @@
 CONFIG_VHOST_USER_SCSI=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX=
))
 CONFIG_VHOST_USER_BLK=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)=
)
 CONFIG_VIRTIO=3Dy
-CONFIG_VIRTIO_9P=3Dy
+CONFIG_VIRTIO_9P=3D$(CONFIG_VIRTFS)
 CONFIG_VIRTIO_BALLOON=3Dy
 CONFIG_VIRTIO_BLK=3Dy
 CONFIG_VIRTIO_CRYPTO=3Dy
--=20
2.19.1
