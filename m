Received: from eggs.gnu.org ([2001:4830:134:3::10]:43105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDI-0003p0-Qp
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDD-0000Do-1V
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:44 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDNDC-00008u-Jo
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id c25-v6so15957053pfe.6
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:20:36 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Oct 2018 22:20:09 -0700
Message-Id: <1539926412-21831-5-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 4/7] vfio: paltform: fix a typo
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
 hw/vfio/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ba03dcd..5992fe7 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -72,7 +72,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
         g_free(intp->interrupt);
         g_free(intp);
         error_setg_errno(errp, -ret,
-                         "failed to initialize trigger eventd notifier");
+                         "failed to initialize trigger eventfd notifier");
         return NULL;
     }
     if (vfio_irq_is_automasked(intp)) {
@@ -84,7 +84,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
             g_free(intp->unmask);
             g_free(intp);
             error_setg_errno(errp, -ret,
-                             "failed to initialize resample eventd notifier");
+                             "failed to initialize resample eventfd notifier");
             return NULL;
         }
     }
-- 
1.8.3.1
