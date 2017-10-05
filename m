Received: from eggs.gnu.org ([2001:4830:134:3::10]:52755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Z5-0007cd-EC
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Z1-00009G-AN
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Z1-00008S-3i
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:47 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:59 +0200
Message-Id: <1507211474-188400-26-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 25/40] xtensa: sim: use generic cpu_model
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, jcmvbkbc@gmail.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: jcmvbkbc@gmail.com
---
 hw/xtensa/sim.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index b3580b1..2bb883b 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -75,16 +75,11 @@ static void xtensa_sim_init(MachineState *machine)
     XtensaCPU *cpu =3D NULL;
     CPUXtensaState *env =3D NULL;
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     int n;
=20
-    if (!cpu_model) {
-        cpu_model =3D XTENSA_DEFAULT_CPU_MODEL;
-    }
-
     for (n =3D 0; n < smp_cpus; n++) {
-        cpu =3D XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model))=
;
+        cpu =3D XTENSA_CPU(cpu_create(machine->cpu_type));
         env =3D &cpu->env;
=20
         env->sregs[PRID] =3D n;
@@ -133,6 +128,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->init =3D xtensa_sim_init;
     mc->max_cpus =3D 4;
     mc->no_serial =3D 1;
+    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
 }
=20
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
--=20
2.7.4
