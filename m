Received: from eggs.gnu.org ([2001:4830:134:3::10]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xU-0002wd-Ep
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xO-0003Hv-H9
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:12 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:34 +0200
Message-Id: <1507220690-265042-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 07/23] ppc: bamboo: use generic cpu_model
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
 hw/ppc/ppc440_bamboo.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f92d47f..693c215 100644
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
2.7.4
