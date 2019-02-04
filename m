Received: from eggs.gnu.org ([209.51.188.92]:50263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnWp-0001Wv-BQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnWo-0001DR-Bx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:19:51 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 00:18:10 +0100
Message-Id: <20190204231815.29661-7-philmd@redhat.com>
In-Reply-To: <20190204231815.29661-1-philmd@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/11] hw/devices: Move Gamepad declarations
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
 MAINTAINERS                |  1 +
 hw/arm/stellaris.c         |  2 +-
 hw/input/stellaris_input.c |  2 +-
 include/hw/devices.h       |  3 ---
 include/hw/input/gamepad.h | 21 +++++++++++++++++++++
 5 files changed, 24 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/input/gamepad.h

diff --git a/MAINTAINERS b/MAINTAINERS
index daae4a3beb..a38086f767 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -729,6 +729,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/stellaris*
+F: include/hw/input/gamepad.h
=20
 Versatile Express
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 442529cc65..24c20bf612 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -12,7 +12,6 @@
 #include "hw/sysbus.h"
 #include "hw/ssi/ssi.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
@@ -22,6 +21,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
+#include "hw/input/gamepad.h"
 #include "hw/misc/unimp.h"
 #include "cpu.h"
=20
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index 99168bfeef..20c87d86f4 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -8,7 +8,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/devices.h"
+#include "hw/input/gamepad.h"
 #include "ui/console.h"
=20
 typedef struct {
diff --git a/include/hw/devices.h b/include/hw/devices.h
index e400f9eac0..7a630da47f 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -26,7 +26,4 @@ void *tsc2005_init(qemu_irq pintdav);
 uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
 void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
=20
-/* stellaris_input.c */
-void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
-
 #endif
diff --git a/include/hw/input/gamepad.h b/include/hw/input/gamepad.h
new file mode 100644
index 0000000000..112bad5e4c
--- /dev/null
+++ b/include/hw/input/gamepad.h
@@ -0,0 +1,21 @@
+/*
+ * Gamepad style buttons connected to IRQ/GPIO lines
+ *
+ * Copyright (c) 2007 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_INPUT_GAMEPAD_H
+#define HW_INPUT_GAMEPAD_H
+
+/* Gamepad devices that have nowhere better to go.  */
+
+#include "hw/irq.h"
+
+/* stellaris_input.c */
+void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
+
+#endif
--=20
2.20.1
