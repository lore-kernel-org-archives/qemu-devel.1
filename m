Received: from eggs.gnu.org ([2001:4830:134:3::10]:51324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG70-0008Nj-4v
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG6w-0005H0-1V
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:06 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  7 Nov 2017 23:28:24 -0300
Message-Id: <20171108022828.7242-3-f4bug@amsat.org>
In-Reply-To: <20171108022828.7242-1-f4bug@amsat.org>
References: <20171108022828.7242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/6] hw/arm: deprecate the EP108 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Alistair Francis <alistair.francis@xilinx.com>

The EP108 was an early access development board that is no longer used.
Add an info message to convert any users to the ZCU102 instead. On QEMU
they are both identical.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xlnx-zcu102.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index e2d15a1c9d..d42b6e3d3a 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -164,6 +164,8 @@ static void xlnx_ep108_init(MachineState *machine)
 {
     XlnxZCU102 *s = EP108_MACHINE(machine);
 
+    info_report("Please use the ZCU102 machine instead of this machine.");
+
     xlnx_zynqmp_init(s, machine);
 }
 
@@ -180,11 +182,13 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "Xilinx ZynqMP EP108 board (Deprecated, please use xlnx-zcu102)";
+    mc->desc = "Xilinx ZynqMP EP108 board";
     mc->init = xlnx_ep108_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecated_reason =
+        "The ZCU102 machine has the same features supported";
 }
 
 static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
-- 
2.15.0
