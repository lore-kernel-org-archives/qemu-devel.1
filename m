Received: from eggs.gnu.org ([2001:4830:134:3::10]:43954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0G-0002eD-0Q
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0C-0000f6-PC
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:19 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:54:58 +0300
Message-Id: <e80200c567ceb01a6f133cb0bf4fade09c395251.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 03/17] machine: Polish -machine xxx,help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The "-machine xxx,help" prints kernel-irqchip possible values as
"OnOffSplit", this adds separators to the printed line.

Also, since only lower case letters are specified in qapi/common.json,
this changes the letter cases too.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index cdc1163dc6..5d445839e8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -520,7 +520,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "accel",
         "Accelerator list", &error_abort);
 
-    object_class_property_add(oc, "kernel-irqchip", "OnOffSplit",
+    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, machine_set_kernel_irqchip,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "kernel-irqchip",
-- 
2.11.0
