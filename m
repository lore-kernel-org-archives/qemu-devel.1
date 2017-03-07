Received: from eggs.gnu.org ([2001:4830:134:3::10]:34775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clAfU-0004ZY-J1
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clAfR-00035w-Fl
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:40:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  7 Mar 2017 09:40:18 +0100
Message-Id: <1488876018-31576-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ohci: relax link check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com, hsp.cat7@gmail.com, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

The strict td link limit added by commit "95ed569 usb: ohci: limit the
number of link eds" causes problems with macos guests.  Lets raise the
limit.

Reported-by: Programmingkid <programmingkidx@gmail.com>
Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index fe8406a..3ada35e 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -42,7 +42,7 @@
 
 #define OHCI_MAX_PORTS 15
 
-#define ED_LINK_LIMIT 4
+#define ED_LINK_LIMIT 32
 
 static int64_t usb_frame_time;
 static int64_t usb_bit_time;
-- 
1.8.3.1
