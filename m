Received: from eggs.gnu.org ([2001:4830:134:3::10]:49020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7WzW-0002Q6-3E
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7WzS-0003bn-VZ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:29:50 -0400
Received: from ozlabs.ru ([107.173.13.209]:56160)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7WzS-0003aG-PJ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:29:46 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 26 Oct 2017 12:29:10 +1100
Message-Id: <20171026012910.45515-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] machine: Polish  -machine xxx,help
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

aik@fstn1-p1:~$ ./qemu-system-ppc64 -machine pseries,help 2>&1 | grep kernel-irqchip

Was:
pseries-2.11.kernel-irqchip=OnOffSplit (Configure KVM in-kernel irqchip)

Now:
pseries-2.11.kernel-irqchip=On|Off|Split (Configure KVM in-kernel irqchip)
---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 36c2fb069c..ea89cf706e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -506,7 +506,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "accel",
         "Accelerator list", &error_abort);
 
-    object_class_property_add(oc, "kernel-irqchip", "OnOffSplit",
+    object_class_property_add(oc, "kernel-irqchip", "On|Off|Split",
         NULL, machine_set_kernel_irqchip,
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "kernel-irqchip",
-- 
2.11.0
