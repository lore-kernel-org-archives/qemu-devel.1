Received: from eggs.gnu.org ([2001:4830:134:3::10]:60082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBzPu-0001BI-S7
	for qemu-devel@nongnu.org; Sat, 20 May 2017 04:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBzPr-0004tS-MV
	for qemu-devel@nongnu.org; Sat, 20 May 2017 04:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dBzPr-0004tC-GV
	for qemu-devel@nongnu.org; Sat, 20 May 2017 04:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92C6E624CC
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 08:07:09 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Sat, 20 May 2017 10:06:58 +0200
Message-Id: <20170520080658.337-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH] vhost_net: do not expose MTU feature bit to
 kernel backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, aconole@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch removes MTU from the list of features supported by
the kernel backend, so that vhost kernel backend does not have
to advertise it to be negotiated.

Cc: Aaron Conole <aconole@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/net/vhost_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 22874a9..bdd8633 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -51,7 +51,6 @@ static const int kernel_feature_bits[] = {
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_F_VERSION_1,
-    VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
     VHOST_INVALID_FEATURE_BIT
 };
-- 
2.9.3
