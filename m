Received: from eggs.gnu.org ([2001:4830:134:3::10]:49899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1ca1sQ-0004vp-0Q
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1ca1sM-0005JO-V9
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:03:46 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fabian@lesniak-it.de>)
	id 1ca1sM-0005Hy-Ki
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:03:42 -0500
From: Fabian Lesniak <fabian@lesniak-it.de>
Date: Sat,  4 Feb 2017 16:03:19 +0100
Message-Id: <20170204150319.8907-1-fabian@lesniak-it.de>
Subject: [Qemu-devel] [PATCH] ps2: fix mouse mappings for right/middle button
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Fabian Lesniak <fabian@lesniak-it.de>

Commit 8b0caab0 ("ps2: add support for mice with extra/side buttons")
accidentally swapped right and middle mouse buttons. This commit corrects
the mapping as expected by the ps2 controller.

Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
---
 include/hw/input/ps2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index 0fec91cdb0..7f0a80af9d 100644
--- a/include/hw/input/ps2.h
+++ b/include/hw/input/ps2.h
@@ -26,8 +26,8 @@
 #define HW_PS2_H
 
 #define PS2_MOUSE_BUTTON_LEFT   0x01
-#define PS2_MOUSE_BUTTON_MIDDLE 0x02
-#define PS2_MOUSE_BUTTON_RIGHT  0x04
+#define PS2_MOUSE_BUTTON_RIGHT  0x02
+#define PS2_MOUSE_BUTTON_MIDDLE 0x04
 #define PS2_MOUSE_BUTTON_SIDE   0x08
 #define PS2_MOUSE_BUTTON_EXTRA  0x10
 
-- 
2.11.1
