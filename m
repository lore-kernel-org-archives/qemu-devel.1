Received: from eggs.gnu.org ([2001:4830:134:3::10]:41709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ50-0004zb-7o
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4x-0003Nw-4t
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:55 -0300
Message-Id: <20170922154014.29350-16-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/34] hw/i2c: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i2c/pm_smbus.c   | 1 -
 hw/i2c/smbus_ich9.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 6fc3923f56..a044dd1b27 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -19,7 +19,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/i2c/smbus.h"
 
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index ea51e09186..082cdecba9 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -26,7 +26,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
 #include "sysemu/sysemu.h"
-- 
2.14.1
