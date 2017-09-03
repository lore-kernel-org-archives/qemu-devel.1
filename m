Received: from eggs.gnu.org ([2001:4830:134:3::10]:43273)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1doY3H-0002WQ-GI
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 12:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1doY3C-00024V-Sj
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 12:47:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:61276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1doY3C-00023x-Jc
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 12:47:10 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Sun,  3 Sep 2017 18:34:55 +0200
Message-Id: <20170903163455.15132-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] usb-mtp: Add fallback definition of NAME_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Kamil Rytarowski <n54@gmx.com>

This fixes build on SmartOS (Joyent).

Patch cherry-picked from pkgsrc by jperkin (Joyent).

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 hw/usb/dev-mtp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 94c2e94f10..6e8d7b21b5 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -26,6 +26,10 @@
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 
+#ifndef NAME_MAX
+#define NAME_MAX 255
+#endif
+
 /* ----------------------------------------------------------------------- */
 
 enum mtp_container_type {
-- 
2.14.1
