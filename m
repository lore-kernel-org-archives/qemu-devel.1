Received: from eggs.gnu.org ([209.51.188.92]:56212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpM-0008Iw-1f
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpK-0008H6-R8
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPpJ-0007cc-SQ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:10 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:46 +0100
Message-Id: <20190220111346.13669-10-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] usb: remove unnecessary NULL device check
 from usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Liam Merwick <liam.merwick@oracle.com>

From: Liam Merwick <liam.merwick@oracle.com>

No caller of usb_ep_get() calls it with a NULL device (previous commits
have addressed the few remaining cases which didn't explicitly check).
Replace check for 'dev == NULL' with an assert instead.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-id: 1549460216-25808-10-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index bfb7ae67bb..8fbd9c7d57 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -717,9 +717,7 @@ struct USBEndpoint *usb_ep_get(USBDevice *dev, int pid, int ep)
 {
     struct USBEndpoint *eps;
 
-    if (dev == NULL) {
-        return NULL;
-    }
+    assert(dev != NULL);
     if (ep == 0) {
         return &dev->ep_ctl;
     }
-- 
2.9.3
