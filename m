Received: from eggs.gnu.org ([2001:4830:134:3::10]:47053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiR-00028o-8C
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiQ-000689-DC
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiQ-00067x-73
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:42 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:58 +0200
Message-Id: <1506935300-132598-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 16/38] openrisc: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, shorne@gmail.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: shorne@gmail.com
---
 hw/openrisc/openrisc_sim.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 86bf284..f61b63d 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -98,18 +98,13 @@ static void cpu_openrisc_load_kernel(ram_addr_t ram_size,
 static void openrisc_sim_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     OpenRISCCPU *cpu = NULL;
     MemoryRegion *ram;
     int n;
 
-    if (!cpu_model) {
-        cpu_model = "or1200";
-    }
-
     for (n = 0; n < smp_cpus; n++) {
-        cpu = OPENRISC_CPU(cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model));
+        cpu = OPENRISC_CPU(cpu_create(machine->cpu_type));
         qemu_register_reset(main_cpu_reset, cpu);
         main_cpu_reset(cpu);
     }
@@ -138,6 +133,7 @@ static void openrisc_sim_machine_init(MachineClass *mc)
     mc->init = openrisc_sim_init;
     mc->max_cpus = 1;
     mc->is_default = 1;
+    mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
 }
 
 DEFINE_MACHINE("or1k-sim", openrisc_sim_machine_init)
-- 
2.7.4
