Received: from eggs.gnu.org ([2001:4830:134:3::10]:44134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7img-0004Fl-D5
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7imf-0007vf-G6
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7imf-0007tI-67
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:40 +0200
Message-Id: <20171026140404.21948-16-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/39] openrisc: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-19-git-send-email-imammedo@redhat.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/openrisc/openrisc_sim.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 58638c6ecd..e9558f1ca4 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -125,7 +125,6 @@ static void openrisc_load_kernel(ram_addr_t ram_size,
 static void openrisc_sim_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     OpenRISCCPU *cpu =3D NULL;
     MemoryRegion *ram;
@@ -133,12 +132,8 @@ static void openrisc_sim_init(MachineState *machine)
     qemu_irq serial_irq;
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
         if (cpu =3D=3D NULL) {
             fprintf(stderr, "Unable to find CPU definition!\n");
             exit(1);
@@ -180,6 +175,7 @@ static void openrisc_sim_machine_init(MachineClass *m=
c)
     mc->init =3D openrisc_sim_init;
     mc->max_cpus =3D 2;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D OPENRISC_CPU_TYPE_NAME("or1200");
 }
=20
 DEFINE_MACHINE("or1k-sim", openrisc_sim_machine_init)
--=20
2.13.6
