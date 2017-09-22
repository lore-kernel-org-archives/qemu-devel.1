Received: from eggs.gnu.org ([2001:4830:134:3::10]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4e-0004br-Lz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4d-0003CU-SP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:49 -0300
Message-Id: <20170922154014.29350-10-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/34] misc: avoid "include/" in include path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

while here, remove unused #include from aspeed_smc.h

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/input/adb.c      | 2 +-
 hw/ssi/aspeed_smc.c | 3 +--
 numa.c              | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index fcca3a8eb9..924a3f9fd5 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -24,8 +24,8 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/input/adb.h"
+#include "hw/input/adb-keys.h"
 #include "ui/console.h"
-#include "include/hw/input/adb-keys.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index cb515730c5..5059396bc6 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -26,8 +26,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
-#include "include/qemu/error-report.h"
-#include "exec/address-spaces.h"
+#include "qemu/error-report.h"
 
 #include "hw/ssi/aspeed_smc.h"
 
diff --git a/numa.c b/numa.c
index 100a67febf..ebc553b5d9 100644
--- a/numa.c
+++ b/numa.c
@@ -29,7 +29,6 @@
 #include "qemu/bitmap.h"
 #include "qom/cpu.h"
 #include "qemu/error-report.h"
-#include "include/exec/cpu-common.h" /* for RAM_ADDR_FMT */
 #include "qapi-visit.h"
 #include "qapi/opts-visitor.h"
 #include "hw/boards.h"
-- 
2.14.1
