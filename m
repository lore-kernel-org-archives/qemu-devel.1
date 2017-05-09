Received: from eggs.gnu.org ([2001:4830:134:3::10]:60025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Qk-0006M9-JL
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Qg-0003Fd-Lz
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83Qg-0003FI-D1
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6265980C0A
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:35:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:30 +0400
Message-Id: <20170509113332.4987-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/13] Remove/replace chardev/char.h inclusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Those are apparently unnecessary includes.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/bcm2835_peripherals.c | 1 -
 hw/char/imx_serial.c         | 1 -
 hw/display/xenfb.c           | 1 -
 hw/i386/xen/xen-hvm.c        | 1 -
 hw/mips/mips_fulong2e.c      | 1 -
 hw/mips/mips_malta.c         | 1 -
 hw/net/xgmac.c               | 1 -
 hw/ppc/spapr_events.c        | 1 -
 hw/ppc/spapr_rtas.c          | 1 -
 hw/sparc/leon3.c             | 1 -
 hw/usb/ccid-card-emulated.c  | 2 +-
 hw/xen/xen_backend.c         | 1 -
 util/event_notifier-posix.c  | 1 -
 13 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 091e14dc60..502f04c02a 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -13,7 +13,6 @@
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "hw/arm/raspi_platform.h"
-#include "chardev/char.h"
 #include "sysemu/sysemu.h"
=20
 /* Peripheral base address on the VC (GPU) system bus */
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1d4f378a59..af250305be 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "hw/char/imx_serial.h"
 #include "sysemu/sysemu.h"
-#include "chardev/char.h"
 #include "qemu/log.h"
=20
 #ifndef DEBUG_IMX_UART
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 4a1a2a4d6e..e76c0d805c 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -28,7 +28,6 @@
=20
 #include "hw/hw.h"
 #include "ui/console.h"
-#include "chardev/char.h"
 #include "hw/xen/xen_backend.h"
=20
 #include <xen/event_channel.h>
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 8dc57a31cf..321cf36b67 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -18,7 +18,6 @@
 #include "hw/xen/xen_backend.h"
 #include "qmp-commands.h"
=20
-#include "chardev/char.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 55eeb9227d..dbe2805acb 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -32,7 +32,6 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci/pci.h"
-#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "audio/audio.h"
 #include "qemu/log.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 610e1e9085..6fcdd9c6c1 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -37,7 +37,6 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci/pci.h"
-#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/arch_init.h"
 #include "qemu/log.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 3d00e2868c..0843bf185c 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -26,7 +26,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "chardev/char.h"
 #include "qemu/log.h"
 #include "net/net.h"
 #include "net/checksum.h"
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index b309f2f4b0..8a5f1d321a 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -28,7 +28,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
-#include "chardev/char.h"
 #include "hw/qdev.h"
 #include "sysemu/device_tree.h"
=20
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 9995b1a9f5..dd1633a104 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -29,7 +29,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
-#include "chardev/char.h"
 #include "hw/qdev.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f3e62f5bd7..f415997649 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -28,7 +28,6 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
-#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
 #include "hw/boards.h"
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 690b6c3ab4..e646eb243b 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -33,7 +33,7 @@
 #include <vcard_emul.h>
=20
 #include "qemu/thread.h"
-#include "chardev/char.h"
+#include "qemu/main-loop.h"
 #include "ccid.h"
=20
 #define DPRINTF(card, lvl, fmt, ...) \
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index a252a7fd96..b6e1b8cf59 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -28,7 +28,6 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
-#include "chardev/char.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/xen/xen_backend.h"
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 8ab06f9b41..73c4046b58 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -14,7 +14,6 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/event_notifier.h"
-#include "chardev/char.h"
 #include "qemu/main-loop.h"
=20
 #ifdef CONFIG_EVENTFD
--=20
2.13.0.rc1.16.gd80b50c3f
