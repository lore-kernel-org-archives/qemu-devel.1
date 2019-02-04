Received: from eggs.gnu.org ([209.51.188.92]:49974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnVz-0000ns-He
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnVy-0000iT-Ji
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:18:59 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 00:18:07 +0100
Message-Id: <20190204231815.29661-4-philmd@redhat.com>
In-Reply-To: <20190204231815.29661-1-philmd@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/11] hw/devices: Move TC6393XB
 declarations into a new header
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

The TC6393XB_RAM definition introduced in 64b40bc54a9 is no
more used since a0b753dfd39. Remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                   |  1 +
 hw/arm/tosa.c                 |  2 +-
 hw/display/tc6393xb.c         |  2 +-
 include/hw/devices.h          | 10 ----------
 include/hw/display/tc6393xb.h | 26 ++++++++++++++++++++++++++
 5 files changed, 29 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/display/tc6393xb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a76845581..52058a8983 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -699,6 +699,7 @@ F: hw/misc/mst_fpga.c
 F: hw/misc/max111x.c
 F: include/hw/arm/pxa.h
 F: include/hw/arm/sharpsl.h
+F: include/hw/display/tc6393xb.h
=20
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 7a925fa5e6..b6d464ab16 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -16,10 +16,10 @@
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
 #include "hw/arm/sharpsl.h"
 #include "hw/pcmcia.h"
 #include "hw/boards.h"
+#include "hw/display/tc6393xb.h"
 #include "hw/i2c/i2c.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index e1b1e302f2..5305c06816 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
 #include "hw/hw.h"
-#include "hw/devices.h"
+#include "hw/display/tc6393xb.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
diff --git a/include/hw/devices.h b/include/hw/devices.h
index b5f1662225..1e2141caad 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -50,14 +50,4 @@ void *tahvo_init(qemu_irq irq, int betty);
=20
 void retu_key_event(void *retu, int state);
=20
-/* tc6393xb.c */
-typedef struct TC6393xbState TC6393xbState;
-#define TC6393XB_RAM	0x110000 /* amount of ram for Video and USB */
-TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
-                             uint32_t base, qemu_irq irq);
-void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
-                    qemu_irq handler);
-qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s);
-qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
-
 #endif
diff --git a/include/hw/display/tc6393xb.h b/include/hw/display/tc6393xb.=
h
new file mode 100644
index 0000000000..387c143b44
--- /dev/null
+++ b/include/hw/display/tc6393xb.h
@@ -0,0 +1,26 @@
+/*
+ * Toshiba TC6393XB I/O Controller.
+ * Found in Sharp Zaurus SL-6000 (tosa) or some
+ * Toshiba e-Series PDAs.
+ *
+ * Copyright (c) 2007 Herv=C3=A9 Poussineau
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_DISPLAY_TC6393XB_H
+#define HW_DISPLAY_TC6393XB_H
+
+#include "exec/memory.h"
+#include "hw/irq.h"
+
+typedef struct TC6393xbState TC6393xbState;
+
+TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
+                             uint32_t base, qemu_irq irq);
+void tc6393xb_gpio_out_set(TC6393xbState *s, int line, qemu_irq handler)=
;
+qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s);
+qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
+
+#endif
--=20
2.20.1
