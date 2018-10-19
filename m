Received: from eggs.gnu.org ([2001:4830:134:3::10]:43045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDG-0003mh-9w
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDF-0000Jb-DY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDNDF-0000Go-0T
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:41 -0400
Received: by mail-pf1-x442.google.com with SMTP id r64-v6so15939904pfb.13
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:20:40 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Oct 2018 22:20:11 -0700
Message-Id: <1539926412-21831-7-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 6/7] vfio: platform: free timer in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/vfio/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 6a4fd7b..ba19143 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -518,6 +518,7 @@ static int vfio_populate_device(VFIODevice *vbasedev, Error **errp)
     return 0;
 irq_err:
     timer_del(vdev->mmap_timer);
+    timer_free(vdev->mmap_timer);
     QLIST_FOREACH_SAFE(intp, &vdev->intp_list, next, tmp) {
         QLIST_REMOVE(intp, next);
         g_free(intp);
-- 
1.8.3.1
