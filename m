Received: from eggs.gnu.org ([2001:4830:134:3::10]:47036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiO-00026L-Su
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiO-00067F-3r
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiN-00066o-Tw
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:40 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:56 +0200
Message-Id: <1506935300-132598-15-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 14/38] moxie: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, green@moxielogic.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: green@moxielogic.com
---
 hw/moxie/moxiesim.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 01b9f34..3ba5848 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -103,7 +103,6 @@ static void moxiesim_init(MachineState *machine)
 {
     MoxieCPU *cpu = NULL;
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -115,10 +114,7 @@ static void moxiesim_init(MachineState *machine)
     LoaderParams loader_params;
 
     /* Init CPUs. */
-    if (cpu_model == NULL) {
-        cpu_model = "MoxieLite";
-    }
-    cpu = MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
+    cpu = MOXIE_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
@@ -150,6 +146,7 @@ static void moxiesim_machine_init(MachineClass *mc)
     mc->desc = "Moxie simulator platform";
     mc->init = moxiesim_init;
     mc->is_default = 1;
+    mc->default_cpu_type = MOXIE_CPU_TYPE_NAME("MoxieLite");
 }
 
 DEFINE_MACHINE("moxiesim", moxiesim_machine_init)
-- 
2.7.4
