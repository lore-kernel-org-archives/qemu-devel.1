Received: from eggs.gnu.org ([2001:4830:134:3::10]:37154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjES-00023D-UQ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjEP-0002Q2-6k
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:40 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 23:00:51 -0300
Message-Id: <20180109020054.32553-7-f4bug@amsat.org>
In-Reply-To: <20180109020054.32553-1-f4bug@amsat.org>
References: <20180109020054.32553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 6/9] hw/usb/hcd-ehci: add 'xlnx,
 ps7-usb' FDT aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/hcd-ehci-sysbus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 3b83beb140..0c1a995c2f 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/sysbus-fdt.h"
 #include "hw/usb/hcd-ehci.h"
 
 static const VMStateDescription vmstate_ehci_sysbus = {
@@ -244,6 +245,13 @@ static const TypeInfo ehci_fusbh200_type_info = {
 
 static void ehci_sysbus_register_types(void)
 {
+    static const char *xlnx_ehci_fdt_aliases[] = {
+        "xlnx.zynq-usb",    /* Zynq */
+        "xlnx.ps7-usb",     /* Zynq-7xxx SoC */
+        NULL
+    };
+
+    type_register_fdt_aliases("xlnx,ps7-usb", xlnx_ehci_fdt_aliases);
     type_register_static(&ehci_type_info);
     type_register_static(&ehci_xlnx_type_info);
     type_register_static(&ehci_exynos4210_type_info);
-- 
2.15.1
