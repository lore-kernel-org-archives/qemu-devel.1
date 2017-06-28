Received: from eggs.gnu.org ([2001:4830:134:3::10]:40957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEq-0005Yv-7e
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEp-0000Fg-ID
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIEp-0000FK-Cz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:55 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:43 +0100
Message-Id: <20170628190047.26159-26-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 25/29] vhu: enable = false on get_vring_base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When we receive a GET_VRING_BASE message set enable = false
to stop any new received packets modifying the ring.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index ceddeac74f..d37052b7b0 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -652,6 +652,7 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     vmsg->size = sizeof(vmsg->payload.state);
 
     dev->vq[index].started = false;
+    dev->vq[index].enable = false;
     if (dev->iface->queue_set_started) {
         dev->iface->queue_set_started(dev, index, false);
     }
-- 
2.13.0
