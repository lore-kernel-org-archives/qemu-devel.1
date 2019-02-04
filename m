Received: from eggs.gnu.org ([209.51.188.92]:50137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnWG-00014A-BL
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnWF-0000us-HD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:19:16 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 00:18:09 +0100
Message-Id: <20190204231815.29661-6-philmd@redhat.com>
In-Reply-To: <20190204231815.29661-1-philmd@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/11] hw/devices: Move CBus declarations
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
Cc: Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Beniamino Galvani <b.galvani@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS            |  1 +
 hw/arm/nseries.c       |  1 +
 hw/misc/cbus.c         |  2 +-
 include/hw/devices.h   | 14 --------------
 include/hw/misc/cbus.h | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 35 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/misc/cbus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a21e7b546b..daae4a3beb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -654,6 +654,7 @@ F: hw/input/tsc2005.c
 F: hw/misc/cbus.c
 F: hw/timer/twl92230.c
 F: include/hw/display/blizzard.h
+F: include/hw/misc/cbus.h
=20
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 9521be1cef..ac876b5878 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -32,6 +32,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/devices.h"
 #include "hw/display/blizzard.h"
+#include "hw/misc/cbus.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
 #include "hw/bt.h"
diff --git a/hw/misc/cbus.c b/hw/misc/cbus.c
index 25e337ea77..16ee704bca 100644
--- a/hw/misc/cbus.c
+++ b/hw/misc/cbus.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
-#include "hw/devices.h"
+#include "hw/misc/cbus.h"
 #include "sysemu/sysemu.h"
=20
 //#define DEBUG
diff --git a/include/hw/devices.h b/include/hw/devices.h
index 77d6611302..e400f9eac0 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -29,18 +29,4 @@ void tsc2005_set_transform(void *opaque, MouseTransfor=
mInfo *info);
 /* stellaris_input.c */
 void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
=20
-/* cbus.c */
-typedef struct {
-    qemu_irq clk;
-    qemu_irq dat;
-    qemu_irq sel;
-} CBus;
-CBus *cbus_init(qemu_irq dat_out);
-void cbus_attach(CBus *bus, void *slave_opaque);
-
-void *retu_init(qemu_irq irq, int vilma);
-void *tahvo_init(qemu_irq irq, int betty);
-
-void retu_key_event(void *retu, int state);
-
 #endif
diff --git a/include/hw/misc/cbus.h b/include/hw/misc/cbus.h
new file mode 100644
index 0000000000..c899943e03
--- /dev/null
+++ b/include/hw/misc/cbus.h
@@ -0,0 +1,32 @@
+/*
+ * CBUS three-pin bus and the Retu / Betty / Tahvo / Vilma / Avilma /
+ * Hinku / Vinku / Ahne / Pihi chips used in various Nokia platforms.
+ * Based on reverse-engineering of a linux driver.
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Andrzej Zaborowski
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_MISC_CBUS_H
+#define HW_MISC_CBUS_H
+
+#include "hw/irq.h"
+
+typedef struct {
+    qemu_irq clk;
+    qemu_irq dat;
+    qemu_irq sel;
+} CBus;
+
+CBus *cbus_init(qemu_irq dat_out);
+void cbus_attach(CBus *bus, void *slave_opaque);
+
+void *retu_init(qemu_irq irq, int vilma);
+void *tahvo_init(qemu_irq irq, int betty);
+
+void retu_key_event(void *retu, int state);
+
+#endif
--=20
2.20.1
