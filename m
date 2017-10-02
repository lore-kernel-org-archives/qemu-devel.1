Received: from eggs.gnu.org ([2001:4830:134:3::10]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiE-0001x6-Vb
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiB-0005yq-3W
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiA-0005y6-TD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:27 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:45 +0200
Message-Id: <1506935300-132598-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 03/38] alpha: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, rth@twiddle.net
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: rth@twiddle.net
---
 hw/alpha/dp264.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 1b12130..babd6ea 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -51,7 +51,6 @@ static int clipper_pci_map_irq(PCIDevice *d, int irq_num)
 static void clipper_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model ? machine->cpu_model : "ev67";
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -67,7 +66,7 @@ static void clipper_init(MachineState *machine)
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
     for (i = 0; i < smp_cpus; ++i) {
-        cpus[i] = ALPHA_CPU(cpu_generic_init(TYPE_ALPHA_CPU, cpu_model));
+        cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
     }
 
     cpus[0]->env.trap_arg0 = ram_size;
@@ -179,6 +178,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 4;
     mc->is_default = 1;
+    mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
 }
 
 DEFINE_MACHINE("clipper", clipper_machine_init)
-- 
2.7.4
