Received: from eggs.gnu.org ([2001:4830:134:3::10]:50837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7XBa-0006N1-2h
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7XBV-0003Vz-Rz
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:42:18 -0400
Received: from ozlabs.ru ([107.173.13.209]:58662)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7XBV-0003VA-Ls
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:42:13 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 26 Oct 2017 12:41:39 +1100
Message-Id: <20171026014139.46221-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2] machine: Polish  -machine xxx,help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

The "-machine xxx,help" prints kernel-irqchip possible values as
"OnOffSplit", this adds separators to the printed line.

Also, since only lower case letters are specified in qapi/common.json,
this changes the letter cases too.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

aik@fstn1-p1:~$ ./qemu-system-ppc64 -machine pseries,help 2>&1 | grep kernel-irqchip

Was:
pseries-2.11.kernel-irqchip=OnOffSplit (Configure KVM in-kernel irqchip)

Now:
pseries-2.11.kernel-irqchip=on|off|split (Configure KVM in-kernel irqchip)
---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 36c2fb069c..bd3db14e12 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -506,7 +506,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "accel",
         "Accelerator list", &error_abort);
 
-    object_class_property_add(oc, "kernel-irqchip", "OnOffSplit",
+    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, machine_set_kernel_irqchip,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "kernel-irqchip",
-- 
2.11.0
