Received: from eggs.gnu.org ([209.51.188.92]:54546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzSD-0001JG-R8
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzSA-0007ke-3h
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:04 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:54:13 +0200
Message-Id: <20190412165416.7977-10-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
References: <20190412165416.7977-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/12] hw/devices: Move LAN9118 declarations
 into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/kzm.c             |  2 +-
 hw/arm/mps2.c            |  2 +-
 hw/arm/realview.c        |  1 +
 hw/arm/vexpress.c        |  2 +-
 hw/net/lan9118.c         |  2 +-
 include/hw/devices.h     |  3 ---
 include/hw/net/lan9118.h | 19 +++++++++++++++++++
 7 files changed, 24 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/net/lan9118.h

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 864c7bd4114..139934c4ecf 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "net/net.h"
-#include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "hw/char/serial.h"
 #include "sysemu/qtest.h"
=20
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index e3d698ba6c4..54b7395849f 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -36,7 +36,7 @@
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
-#include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "net/net.h"
=20
 typedef enum MPS2FPGAType {
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 242f5a87b6a..e9983c87639 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -15,6 +15,7 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
 #include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f07134c4245..d8634f3dd29 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -28,7 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
-#include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index a6269d9463b..a428b16eda5 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -14,7 +14,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "net/eth.h"
-#include "hw/devices.h"
+#include "hw/net/lan9118.h"
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
diff --git a/include/hw/devices.h b/include/hw/devices.h
index ba9034050b4..ebc45c87997 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -8,7 +8,4 @@
 /* smc91c111.c */
 void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
=20
-/* lan9118.c */
-void lan9118_init(NICInfo *, uint32_t, qemu_irq);
-
 #endif
diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
new file mode 100644
index 00000000000..d13d8cd3d22
--- /dev/null
+++ b/include/hw/net/lan9118.h
@@ -0,0 +1,19 @@
+/*
+ * SMSC LAN9118 Ethernet interface emulation
+ *
+ * Copyright (c) 2009 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_NET_LAN9118_H
+#define HW_NET_LAN9118_H
+
+#include "hw/irq.h"
+#include "net/net.h"
+
+void lan9118_init(NICInfo *, uint32_t, qemu_irq);
+
+#endif
--=20
2.20.1
