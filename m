Received: from eggs.gnu.org ([2001:4830:134:3::10]:50411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOU-0008JE-Ej
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOT-0006wk-6J
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:31 +1100
Message-Id: <20171017042152.29443-14-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/34] ppc: mac_oldworld: use generic cpu_model
 parsing
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
 hw/ppc/mac_oldworld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index bc7c8b7bd7..010ea36bf2 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -108,11 +108,8 @@ static void ppc_heathrow_init(MachineState *machine)
     linux_boot = (kernel_filename != NULL);
 
     /* init CPUs */
-    if (machine->cpu_model == NULL)
-        machine->cpu_model = "G3";
     for (i = 0; i < smp_cpus; i++) {
-        cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
-                                           machine->cpu_model));
+        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
         env = &cpu->env;
 
         /* Set time-base frequency to 16.6 Mhz */
@@ -385,6 +382,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     /* TOFIX "cad" when Mac floppy is implemented */
     mc->default_boot_order = "cd";
     mc->kvm_type = heathrow_kvm_type;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("750_v3.1");
 }
 
 static const TypeInfo ppc_heathrow_machine_info = {
-- 
2.13.6
