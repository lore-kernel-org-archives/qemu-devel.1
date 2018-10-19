Received: from eggs.gnu.org ([2001:4830:134:3::10]:42990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDE-0003lR-NT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDD-0000F6-E0
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDNDC-00009V-Vl
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id l17-v6so15958946pff.2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:20:38 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Oct 2018 22:20:10 -0700
Message-Id: <1539926412-21831-6-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 5/7] vfio: platform: cleanup the notifier in
 error path
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
index 5992fe7..6a4fd7b 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -80,6 +80,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
         intp->unmask = g_malloc0(sizeof(EventNotifier));
         ret = event_notifier_init(intp->unmask, 0);
         if (ret) {
+            event_notifier_cleanup(intp->interrupt);
             g_free(intp->interrupt);
             g_free(intp->unmask);
             g_free(intp);
-- 
1.8.3.1
