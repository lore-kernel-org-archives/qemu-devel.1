Received: from eggs.gnu.org ([2001:4830:134:3::10]:53526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQQN-0007vm-T6
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQQI-0001Iq-W0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:03:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:11 -0300
Message-Id: <20170922160111.31885-12-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 34/34] misc: drop old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

while here, add an entry for wdt_ib700 in MAINTAINERS

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/debugcon.c      | 1 -
 hw/intc/lm32_pic.c      | 1 -
 hw/moxie/moxiesim.c     | 1 -
 hw/sparc/sun4m.c        | 1 -
 hw/watchdog/wdt_ib700.c | 1 -
 MAINTAINERS             | 1 +
 6 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 95ccec6f8b..e2abc61b04 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -29,7 +29,6 @@
 #include "hw/hw.h"
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
-#include "hw/i386/pc.h"
 
 #define TYPE_ISA_DEBUGCON_DEVICE "isa-debugcon"
 #define ISA_DEBUGCON_DEVICE(obj) \
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index 09e15115fb..db6c7afc2f 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
 #include "trace.h"
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 5ea8dd3a93..5c9a4211ac 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -30,7 +30,6 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a4ba3d2917..f6fda6eb13 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -36,7 +36,6 @@
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/scsi/esp.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "hw/nvram/sun_nvram.h"
 #include "hw/nvram/chrp_nvram.h"
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index 532afe89e7..d045032bf4 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -25,7 +25,6 @@
 #include "sysemu/watchdog.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
-#include "hw/i386/pc.h"
 
 /*#define IB700_DEBUG 1*/
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 37917af0f0..3b767e4012 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -852,6 +852,7 @@ F: hw/misc/pc-testdev.c
 F: hw/timer/hpet*
 F: hw/timer/i8254*
 F: hw/timer/mc146818rtc*
+F: hw/watchdog/wdt_ib700.c
 F: include/hw/dma/i8257_dma.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/input/i8042.h
-- 
2.14.1
