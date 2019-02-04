Received: from eggs.gnu.org ([209.51.188.92]:50410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnWx-0001eu-BJ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnWw-0001OF-EW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:19:59 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 00:18:12 +0100
Message-Id: <20190204231815.29661-9-philmd@redhat.com>
In-Reply-To: <20190204231815.29661-1-philmd@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/11] hw/devices: Move LAN9118 declarations
 into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Beniamino Galvani <b.galvani@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

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
index 864c7bd411..139934c4ec 100644
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
index e3d698ba6c..54b7395849 100644
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
index 242f5a87b6..e9983c8763 100644
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
index c02d18ee61..12e2c3986f 100644
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
index a6269d9463..a428b16eda 100644
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
index ba9034050b..ebc45c8799 100644
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
index 0000000000..d13d8cd3d2
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
