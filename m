Received: from eggs.gnu.org ([2001:4830:134:3::10]:52591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yv-0007Rw-GT
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yu-0008UQ-IF
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Yu-0008Tg-Ce
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:40 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:53 +0200
Message-Id: <1507211474-188400-20-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 19/40] sh4: r2d: use generic cpu_model
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
=20
 static void r2d_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -242,11 +241,7 @@ static void r2d_init(MachineState *machine)
     MemoryRegion *address_space_mem =3D get_system_memory();
     PCIBus *pci_bus;
=20
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "SH7751R";
-    }
-
-    cpu =3D SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
+    cpu =3D SUPERH_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
@@ -365,6 +360,7 @@ static void r2d_machine_init(MachineClass *mc)
     mc->desc =3D "r2d-plus board";
     mc->init =3D r2d_init;
     mc->block_default_type =3D IF_IDE;
+    mc->default_cpu_type =3D TYPE_SH7751R_CPU;
 }
=20
 DEFINE_MACHINE("r2d", r2d_machine_init)
--=20
2.7.4
