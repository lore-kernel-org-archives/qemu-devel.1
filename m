Received: from eggs.gnu.org ([2001:4830:134:3::10]:42693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqf-0001VR-Q9
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyne-0007dJ-8y
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuyne-0007d7-4U
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE0F68076895
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:38:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:30 +0200
Message-Id: <20180829113730.14992-17-quintela@redhat.com>
In-Reply-To: <20180829113730.14992-1-quintela@redhat.com>
References: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 16/16] virtio: virtio 9p really requires
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, mst@redhat.com

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
 CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VIRTIO=y
-CONFIG_VIRTIO_9P=y
+CONFIG_VIRTIO_9P=$(CONFIG_VIRTFS)
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_VIRTIO_CRYPTO=y
-- 
2.17.1
