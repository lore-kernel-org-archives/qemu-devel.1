Received: from eggs.gnu.org ([2001:4830:134:3::10]:52540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yr-0007NG-FE
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yq-0008Pq-Mr
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Yq-0008PF-H1
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:36 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:50 +0200
Message-Id: <1507211474-188400-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/40] moxie: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, green@moxielogic.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
     MoxieCPU *cpu =3D NULL;
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -115,10 +114,7 @@ static void moxiesim_init(MachineState *machine)
     LoaderParams loader_params;
=20
     /* Init CPUs. */
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "MoxieLite";
-    }
-    cpu =3D MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
+    cpu =3D MOXIE_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     qemu_register_reset(main_cpu_reset, cpu);
@@ -150,6 +146,7 @@ static void moxiesim_machine_init(MachineClass *mc)
     mc->desc =3D "Moxie simulator platform";
     mc->init =3D moxiesim_init;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D MOXIE_CPU_TYPE_NAME("MoxieLite");
 }
=20
 DEFINE_MACHINE("moxiesim", moxiesim_machine_init)
--=20
2.7.4
