Received: from eggs.gnu.org ([2001:4830:134:3::10]:46894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiG-0001y2-Iv
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiF-00061l-P0
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiF-00061V-JQ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:31 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:49 +0200
Message-Id: <1506935300-132598-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 07/38] lm32: milkymist: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, michael@walle.cc
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: michael@walle.cc
---
 hw/lm32/milkymist.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 4db4d2d..d4e765f 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -80,7 +80,6 @@ static void main_cpu_reset(void *opaque)
 static void
 milkymist_init(MachineState *machine)
 {
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -108,10 +107,7 @@ milkymist_init(MachineState *machine)
 
     reset_info = g_malloc0(sizeof(ResetInfo));
 
-    if (cpu_model == NULL) {
-        cpu_model = "lm32-full";
-    }
-    cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
+    cpu = LM32_CPU(cpu_create(machine->cpu_type));
 
     env = &cpu->env;
     reset_info->cpu = cpu;
@@ -216,6 +212,7 @@ static void milkymist_machine_init(MachineClass *mc)
     mc->desc = "Milkymist One";
     mc->init = milkymist_init;
     mc->is_default = 0;
+    mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
 }
 
 DEFINE_MACHINE("milkymist", milkymist_machine_init)
-- 
2.7.4
