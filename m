Received: from eggs.gnu.org ([2001:4830:134:3::10]:52882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hq-0000lL-1H
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hm-000397-68
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:17 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  4 Jan 2018 11:40:44 -0300
Message-Id: <20180104144046.30793-5-f4bug@amsat.org>
In-Reply-To: <20180104144046.30793-1-f4bug@amsat.org>
References: <20180104144046.30793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/6] arm/xlnx-zynq: use FDT names for the
 Cadence UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xilinx_zynq.c | 1 +
 hw/arm/xlnx-zynqmp.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 1836a4ed45..c45c364583 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -236,6 +236,7 @@ static void zynq_init(MachineState *machine)
     sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET]);
     sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET]);
 
+    /* "xlnx,xuartps" */
     cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hds[0]);
     cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hds[1]);
 
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 325642058b..38f038786c 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -155,7 +155,7 @@ static void xlnx_zynqmp_init(Object *obj)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
-        object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_CADENCE_UART);
+        object_initialize(&s->uart[i], sizeof(s->uart[i]), "xlnx,zynqmp-uart");
         qdev_set_parent_bus(DEVICE(&s->uart[i]), sysbus_get_default());
     }
 
-- 
2.15.1
