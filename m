Received: from eggs.gnu.org ([2001:4830:134:3::10]:47313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiv-0002cX-VF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiq-0006Kh-32
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywip-0006KP-Sv
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:08 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:17 +0200
Message-Id: <1506935300-132598-36-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 35/38] mips: fulong2e: replace cpu_model with
 cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, yongbok.kim@imgtec.com, aurelien@aurel32.net
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: yongbok.kim@imgtec.com
CC: aurelien@aurel32.net
---
 hw/mips/mips_fulong2e.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 7531868..146cf0f 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -258,7 +258,6 @@ static void network_init (PCIBus *pci_bus)
 static void mips_fulong2e_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -277,10 +276,7 @@ static void mips_fulong2e_init(MachineState *machine)
     CPUMIPSState *env;
 
     /* init CPUs */
-    if (cpu_model == NULL) {
-        cpu_model = "Loongson-2E";
-    }
-    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
@@ -385,6 +381,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
     mc->desc = "Fulong 2e mini pc";
     mc->init = mips_fulong2e_init;
     mc->block_default_type = IF_IDE;
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
 }
 
 DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
-- 
2.7.4
