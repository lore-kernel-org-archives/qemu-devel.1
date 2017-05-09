Received: from eggs.gnu.org ([2001:4830:134:3::10]:59743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Pr-0005WD-C4
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Pm-0002ln-7Q
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83Pl-0002lK-R2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C026F80F9B
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:34:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:25 +0400
Message-Id: <20170509113332.4987-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/13] chardev: move headers to include/chardev
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

So they are all in one place.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 {chardev =3D> include/chardev}/char-fd.h        |  2 +-
 {chardev =3D> include/chardev}/char-io.h        |  2 +-
 {chardev =3D> include/chardev}/char-mux.h       |  2 +-
 {chardev =3D> include/chardev}/char-parallel.h  |  0
 {chardev =3D> include/chardev}/char-serial.h    |  0
 {chardev =3D> include/chardev}/char-win-stdio.h |  0
 {chardev =3D> include/chardev}/char-win.h       |  2 +-
 include/{sysemu =3D> chardev}/char.h            |  0
 include/hw/char/bcm2835_aux.h                 |  2 +-
 include/hw/char/cadence_uart.h                |  2 +-
 include/hw/char/digic-uart.h                  |  2 +-
 include/hw/char/imx_serial.h                  |  2 +-
 include/hw/char/serial.h                      |  4 ++--
 include/hw/char/stm32f2xx_usart.h             |  2 +-
 backends/baum.c                               |  2 +-
 backends/msmouse.c                            |  2 +-
 backends/rng-egd.c                            |  2 +-
 backends/testdev.c                            |  2 +-
 chardev/char-console.c                        |  2 +-
 chardev/char-fd.c                             |  6 +++---
 chardev/char-file.c                           |  6 +++---
 chardev/char-io.c                             |  2 +-
 chardev/char-mux.c                            |  4 ++--
 chardev/char-null.c                           |  2 +-
 chardev/char-parallel.c                       |  6 +++---
 chardev/char-pipe.c                           |  6 +++---
 chardev/char-pty.c                            |  4 ++--
 chardev/char-ringbuf.c                        |  2 +-
 chardev/char-serial.c                         |  6 +++---
 chardev/char-socket.c                         |  4 ++--
 chardev/char-stdio.c                          |  8 ++++----
 chardev/char-udp.c                            |  4 ++--
 chardev/char-win-stdio.c                      |  4 ++--
 chardev/char-win.c                            |  2 +-
 chardev/char.c                                | 10 +++++-----
 gdbstub.c                                     |  2 +-
 hmp.c                                         |  2 +-
 hw/arm/bcm2835_peripherals.c                  |  2 +-
 hw/arm/fsl-imx25.c                            |  2 +-
 hw/arm/fsl-imx31.c                            |  2 +-
 hw/arm/fsl-imx6.c                             |  2 +-
 hw/arm/omap2.c                                |  2 +-
 hw/arm/pxa2xx.c                               |  2 +-
 hw/arm/strongarm.c                            |  2 +-
 hw/bt/hci-csr.c                               |  2 +-
 hw/char/cadence_uart.c                        |  2 +-
 hw/char/debugcon.c                            |  2 +-
 hw/char/digic-uart.c                          |  2 +-
 hw/char/escc.c                                |  2 +-
 hw/char/etraxfs_ser.c                         |  2 +-
 hw/char/exynos4210_uart.c                     |  2 +-
 hw/char/grlib_apbuart.c                       |  2 +-
 hw/char/imx_serial.c                          |  2 +-
 hw/char/ipoctal232.c                          |  2 +-
 hw/char/lm32_juart.c                          |  2 +-
 hw/char/lm32_uart.c                           |  2 +-
 hw/char/mcf_uart.c                            |  2 +-
 hw/char/milkymist-uart.c                      |  2 +-
 hw/char/omap_uart.c                           |  2 +-
 hw/char/parallel.c                            |  2 +-
 hw/char/pl011.c                               |  2 +-
 hw/char/sclpconsole-lm.c                      |  2 +-
 hw/char/sclpconsole.c                         |  2 +-
 hw/char/serial.c                              |  2 +-
 hw/char/sh_serial.c                           |  2 +-
 hw/char/spapr_vty.c                           |  2 +-
 hw/char/virtio-console.c                      |  2 +-
 hw/char/xen_console.c                         |  2 +-
 hw/char/xilinx_uartlite.c                     |  2 +-
 hw/core/qdev-properties-system.c              |  2 +-
 hw/core/qdev-properties.c                     |  2 +-
 hw/display/xenfb.c                            |  2 +-
 hw/i386/xen/xen-hvm.c                         |  2 +-
 hw/ipmi/ipmi_bmc_extern.c                     |  2 +-
 hw/isa/pc87312.c                              |  2 +-
 hw/mips/boston.c                              |  2 +-
 hw/mips/mips_fulong2e.c                       |  2 +-
 hw/mips/mips_malta.c                          |  2 +-
 hw/misc/ivshmem.c                             |  2 +-
 hw/net/xgmac.c                                |  2 +-
 hw/ppc/spapr_events.c                         |  2 +-
 hw/ppc/spapr_rtas.c                           |  2 +-
 hw/sparc/leon3.c                              |  2 +-
 hw/usb/ccid-card-emulated.c                   |  2 +-
 hw/usb/ccid-card-passthru.c                   |  2 +-
 hw/usb/dev-serial.c                           |  2 +-
 hw/usb/redirect.c                             |  2 +-
 hw/virtio/vhost-user.c                        |  2 +-
 hw/xen/xen-common.c                           |  2 +-
 hw/xen/xen_backend.c                          |  2 +-
 hw/xtensa/xtfpga.c                            |  2 +-
 monitor.c                                     |  2 +-
 net/colo-compare.c                            |  2 +-
 net/filter-mirror.c                           |  2 +-
 net/slirp.c                                   |  2 +-
 net/vhost-user.c                              |  2 +-
 qmp.c                                         |  2 +-
 qtest.c                                       |  2 +-
 replay/replay-char.c                          |  2 +-
 slirp/slirp.c                                 |  2 +-
 spice-qemu-char.c                             |  2 +-
 tests/postcopy-test.c                         |  2 +-
 tests/test-char.c                             |  2 +-
 tests/vhost-user-test.c                       |  2 +-
 ui/console.c                                  |  2 +-
 ui/gtk.c                                      |  2 +-
 util/event_notifier-posix.c                   |  2 +-
 vl.c                                          |  2 +-
 MAINTAINERS                                   |  1 +
 109 files changed, 128 insertions(+), 127 deletions(-)
 rename {chardev =3D> include/chardev}/char-fd.h (98%)
 rename {chardev =3D> include/chardev}/char-io.h (98%)
 rename {chardev =3D> include/chardev}/char-mux.h (98%)
 rename {chardev =3D> include/chardev}/char-parallel.h (100%)
 rename {chardev =3D> include/chardev}/char-serial.h (100%)
 rename {chardev =3D> include/chardev}/char-win-stdio.h (100%)
 rename {chardev =3D> include/chardev}/char-win.h (98%)
 rename include/{sysemu =3D> chardev}/char.h (100%)

diff --git a/chardev/char-fd.h b/include/chardev/char-fd.h
similarity index 98%
rename from chardev/char-fd.h
rename to include/chardev/char-fd.h
index d8327982fb..55ae5b47b0 100644
--- a/chardev/char-fd.h
+++ b/include/chardev/char-fd.h
@@ -25,7 +25,7 @@
 #define CHAR_FD_H
=20
 #include "io/channel.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 typedef struct FDChardev {
     Chardev parent;
diff --git a/chardev/char-io.h b/include/chardev/char-io.h
similarity index 98%
rename from chardev/char-io.h
rename to include/chardev/char-io.h
index 842be56bda..62753f660a 100644
--- a/chardev/char-io.h
+++ b/include/chardev/char-io.h
@@ -26,7 +26,7 @@
=20
 #include "qemu-common.h"
 #include "io/channel.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 /* Can only be used for read */
 guint io_add_watch_poll(Chardev *chr,
diff --git a/chardev/char-mux.h b/include/chardev/char-mux.h
similarity index 98%
rename from chardev/char-mux.h
rename to include/chardev/char-mux.h
index 3f41dfcfd2..45cdfc7e67 100644
--- a/chardev/char-mux.h
+++ b/include/chardev/char-mux.h
@@ -24,7 +24,7 @@
 #ifndef CHAR_MUX_H
 #define CHAR_MUX_H
=20
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 extern bool muxes_realized;
=20
diff --git a/chardev/char-parallel.h b/include/chardev/char-parallel.h
similarity index 100%
rename from chardev/char-parallel.h
rename to include/chardev/char-parallel.h
diff --git a/chardev/char-serial.h b/include/chardev/char-serial.h
similarity index 100%
rename from chardev/char-serial.h
rename to include/chardev/char-serial.h
diff --git a/chardev/char-win-stdio.h b/include/chardev/char-win-stdio.h
similarity index 100%
rename from chardev/char-win-stdio.h
rename to include/chardev/char-win-stdio.h
diff --git a/chardev/char-win.h b/include/chardev/char-win.h
similarity index 98%
rename from chardev/char-win.h
rename to include/chardev/char-win.h
index 9ed2ba998a..a440a68343 100644
--- a/chardev/char-win.h
+++ b/include/chardev/char-win.h
@@ -24,7 +24,7 @@
 #ifndef CHAR_WIN_H
 #define CHAR_WIN_H
=20
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 typedef struct {
     Chardev parent;
diff --git a/include/sysemu/char.h b/include/chardev/char.h
similarity index 100%
rename from include/sysemu/char.h
rename to include/chardev/char.h
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.=
h
index 6865f154bc..2a051c5646 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -9,7 +9,7 @@
 #define BCM2835_AUX_H
=20
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #define TYPE_BCM2835_AUX "bcm2835-aux"
 #define BCM2835_AUX(obj) OBJECT_CHECK(BCM2835AuxState, (obj), TYPE_BCM28=
35_AUX)
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index c836db4b74..eed7d8d358 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -19,7 +19,7 @@
 #ifndef CADENCE_UART_H
=20
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/timer.h"
=20
 #define CADENCE_UART_RX_FIFO_SIZE           16
diff --git a/include/hw/char/digic-uart.h b/include/hw/char/digic-uart.h
index 340c8e1111..370b48a6c5 100644
--- a/include/hw/char/digic-uart.h
+++ b/include/hw/char/digic-uart.h
@@ -19,7 +19,7 @@
 #define HW_CHAR_DIGIC_UART_H
=20
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #define TYPE_DIGIC_UART "digic-uart"
 #define DIGIC_UART(obj) \
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 4cc3fbc395..05500f5346 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -19,7 +19,7 @@
 #define IMX_SERIAL_H
=20
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #define TYPE_IMX_SERIAL "imx.serial"
 #define IMX_SERIAL(obj) OBJECT_CHECK(IMXSerialState, (obj), TYPE_IMX_SER=
IAL)
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index daebb076c2..01dcd2a8d2 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -28,10 +28,10 @@
=20
 #include "hw/hw.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "exec/memory.h"
 #include "qemu/fifo8.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
=20
diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2x=
x_usart.h
index 3267523270..4259dbeb1e 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -26,7 +26,7 @@
 #define HW_STM32F2XX_USART_H
=20
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/hw.h"
=20
 #define USART_SR   0x00
diff --git a/backends/baum.c b/backends/baum.c
index 2eddcae119..302dd9666c 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "ui/console.h"
diff --git a/backends/msmouse.c b/backends/msmouse.c
index d2c3162f1e..0ffd137ce8 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -23,7 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "ui/console.h"
 #include "ui/input.h"
=20
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 380b19a0a1..5448f6e5f5 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -12,7 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/rng.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
diff --git a/backends/testdev.c b/backends/testdev.c
index 7df9248a13..031e9a23e8 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -25,7 +25,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #define BUF_SIZE 32
=20
diff --git a/chardev/char-console.c b/chardev/char-console.c
index 8d972c1506..535ed65136 100644
--- a/chardev/char-console.c
+++ b/chardev/char-console.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "char-win.h"
+#include "chardev/char-win.h"
=20
 static void qemu_chr_open_win_con(Chardev *chr,
                                   ChardevBackend *backend,
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 548dd4cdd9..c55e7892d0 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -25,11 +25,11 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "io/channel-file.h"
=20
-#include "char-fd.h"
-#include "char-io.h"
+#include "chardev/char-fd.h"
+#include "chardev/char-io.h"
=20
 /* Called with chr_write_lock held.  */
 static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
diff --git a/chardev/char-file.c b/chardev/char-file.c
index aed4ae1569..a57b88aaf2 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -24,12 +24,12 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #ifdef _WIN32
-#include "char-win.h"
+#include "chardev/char-win.h"
 #else
-#include "char-fd.h"
+#include "chardev/char-fd.h"
 #endif
=20
 static void qmp_chardev_open_file(Chardev *chr,
diff --git a/chardev/char-io.c b/chardev/char-io.c
index b4bb094ea3..f7849ddc1e 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "char-io.h"
+#include "chardev/char-io.h"
=20
 typedef struct IOWatchPoll {
     GSource parent;
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 37d42c65c6..106c682e7f 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -24,9 +24,9 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/block-backend.h"
-#include "char-mux.h"
+#include "chardev/char-mux.h"
=20
 /* MUX driver for serial I/O splitting */
=20
diff --git a/chardev/char-null.c b/chardev/char-null.c
index dc0d68ab2d..90bafe76f4 100644
--- a/chardev/char-null.c
+++ b/chardev/char-null.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 static void null_chr_open(Chardev *chr,
                           ChardevBackend *backend,
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 3fa22ce29d..bce89f8c36 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qapi/error.h"
 #include <sys/ioctl.h>
=20
@@ -41,8 +41,8 @@
 #endif
 #endif
=20
-#include "char-fd.h"
-#include "char-parallel.h"
+#include "chardev/char-fd.h"
+#include "chardev/char-parallel.h"
=20
 #if defined(__linux__)
=20
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index aae950a22b..3a95e4c1b2 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -23,12 +23,12 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #ifdef _WIN32
-#include "char-win.h"
+#include "chardev/char-win.h"
 #else
-#include "char-fd.h"
+#include "chardev/char-fd.h"
 #endif
=20
 #ifdef _WIN32
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index aa9d0cb2c3..b1d6ce104c 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -24,12 +24,12 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "io/channel-file.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
=20
-#include "char-io.h"
+#include "chardev/char-io.h"
=20
 #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      =
\
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFl=
y__) \
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index d130069e88..df52b04d22 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qmp-commands.h"
 #include "qemu/base64.h"
=20
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index fef3a91c77..2f8f83821d 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -27,14 +27,14 @@
 #include "qapi/error.h"
=20
 #ifdef _WIN32
-#include "char-win.h"
+#include "chardev/char-win.h"
 #else
 #include <sys/ioctl.h>
 #include <termios.h>
-#include "char-fd.h"
+#include "chardev/char-fd.h"
 #endif
=20
-#include "char-serial.h"
+#include "chardev/char-serial.h"
=20
 #ifdef _WIN32
=20
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 9d5f062c62..8fea5d3ccd 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -22,14 +22,14 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "io/channel-socket.h"
 #include "io/channel-tls.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
=20
-#include "char-io.h"
+#include "chardev/char-io.h"
=20
 /***********************************************************/
 /* TCP Net console */
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index be4a65962c..6f5d798d7b 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -25,14 +25,14 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #ifdef _WIN32
-#include "char-win.h"
-#include "char-win-stdio.h"
+#include "chardev/char-win.h"
+#include "chardev/char-win-stdio.h"
 #else
 #include <termios.h>
-#include "char-fd.h"
+#include "chardev/char-fd.h"
 #endif
=20
 #ifndef _WIN32
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 1958c36de4..40c012d9b0 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -22,11 +22,11 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "io/channel-socket.h"
 #include "qapi/error.h"
=20
-#include "char-io.h"
+#include "chardev/char-io.h"
=20
 /***********************************************************/
 /* UDP Net console */
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index eb44afc17a..efcf7827eb 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -23,8 +23,8 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "char-win.h"
-#include "char-win-stdio.h"
+#include "chardev/char-win.h"
+#include "chardev/char-win-stdio.h"
=20
 typedef struct {
     Chardev parent;
diff --git a/chardev/char-win.c b/chardev/char-win.c
index 24cf364947..ca236ba368 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "char-win.h"
+#include "chardev/char-win.h"
=20
 static void win_chr_read(Chardev *chr, DWORD len)
 {
diff --git a/chardev/char.c b/chardev/char.c
index fadfedb836..af7d871ed5 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -28,16 +28,16 @@
 #include "sysemu/sysemu.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qmp-commands.h"
 #include "qapi-visit.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
=20
-#include "char-mux.h"
-#include "char-io.h"
-#include "char-parallel.h"
-#include "char-serial.h"
+#include "chardev/char-mux.h"
+#include "chardev/char-io.h"
+#include "chardev/char-parallel.h"
+#include "chardev/char-serial.h"
=20
 /***********************************************************/
 /* character device */
diff --git a/gdbstub.c b/gdbstub.c
index 07ebfe9626..e53661ec41 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -25,7 +25,7 @@
 #include "qemu.h"
 #else
 #include "monitor/monitor.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "exec/gdbstub.h"
 #endif
diff --git a/hmp.c b/hmp.c
index bd7b1caf2b..d1c94de440 100644
--- a/hmp.c
+++ b/hmp.c
@@ -17,7 +17,7 @@
 #include "hmp.h"
 #include "net/net.h"
 #include "net/eth.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/config-file.h"
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 369ef1e3bd..091e14dc60 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -13,7 +13,7 @@
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "hw/arm/raspi_platform.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
=20
 /* Peripheral base address on the VC (GPU) system bus */
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 9056f27bf8..40666b68a3 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -30,7 +30,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 static void fsl_imx25_init(Object *obj)
 {
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index d7e2d832b2..c30130667e 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -27,7 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 static void fsl_imx31_init(Object *obj)
 {
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 6969e734ad..27773c9c47 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -24,7 +24,7 @@
 #include "qemu-common.h"
 #include "hw/arm/fsl-imx6.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/error-report.h"
=20
 #define NAME_SIZE 20
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index cf1b4ba58f..566749a9eb 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -30,7 +30,7 @@
 #include "hw/arm/omap.h"
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/block/flash.h"
 #include "hw/arm/soc_dma.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index eea551dc16..0d43cc707c 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -17,7 +17,7 @@
 #include "hw/char/serial.h"
 #include "hw/i2c/i2c.h"
 #include "hw/ssi/ssi.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 3311cc38a4..66cad198d4 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -34,7 +34,7 @@
 #include "strongarm.h"
 #include "qemu/error-report.h"
 #include "hw/arm/arm.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/cutils.h"
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 3c193848fc..cc2087392e 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
 #include "hw/irq.h"
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 4dcee571c0..cf4c1d56ff 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -23,7 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/char/cadence_uart.h"
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 80dce07e7f..77d91c8558 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
=20
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 029f5bbf5e..4f1dec7f1d 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -29,7 +29,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
=20
 #include "hw/char/digic-uart.h"
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 9228091cec..df89d58eed 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/char/escc.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "trace.h"
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index 54383878e0..33e3e16397 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -24,7 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
=20
 #define D(x)
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index bff706ab3a..94952fb90f 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -23,7 +23,7 @@
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #include "hw/arm/exynos4210.h"
=20
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index db686e6a6f..39d1133c61 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -24,7 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #include "trace.h"
=20
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 52e67f8dc9..1d4f378a59 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/imx_serial.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
=20
 #ifndef DEBUG_IMX_UART
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 93929c2880..b8a3c92c9e 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/ipack/ipack.h"
 #include "qemu/bitops.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 /* #define DEBUG_IPOCTAL */
=20
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index f8c1e0d076..6b0633e518 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -21,7 +21,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "trace.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #include "hw/char/lm32_juart.h"
=20
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 7f3597c4b0..a7610c28ce 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "trace.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/error-report.h"
=20
 enum {
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index e69672f4e9..b639b53c83 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -9,7 +9,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
=20
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index ae8e2f3554..5ef847c5eb 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -25,7 +25,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "trace.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/error-report.h"
=20
 enum {
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 31ebb1592c..6fd1b9cf6b 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -18,7 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/hw.h"
 #include "hw/arm/omap.h"
 #include "hw/char/serial.h"
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index c71a4a0f4f..c926df0bee 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 24ea9738b6..1757035bb3 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -9,7 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
 #include "trace.h"
=20
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 07d6ebd112..755d514188 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -17,7 +17,7 @@
 #include "hw/qdev.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index b78f240a73..0fd3cb4887 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -19,7 +19,7 @@
=20
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 typedef struct ASCIIConsoleData {
     EventBufferHeader ebh;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 03d890ca24..aa336333be 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -25,7 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/char/serial.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 303eb0a678..80c7696d8d 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
=20
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index e30c8da57c..2317e45404 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -4,7 +4,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/qdev.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
=20
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 798d9b69fd..8418db6a07 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -11,7 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/virtio/virtio-serial.h"
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index c01f41090e..1cdbe59f8a 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -25,7 +25,7 @@
=20
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/xen/xen_backend.h"
 #include "qapi/error.h"
=20
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 37d313b429..bcebdae3da 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -24,7 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #define DUART(x)
=20
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index 79c2014135..4da0c6a24e 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -20,7 +20,7 @@
 #include "hw/block/block.h"
 #include "net/hub.h"
 #include "qapi/visitor.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/iothread.h"
=20
 static void get_pointer(Object *obj, Visitor *v, Property *prop,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index fa3617db2d..9f1a497322 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -9,7 +9,7 @@
 #include "hw/block/block.h"
 #include "net/hub.h"
 #include "qapi/visitor.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 7a8727aa21..4a1a2a4d6e 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -28,7 +28,7 @@
=20
 #include "hw/hw.h"
 #include "ui/console.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/xen/xen_backend.h"
=20
 #include <xen/event_channel.h>
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index b1c05ffb86..8dc57a31cf 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -18,7 +18,7 @@
 #include "hw/xen/xen_backend.h"
 #include "qmp-commands.h"
=20
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index e8e3d250b6..35285383fd 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -30,7 +30,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "hw/ipmi/ipmi.h"
=20
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index c707d24db4..5ce9f0a062 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -30,7 +30,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "trace.h"
=20
=20
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 83f7b82386..56d22fe49b 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -35,7 +35,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index e636c3abaa..55eeb9227d 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -32,7 +32,7 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci/pci.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "audio/audio.h"
 #include "qemu/log.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 5dd177e961..610e1e9085 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -37,7 +37,7 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci/pci.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/arch_init.h"
 #include "qemu/log.h"
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 82ce8378bf..a45bb7943d 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/event_notifier.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/qtest.h"
 #include "qapi/visitor.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 46b1aa17fa..3d00e2868c 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -26,7 +26,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
 #include "net/net.h"
 #include "net/checksum.h"
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index f0b28d8112..b309f2f4b0 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/qdev.h"
 #include "sysemu/device_tree.h"
=20
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 619f32c054..9995b1a9f5 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -29,7 +29,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "hw/qdev.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6e16478413..f3e62f5bd7 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -28,7 +28,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
 #include "hw/boards.h"
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 99627860a3..690b6c3ab4 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -33,7 +33,7 @@
 #include <vcard_emul.h>
=20
 #include "qemu/thread.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "ccid.h"
=20
 #define DPRINTF(card, lvl, fmt, ...) \
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index a41b0d6ec5..c2096b25ab 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,7 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "ccid.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 6d5137383b..c19cd310c2 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -15,7 +15,7 @@
 #include "qemu/error-report.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 //#define DEBUG_Serial
=20
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index b001a27f05..48468fc61a 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -33,7 +33,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 #include <usbredirparser.h>
 #include <usbredirfilter.h>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9334a8ae22..07b97205fa 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -13,7 +13,7 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio-net.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index a9055e9eba..0bed5770c9 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/xen/xen_backend.h"
 #include "qmp-commands.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/accel.h"
 #include "migration/migration.h"
=20
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index c85f1637e4..a252a7fd96 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -28,7 +28,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/xen/xen_backend.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 11176e26bd..5b31cdc566 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -40,7 +40,7 @@
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/device_tree.h"
 #include "qemu/error-report.h"
 #include "bootparam.h"
diff --git a/monitor.c b/monitor.c
index ce1102944b..1b041e0514 100644
--- a/monitor.c
+++ b/monitor.c
@@ -35,7 +35,7 @@
 #include "exec/gdbstub.h"
 #include "net/net.h"
 #include "net/slirp.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 4ab80b1cbb..d2cdcdfd78 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -25,7 +25,7 @@
 #include "qom/object.h"
 #include "qemu/typedefs.h"
 #include "net/queue.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/sockets.h"
 #include "qapi-visit.h"
 #include "net/colo.h"
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 72fa7c2b6c..03a380b4db 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -20,7 +20,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
=20
diff --git a/net/slirp.c b/net/slirp.c
index c705a60b62..af3e8b22ac 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -37,7 +37,7 @@
 #include "qemu/sockets.h"
 #include "slirp/libslirp.h"
 #include "slirp/ip6.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 00a0c1cbc5..77d2ce22a6 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -12,7 +12,7 @@
 #include "clients.h"
 #include "net/vhost_net.h"
 #include "net/vhost-user.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
diff --git a/qmp.c b/qmp.c
index ab74cd729d..5cebc543c6 100644
--- a/qmp.c
+++ b/qmp.c
@@ -21,7 +21,7 @@
 #include "qemu/config-file.h"
 #include "qemu/uuid.h"
 #include "qmp-commands.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "ui/qemu-spice.h"
 #include "ui/vnc.h"
 #include "sysemu/kvm.h"
diff --git a/qtest.c b/qtest.c
index 5aa6636ca8..dbf70a7018 100644
--- a/qtest.c
+++ b/qtest.c
@@ -17,7 +17,7 @@
 #include "cpu.h"
 #include "sysemu/qtest.h"
 #include "hw/qdev.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "hw/irq.h"
diff --git a/replay/replay-char.c b/replay/replay-char.c
index aa65955942..cbf7c04a9f 100755
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -14,7 +14,7 @@
 #include "sysemu/replay.h"
 #include "replay-internal.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
=20
 /* Char drivers that generate qemu_chr_be_write events
    that should be saved into the log. */
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 2f2ec2c1b3..3b92cb54ce 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -25,7 +25,7 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "slirp.h"
 #include "hw/hw.h"
 #include "qemu/cutils.h"
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 4d1c76e8a4..1c6c2e3969 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "trace-root.h"
 #include "ui/qemu-spice.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/error-report.h"
 #include <spice.h>
 #include <spice/protocol.h>
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index de35a18903..85e7666e84 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -16,7 +16,7 @@
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "hw/nvram/chrp_nvram.h"
=20
diff --git a/tests/test-char.c b/tests/test-char.c
index 773a1c36ba..a6ab17c100 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -4,7 +4,7 @@
 #include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "qemu/sockets.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 9095af267e..acc392d046 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -16,7 +16,7 @@
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
diff --git a/ui/console.c b/ui/console.c
index ac66b3c910..6cf795a23d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -27,7 +27,7 @@
 #include "hw/qdev-core.h"
 #include "qemu/timer.h"
 #include "qmp-commands.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "trace.h"
 #include "exec/memory.h"
=20
diff --git a/ui/gtk.c b/ui/gtk.c
index 7479ceef35..8bb836a09d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -54,7 +54,7 @@
 #include "qmp-commands.h"
 #include "x_keymap.h"
 #include "keymaps.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qom/object.h"
=20
 #define MAX_VCS 10
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index acdbe3b483..8ab06f9b41 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -14,7 +14,7 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/event_notifier.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/main-loop.h"
=20
 #ifdef CONFIG_EVENTFD
diff --git a/vl.c b/vl.c
index 560288fe0c..c028faa149 100644
--- a/vl.c
+++ b/vl.c
@@ -81,7 +81,7 @@ int main(int argc, char **argv)
 #include "sysemu/numa.h"
 #include "exec/gdbstub.h"
 #include "qemu/timer.h"
-#include "sysemu/char.h"
+#include "chardev/char.h"
 #include "qemu/bitmap.h"
 #include "qemu/log.h"
 #include "sysemu/blockdev.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index efdec47319..8f8efa3f7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1221,6 +1221,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 S: Maintained
 F: chardev/
+F: include/chardev/
 F: backends/msmouse.c
 F: backends/testdev.c
=20
--=20
2.13.0.rc1.16.gd80b50c3f
