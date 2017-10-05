Received: from eggs.gnu.org ([2001:4830:134:3::10]:44981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xQ-0002sb-Gy
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xN-0003HT-Dr
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:08 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:33 +0200
Message-Id: <1507220690-265042-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 06/23] ppc: mac_oldworld: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/mac_oldworld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index bc7c8b7..010ea36 100644
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
2.7.4
