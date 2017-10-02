Received: from eggs.gnu.org ([2001:4830:134:3::10]:46978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiM-00023a-9x
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiJ-00064L-I0
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiJ-00063n-D1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:35 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:52 +0200
Message-Id: <1506935300-132598-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 10/38] m68k: an5206: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, huth@tuxfamily.org, laurent@vivier.eu
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: huth@tuxfamily.org
CC: laurent@vivier.eu
---
 hw/m68k/an5206.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 9002c46..0cedc54 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -28,7 +28,6 @@
 static void an5206_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     M68kCPU *cpu;
     CPUM68KState *env;
@@ -39,10 +38,7 @@ static void an5206_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
-    if (!cpu_model) {
-        cpu_model = "m5206";
-    }
-    cpu = M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
+    cpu = M68K_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     /* Initialize CPU registers.  */
@@ -94,6 +90,7 @@ static void an5206_machine_init(MachineClass *mc)
 {
     mc->desc = "Arnewsh 5206";
     mc->init = an5206_init;
+    mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
 }
 
 DEFINE_MACHINE("an5206", an5206_machine_init)
-- 
2.7.4
