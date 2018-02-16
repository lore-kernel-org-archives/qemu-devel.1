Received: from eggs.gnu.org ([2001:4830:134:3::10]:43040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp8-0002RW-3S
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp6-0007iR-Iq
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1emjp6-0007iC-ED
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16D147D85D
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:29:24 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 16 Feb 2018 18:29:09 +0100
Message-Id: <20180216172910.8549-5-maxime.coquelin@redhat.com>
In-Reply-To: <20180216172910.8549-1-maxime.coquelin@redhat.com>
References: <20180216172910.8549-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [RFC 4/5] vhost-user-blk: send virtio status to the
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/block/vhost-user-blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index b53b4c9c57..a88b6f13a4 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -190,6 +190,7 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
         vhost_user_blk_stop(vdev);
     }
 
+    vhost_dev_set_virtio_status(&s->dev, status);
 }
 
 static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
-- 
2.14.3
