Received: from eggs.gnu.org ([2001:4830:134:3::10]:46854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiE-0001ww-9B
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiD-00060K-Az
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiD-0005zl-4u
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:29 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:47 +0200
Message-Id: <1506935300-132598-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 05/38] cris: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, edgar.iglesias@gmail.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: edgar.iglesias@gmail.com
---
 hw/cris/axis_dev88.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 5eb552b..9ccc435 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -251,7 +251,6 @@ static
 void axisdev88_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     CRISCPU *cpu;
@@ -268,10 +267,7 @@ void axisdev88_init(MachineState *machine)
     MemoryRegion *phys_intmem = g_new(MemoryRegion, 1);
 
     /* init CPUs */
-    if (cpu_model == NULL) {
-        cpu_model = "crisv32";
-    }
-    cpu = CRIS_CPU(cpu_generic_init(TYPE_CRIS_CPU, cpu_model));
+    cpu = CRIS_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     /* allocate RAM */
@@ -359,6 +355,7 @@ static void axisdev88_machine_init(MachineClass *mc)
     mc->desc = "AXIS devboard 88";
     mc->init = axisdev88_init;
     mc->is_default = 1;
+    mc->default_cpu_type = CRIS_CPU_TYPE_NAME("crisv32");
 }
 
 DEFINE_MACHINE("axis-dev88", axisdev88_machine_init)
-- 
2.7.4
