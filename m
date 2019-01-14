Received: from eggs.gnu.org ([209.51.188.92]:44848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz51-0005g4-R5
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4z-0007ZO-LA
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4z-0007Ye-DJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:49 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:11 +0100
Message-Id: <1547460140-1473-17-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/25] hw/char/serial: Remove SerialState from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Files requiring SerialState already include "hw/char/serial.h".

To clean "qemu/typedefs.h", move the declaration to "hw/char/serial.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/char/serial.h | 4 ++--
 include/qemu/typedefs.h  | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 0acfbbc..abd5cf7 100644
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
index 7271e98..4c694b7 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -103,7 +103,6 @@ typedef struct QObject QObject;
 typedef struct QString QString;
 typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
-typedef struct SerialState SerialState;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
--=20
1.8.3.1
