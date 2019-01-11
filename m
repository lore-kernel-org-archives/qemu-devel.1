Received: from eggs.gnu.org ([209.51.188.92]:48384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxdy-0005uM-Lv
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxWR-0004D1-0M
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:10:55 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:50 +0100
Message-Id: <20190111140857.4211-9-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/15] hw/char/serial: Remove SerialState from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

Files requiring SerialState already include "hw/char/serial.h".

To clean "qemu/typedefs.h", move the declaration to "hw/char/serial.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/char/serial.h | 4 ++--
 include/qemu/typedefs.h  | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 0acfbbc382..abd5cf71a9 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -35,7 +35,7 @@
=20
 #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
=20
-struct SerialState {
+typedef struct SerialState {
     uint16_t divider;
     uint8_t rbr; /* receive register */
     uint8_t thr; /* transmit holding register */
@@ -77,7 +77,7 @@ struct SerialState {
=20
     QEMUTimer *modem_status_poll;
     MemoryRegion io;
-};
+} SerialState;
=20
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 92f9996107..165d335f87 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -99,7 +99,6 @@ typedef struct QObject QObject;
 typedef struct QString QString;
 typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
-typedef struct SerialState SerialState;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
--=20
2.17.2
