Received: from eggs.gnu.org ([2001:4830:134:3::10]:50237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rIp-0004AC-DS
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rIo-0008QZ-Ma
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:27 -0300
Message-Id: <20180415234307.28132-2-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 01/41] hw: Clean "hw/devices.h" includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/devices.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/hw/devices.h b/include/hw/devices.h
index 861ddea8af..0e27feb0c2 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -1,13 +1,10 @@
 #ifndef QEMU_DEVICES_H
 #define QEMU_DEVICES_H
 
-#include "hw/irq.h"
-
-/* ??? Not all users of this file can include cpu-common.h.  */
-struct MemoryRegion;
-
 /* Devices that have nowhere better to go.  */
 
+#include "hw/hw.h"
+
 /* smc91c111.c */
 void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
 
-- 
2.17.0
