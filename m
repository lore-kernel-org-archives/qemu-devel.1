Received: from eggs.gnu.org ([2001:4830:134:3::10]:47263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiq-0002W2-1Q
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywim-0006Iz-2Y
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywil-0006Ib-St
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:04 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:14 +0200
Message-Id: <1506935300-132598-33-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 32/38] sparc: leon3: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, chouteau@adacore.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: mark.cave-ayland@ilande.co.uk
CC: atar4qemu@gmail.com
CC: chouteau@adacore.com
---
 hw/sparc/leon3.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index ec2816b..8c66d5a 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -107,7 +107,6 @@ static void leon3_set_pil_in(void *opaque, uint32_t pil_in)
 static void leon3_generic_hw_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     SPARCCPU *cpu;
     CPUSPARCState   *env;
@@ -122,11 +121,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     ResetData  *reset_info;
 
     /* Init CPU */
-    if (!cpu_model) {
-        cpu_model = "LEON3";
-    }
-
-    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
+    cpu = SPARC_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     cpu_sparc_set_id(env, 0);
@@ -222,6 +217,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
 {
     mc->desc = "Leon-3 generic";
     mc->init = leon3_generic_hw_init;
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
-- 
2.7.4
