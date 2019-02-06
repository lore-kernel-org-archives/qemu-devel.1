Received: from eggs.gnu.org ([209.51.188.92]:58723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOl-0005Uu-1w
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOg-0003sJ-97
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNOd-0003nD-9H
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:47 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:56 +0000
Message-Id: <1549460216-25808-10-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 9/9] usb: remove unnecessary NULL device
 check from usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, darren.kenny@oracle.com

No caller of usb_ep_get() calls it with a NULL device (previous commits
have addressed the few remaining cases which didn't explicitly check).
Replace check for 'dev == NULL' with an assert instead.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/usb/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index bfb7ae67bbf0..8fbd9c7d573b 100644
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
1.8.3.1
