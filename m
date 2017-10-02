Received: from eggs.gnu.org ([2001:4830:134:3::10]:47086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiW-0002DA-16
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiR-00068o-W7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiR-00068O-QF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:43 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:59 +0200
Message-Id: <1506935300-132598-18-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 17/38] sh4: r2d: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Magnus Damm <magnus.damm@gmail.com>
CC: Aurelien Jarno <aurelien@aurel32.net>
---
 hw/sh4/r2d.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 16b9ed2..458ed83 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -225,7 +225,6 @@ static struct QEMU_PACKED
 
 static void r2d_init(MachineState *machine)
 {
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -242,11 +241,7 @@ static void r2d_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     PCIBus *pci_bus;
 
-    if (cpu_model == NULL) {
-        cpu_model = "SH7751R";
-    }
-
-    cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
+    cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
@@ -365,6 +360,7 @@ static void r2d_machine_init(MachineClass *mc)
     mc->desc = "r2d-plus board";
     mc->init = r2d_init;
     mc->block_default_type = IF_IDE;
+    mc->default_cpu_type = TYPE_SH7751R_CPU;
 }
 
 DEFINE_MACHINE("r2d", r2d_machine_init)
-- 
2.7.4
