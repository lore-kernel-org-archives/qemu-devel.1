Received: from eggs.gnu.org ([2001:4830:134:3::10]:53027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZL-0007tr-Mt
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZJ-0000W3-B6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06ZJ-0000Vk-5F
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:05 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:51:12 +0200
Message-Id: <1507211474-188400-39-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 38/40] mips: Magnum/Acer Pica 61: replace
 cpu_model with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, hpoussin@reactos.org, aurelien@aurel32.net, yongbok.kim@imgtec.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
CC: hpoussin@reactos.org
CC: aurelien@aurel32.net
CC: yongbok.kim@imgtec.com
---
 hw/mips/mips_jazz.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 7e6626d..fe4f173 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -122,7 +122,6 @@ static void mips_jazz_init(MachineState *machine,
                            enum jazz_model_e jazz_model)
 {
     MemoryRegion *address_space =3D get_system_memory();
-    const char *cpu_model =3D machine->cpu_model;
     char *filename;
     int bios_size, n;
     MIPSCPU *cpu;
@@ -148,10 +147,7 @@ static void mips_jazz_init(MachineState *machine,
     MemoryRegion *bios2 =3D g_new(MemoryRegion, 1);
=20
     /* init CPUs */
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "R4000";
-    }
-    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+    cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
=20
@@ -349,6 +345,7 @@ static void mips_magnum_class_init(ObjectClass *oc, v=
oid *data)
     mc->desc =3D "MIPS Magnum";
     mc->init =3D mips_magnum_init;
     mc->block_default_type =3D IF_SCSI;
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
 }
=20
 static const TypeInfo mips_magnum_type =3D {
@@ -364,6 +361,7 @@ static void mips_pica61_class_init(ObjectClass *oc, v=
oid *data)
     mc->desc =3D "Acer Pica 61";
     mc->init =3D mips_pica61_init;
     mc->block_default_type =3D IF_SCSI;
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
 }
=20
 static const TypeInfo mips_pica61_type =3D {
--=20
2.7.4
