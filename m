Received: from eggs.gnu.org ([2001:4830:134:3::10]:50381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOT-0008Ht-JC
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOS-0006vU-6L
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:32 +1100
Message-Id: <20171017042152.29443-15-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/34] ppc: bamboo: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_bamboo.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f92d47f28d..693c215108 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -182,11 +182,7 @@ static void bamboo_init(MachineState *machine)
     int success;
     int i;
 
-    /* Setup CPU. */
-    if (machine->cpu_model == NULL) {
-        machine->cpu_model = "440EP";
-    }
-    cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_model));
+    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
@@ -297,6 +293,7 @@ static void bamboo_machine_init(MachineClass *mc)
 {
     mc->desc = "bamboo";
     mc->init = bamboo_init;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
 }
 
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
-- 
2.13.6
