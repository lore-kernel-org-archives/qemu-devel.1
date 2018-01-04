Received: from eggs.gnu.org ([2001:4830:134:3::10]:52714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hl-0000iI-IS
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hi-00030g-1D
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:13 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  4 Jan 2018 11:40:43 -0300
Message-Id: <20180104144046.30793-4-f4bug@amsat.org>
In-Reply-To: <20180104144046.30793-1-f4bug@amsat.org>
References: <20180104144046.30793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/6] hw/char/cadence_uart: add FDT aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/cadence_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 6143494060..6880827947 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -552,6 +552,13 @@ static void cadence_uart_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo cadence_uart_info = {
     .name          = TYPE_CADENCE_UART,
+    .aliases       = (const char * []) {
+                        "cdns,uart-r1p8",
+                        "xlnx,xuartps",     /* Zynq-7xxx SoC */
+                        "cdns,uart-r1p12",
+                        "xlnx,zynqmp-uart", /* Zynq Ultrascale+ MPSoC */
+                        NULL
+                     },
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(CadenceUARTState),
     .instance_init = cadence_uart_init,
-- 
2.15.1
