Received: from eggs.gnu.org ([2001:4830:134:3::10]:33479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sz-0000rY-0U
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sv-00069j-Tr
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg6sv-00069J-OE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:25 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E14E28047A
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 09:37:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 10:37:18 +0100
Message-Id: <1487669841-13668-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
References: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] virtio-gpu: use dpy_gl_scanout_disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu-3d.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index b526b3f..f49b7fe 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -185,8 +185,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
         if (ss.scanout_id != 0) {
             dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, NULL);
         }
-        dpy_gl_scanout_texture(g->scanout[ss.scanout_id].con, 0, false,
-                               0, 0, 0, 0, 0, 0);
+        dpy_gl_scanout_disable(g->scanout[ss.scanout_id].con);
     }
     g->scanout[ss.scanout_id].resource_id = ss.resource_id;
 }
@@ -597,7 +596,7 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
         if (i != 0) {
             dpy_gfx_replace_surface(g->scanout[i].con, NULL);
         }
-        dpy_gl_scanout_texture(g->scanout[i].con, 0, false, 0, 0, 0, 0, 0, 0);
+        dpy_gl_scanout_disable(g->scanout[i].con);
     }
 }
 
-- 
1.8.3.1
