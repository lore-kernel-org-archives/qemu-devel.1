Received: from eggs.gnu.org ([2001:4830:134:3::10]:36594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfmNr-0000pH-Hp
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfmNo-0006Pk-P8
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cfmNo-0006PK-Iu
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:43:56 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Feb 2017 12:43:50 +0100
Message-Id: <1487591031-28991-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487591031-28991-1-git-send-email-kraxel@redhat.com>
References: <1487591031-28991-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] ps2: fix mouse mappings for right/middle
 button
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fabian Lesniak <fabian@lesniak-it.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Fabian Lesniak <fabian@lesniak-it.de>

Commit 8b0caab0 ("ps2: add support for mice with extra/side buttons")
accidentally swapped right and middle mouse buttons. This commit corrects
the mapping as expected by the ps2 controller.

Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
Message-id: 20170204150319.8907-1-fabian@lesniak-it.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/input/ps2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index 0fec91c..7f0a80a 100644
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
1.8.3.1
