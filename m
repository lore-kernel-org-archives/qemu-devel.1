Received: from eggs.gnu.org ([2001:4830:134:3::10]:47170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywif-0002La-4i
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywid-0006E0-T2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywid-0006Dh-NM
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:55 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:08 +0200
Message-Id: <1506935300-132598-27-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 26/38] unicore32: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 hw/unicore32/puv3.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 504ea46..1b39cc0 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -112,7 +112,6 @@ static void puv3_load_kernel(const char *kernel_filename)
 static void puv3_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     CPUUniCore32State *env;
@@ -123,11 +122,7 @@ static void puv3_init(MachineState *machine)
         exit(1);
     }
 
-    if (!cpu_model) {
-        cpu_model = "UniCore-II";
-    }
-
-    cpu = UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
+    cpu = UNICORE32_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     puv3_soc_init(env);
@@ -140,6 +135,7 @@ static void puv3_machine_init(MachineClass *mc)
     mc->desc = "PKUnity Version-3 based on UniCore32";
     mc->init = puv3_init;
     mc->is_default = 1;
+    mc->default_cpu_type = UNICORE32_CPU_TYPE_NAME("UniCore-II");
 }
 
 DEFINE_MACHINE("puv3", puv3_machine_init)
-- 
2.7.4
