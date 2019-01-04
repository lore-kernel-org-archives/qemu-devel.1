Received: from eggs.gnu.org ([208.118.235.92]:53137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfTns-0006No-Tb
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfTnr-0006AP-TU
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:02:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 18:58:46 +0100
Message-Id: <20190104175847.6290-16-philmd@redhat.com>
In-Reply-To: <20190104175847.6290-1-philmd@redhat.com>
References: <20190104175847.6290-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/16] hw/devices: Move SMSC 91C111 declaration
 into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This commit finally deletes "hw/devices.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/gumstix.c           |  2 +-
 hw/arm/integratorcp.c      |  2 +-
 hw/arm/mainstone.c         |  2 +-
 hw/arm/realview.c          |  2 +-
 hw/arm/versatilepb.c       |  2 +-
 hw/net/smc91c111.c         |  2 +-
 include/hw/devices.h       | 11 -----------
 include/hw/net/smc91c111.h | 18 ++++++++++++++++++
 8 files changed, 24 insertions(+), 17 deletions(-)
 delete mode 100644 include/hw/devices.h
 create mode 100644 include/hw/net/smc91c111.h

diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 56cb763c4e..98c3e6d41c 100644
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
index 4eceebb9ea..0b6f24465e 100644
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
index 0beb5c426b..fbe8d5cbd4 100644
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
index e9983c8763..05a244df25 100644
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
index 22b09a1e61..70b5fda737 100644
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
index 99da2d9297..d19ea0750d 100644
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
index ebc45c8799..0000000000
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
index 0000000000..46f7d9a5d4
--- /dev/null
+++ b/include/hw/net/smc91c111.h
@@ -0,0 +1,18 @@
+/*
+ * SMSC 91C111 Ethernet interface emulation
+ *
+ * Copyright (c) 2005 CodeSourcery, LLC.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GPL
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
2.17.2
