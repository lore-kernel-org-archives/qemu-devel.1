Received: from eggs.gnu.org ([209.51.188.92]:35020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqWIs-0004Sp-Sd
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 23:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqWIq-00067p-Ps
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 23:56:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqWIo-00063L-TI
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 23:56:15 -0500
Date: Sun, 3 Feb 2019 23:56:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204045543.21238-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] fixup: include: update Linux headers to
 4.21-rc1/5.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongji Xie <xieyongji@baidu.com>, Peter Xu <peterx@redhat.com>, pbonzini@redhat.com

This update switched structures from __u64 to uint64_t.
Accordingly, need to print with PRIx64.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index a6b46cdc03..3f14b4138b 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -790,10 +790,10 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("vhost_vring_addr:\n");
     DPRINT("    index:  %d\n", vra->index);
     DPRINT("    flags:  %d\n", vra->flags);
-    DPRINT("    desc_user_addr:   0x%016llx\n", vra->desc_user_addr);
-    DPRINT("    used_user_addr:   0x%016llx\n", vra->used_user_addr);
-    DPRINT("    avail_user_addr:  0x%016llx\n", vra->avail_user_addr);
-    DPRINT("    log_guest_addr:   0x%016llx\n", vra->log_guest_addr);
+    DPRINT("    desc_user_addr:   0x%016" PRIx64 "\n", vra->desc_user_addr);
+    DPRINT("    used_user_addr:   0x%016" PRIx64 "\n", vra->used_user_addr);
+    DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", vra->avail_user_addr);
+    DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", vra->log_guest_addr);
 
     vq->vring.flags = vra->flags;
     vq->vring.desc = qva_to_va(dev, vra->desc_user_addr);
-- 
MST
