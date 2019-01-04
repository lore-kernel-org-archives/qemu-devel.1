Received: from eggs.gnu.org ([208.118.235.92]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfQzj-0006Ao-Dm
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfQzi-0001A8-MF
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:02:43 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  4 Jan 2019 16:02:26 +0100
Message-Id: <1546614146-10525-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/audio/marvell: Don't include unnecessary
 i2c.h header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org

This device does not use I2C, so no need to include the header file here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/audio/marvell_88w8618.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 6600ab4..035dd76 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
-#include "hw/i2c/i2c.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 #include "qapi/error.h"
-- 
1.8.3.1
