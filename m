Received: from eggs.gnu.org ([2001:4830:134:3::10]:37067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjEM-0001yW-Nb
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjEM-0002LS-1X
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:34 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 23:00:50 -0300
Message-Id: <20180109020054.32553-6-f4bug@amsat.org>
In-Reply-To: <20180109020054.32553-1-f4bug@amsat.org>
References: <20180109020054.32553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 5/9] hw/dma/axidma: add 'xlnx,
 eth-dma' FDT alias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/xilinx_axidma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 9b48103574..2359d5c114 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/sysbus-fdt.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
@@ -648,6 +649,7 @@ static const TypeInfo xilinx_axidma_control_stream_info = {
 
 static void xilinx_axidma_register_types(void)
 {
+    type_register_fdt_alias(TYPE_XILINX_AXI_DMA, "xlnx,eth-dma");
     type_register_static(&axidma_info);
     type_register_static(&xilinx_axidma_data_stream_info);
     type_register_static(&xilinx_axidma_control_stream_info);
-- 
2.15.1
