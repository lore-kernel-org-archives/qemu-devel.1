Received: from eggs.gnu.org ([2001:4830:134:3::10]:36795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjED-0001oh-1G
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjEC-000275-6T
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:25 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 23:00:47 -0300
Message-Id: <20180109020054.32553-3-f4bug@amsat.org>
In-Reply-To: <20180109020054.32553-1-f4bug@amsat.org>
References: <20180109020054.32553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 2/9] hw/char/cadence_uart: add FDT
 aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/cadence_uart.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 6143494060..f164cee61d 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/sysbus-fdt.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 #include "qemu/timer.h"
@@ -560,6 +561,17 @@ static const TypeInfo cadence_uart_info = {
 
 static void cadence_uart_register_types(void)
 {
+    static const char *cadence_uart_fdt_aliases[] = {
+        "cdns.uart",
+        "cdns,uart-r1p8",
+        "xlnx,xuartps",     /* Zynq-7xxx SoC */
+        "xlnx.ps7-uart",
+        "cdns,uart-r1p12",
+        "xlnx,zynqmp-uart", /* Zynq Ultrascale+ MPSoC */
+        NULL
+    };
+
+    type_register_fdt_aliases(TYPE_CADENCE_UART, cadence_uart_fdt_aliases);
     type_register_static(&cadence_uart_info);
 }
 
-- 
2.15.1
