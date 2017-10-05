Received: from eggs.gnu.org ([2001:4830:134:3::10]:52980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZI-0007r2-G2
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZH-0000VD-Nt
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06ZH-0000UU-HQ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:03 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:51:11 +0200
Message-Id: <1507211474-188400-38-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 37/40] mips: fulong2e: replace cpu_model
 with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, yongbok.kim@imgtec.com, aurelien@aurel32.net

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -277,10 +276,7 @@ static void mips_fulong2e_init(MachineState *machine=
)
     CPUMIPSState *env;
=20
     /* init CPUs */
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "Loongson-2E";
-    }
-    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+    cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     qemu_register_reset(main_cpu_reset, cpu);
@@ -385,6 +381,7 @@ static void mips_fulong2e_machine_init(MachineClass *=
mc)
     mc->desc =3D "Fulong 2e mini pc";
     mc->init =3D mips_fulong2e_init;
     mc->block_default_type =3D IF_IDE;
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
 }
=20
 DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
--=20
2.7.4
