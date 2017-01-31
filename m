Received: from eggs.gnu.org ([2001:4830:134:3::10]:38292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYrA-00046N-DT
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYr5-0000fw-9r
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:52:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYYr5-0000fr-4B
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:52:19 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27118274876
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 13:52:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 14:52:06 +0100
Message-Id: <1485870727-21956-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] usb/uas: more verbose error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Print some more details in case we get a unknown
control request, to ease trouble-shooting.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-uas.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 3a8ff18..da2fb70 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -653,7 +653,8 @@ static void usb_uas_handle_control(USBDevice *dev, USBPacket *p,
     if (ret >= 0) {
         return;
     }
-    error_report("%s: unhandled control request", __func__);
+    error_report("%s: unhandled control request (req 0x%x, val 0x%x, idx 0x%x",
+                 __func__, request, value, index);
     p->status = USB_RET_STALL;
 }
 
-- 
1.8.3.1
