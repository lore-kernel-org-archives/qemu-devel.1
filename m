Received: from eggs.gnu.org ([209.51.188.92]:54653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzSN-0001SA-L0
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzSM-00089n-FG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:15 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:54:16 +0200
Message-Id: <20190412165416.7977-13-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/12] hw/devices: Move SMSC 91C111
 declaration into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jason Wang <jasowang@redhat.com>

This commit finally deletes "hw/devices.h".

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/gumstix.c           |  2 +-
 hw/arm/integratorcp.c      |  2 +-
 hw/arm/mainstone.c         |  2 +-
 hw/arm/realview.c          |  2 +-
 hw/arm/versatilepb.c       |  2 +-
 hw/net/smc91c111.c         |  2 +-
 include/hw/devices.h       | 11 -----------
 include/hw/net/smc91c111.h | 19 +++++++++++++++++++
 8 files changed, 25 insertions(+), 17 deletions(-)
 delete mode 100644 include/hw/devices.h
 create mode 100644 include/hw/net/smc91c111.h

diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 79886ce3787..343cbfd7da8 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -40,7 +40,7 @@
 #include "hw/arm/pxa.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
-#include "hw/devices.h"
+#include "hw/net/smc91c111.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 4eceebb9ea7..0b6f24465e4 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -12,10 +12,10 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/devices.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
 #include "hw/misc/arm_integrator_debug.h"
+#include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index e96738ad267..c1cec590379 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -18,7 +18,7 @@
 #include "hw/arm/pxa.h"
 #include "hw/arm/arm.h"
 #include "net/net.h"
-#include "hw/devices.h"
+#include "hw/net/smc91c111.h"
 #include "hw/boards.h"
 #include "hw/block/flash.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index e9983c87639..05a244df255 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -14,8 +14,8 @@
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
-#include "hw/devices.h"
 #include "hw/net/lan9118.h"
+#include "hw/net/smc91c111.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index d67181810a6..25166e15171 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -13,7 +13,7 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
+#include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 99da2d92973..d19ea0750d3 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
-#include "hw/devices.h"
+#include "hw/net/smc91c111.h"
 #include "qemu/log.h"
 /* For crc32 */
 #include <zlib.h>
diff --git a/include/hw/devices.h b/include/hw/devices.h
deleted file mode 100644
index ebc45c87997..00000000000
--- a/include/hw/devices.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef QEMU_DEVICES_H
-#define QEMU_DEVICES_H
-
-/* Devices that have nowhere better to go.  */
-
-#include "hw/hw.h"
-
-/* smc91c111.c */
-void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
-
-#endif
diff --git a/include/hw/net/smc91c111.h b/include/hw/net/smc91c111.h
new file mode 100644
index 00000000000..a66ba4112f8
--- /dev/null
+++ b/include/hw/net/smc91c111.h
@@ -0,0 +1,19 @@
+/*
+ * SMSC 91C111 Ethernet interface emulation
+ *
+ * Copyright (c) 2005 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_NET_SMC91C111_H
+#define HW_NET_SMC91C111_H
+
+#include "hw/irq.h"
+#include "net/net.h"
+
+void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
+
+#endif
--=20
2.20.1
