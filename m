Received: from eggs.gnu.org ([2001:4830:134:3::10]:42138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS8Ho-0000fZ-5y
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS8Hl-0000Q2-2q
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS8Hk-0000PR-Tq
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:21:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CF22883BC
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 21:21:48 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 21 Dec 2017 22:21:21 +0100
Message-Id: <20171221212125.19075-2-maxime.coquelin@redhat.com>
In-Reply-To: <20171221212125.19075-1-maxime.coquelin@redhat.com>
References: <20171221212125.19075-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/5] vhost-user-test: fix features mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

VIRTIO_NET_F_MAC is a bit position, not a bit mask.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 tests/vhost-user-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index e2c89ed376..43c6528644 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -177,7 +177,7 @@ static void init_virtio_dev(TestServer *s)
     qvirtio_set_driver(&dev->vdev);
 
     features = qvirtio_get_features(&dev->vdev);
-    features = features & VIRTIO_NET_F_MAC;
+    features = features & (1u << VIRTIO_NET_F_MAC);
     qvirtio_set_features(&dev->vdev, features);
 
     qvirtio_set_driver_ok(&dev->vdev);
-- 
2.14.3
