Received: from eggs.gnu.org ([2001:4830:134:3::10]:52009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnA-0001fB-T8
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnA-00049q-2V
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxn9-00049I-St
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:48 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:00 +0100
Message-Id: <20170824192730.8440-3-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 02/32] vhub: Only process received packets on
 started queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Only process received packets if the queue has been started.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/vhost-user-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 1e5b5ca3da..324abee53d 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -277,6 +277,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
     DPRINT("    hdrlen = %d\n", hdrlen);
 
     if (!vu_queue_enabled(dev, vq) ||
+        !vu_queue_started(dev, vq) ||
         !vu_queue_avail_bytes(dev, vq, hdrlen, 0)) {
         DPRINT("Got UDP packet, but no available descriptors on RX virtq.\n");
         return;
-- 
2.13.5
