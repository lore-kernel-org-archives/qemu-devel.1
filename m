Received: from eggs.gnu.org ([2001:4830:134:3::10]:52576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yu-0007Qn-MG
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Ys-0008Sq-Uf
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Ys-0008RV-PT
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:38 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:52 +0200
Message-Id: <1507211474-188400-19-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/40] openrisc: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, shorne@gmail.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: shorne@gmail.com
---
 hw/openrisc/openrisc_sim.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 86bf284..f61b63d 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -98,18 +98,13 @@ static void cpu_openrisc_load_kernel(ram_addr_t ram_s=
ize,
 static void openrisc_sim_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     OpenRISCCPU *cpu =3D NULL;
     MemoryRegion *ram;
     int n;
=20
-    if (!cpu_model) {
-        cpu_model =3D "or1200";
-    }
-
     for (n =3D 0; n < smp_cpus; n++) {
-        cpu =3D OPENRISC_CPU(cpu_generic_init(TYPE_OPENRISC_CPU, cpu_mod=
el));
+        cpu =3D OPENRISC_CPU(cpu_create(machine->cpu_type));
         qemu_register_reset(main_cpu_reset, cpu);
         main_cpu_reset(cpu);
     }
@@ -138,6 +133,7 @@ static void openrisc_sim_machine_init(MachineClass *m=
c)
     mc->init =3D openrisc_sim_init;
     mc->max_cpus =3D 1;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D OPENRISC_CPU_TYPE_NAME("or1200");
 }
=20
 DEFINE_MACHINE("or1k-sim", openrisc_sim_machine_init)
--=20
2.7.4
