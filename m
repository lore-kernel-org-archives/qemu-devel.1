Received: from eggs.gnu.org ([2001:4830:134:3::10]:36966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjEJ-0001vD-NQ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjEI-0002GM-PJ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:31 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 23:00:49 -0300
Message-Id: <20180109020054.32553-5-f4bug@amsat.org>
In-Reply-To: <20180109020054.32553-1-f4bug@amsat.org>
References: <20180109020054.32553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 4/9] hw/timer/cadence_ttc: add FDT
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/cadence_ttc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 5e65fdb5a0..9aff19d3a5 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/sysbus-fdt.h"
 #include "qemu/timer.h"
 
 #ifdef CADENCE_TTC_ERR_DEBUG
@@ -488,6 +489,13 @@ static const TypeInfo cadence_ttc_info = {
 
 static void cadence_ttc_register_types(void)
 {
+    static const char *cadence_ttc_fdt_aliases[] = {
+        "cdns.ttc",         /* Zynq */
+        "xlnx.ps7-ttc",     /* Zynq-7xxx SoC */
+        NULL
+    };
+
+    type_register_fdt_aliases(TYPE_CADENCE_TTC, cadence_ttc_fdt_aliases);
     type_register_static(&cadence_ttc_info);
 }
 
-- 
2.15.1
