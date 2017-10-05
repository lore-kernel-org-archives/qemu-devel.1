Received: from eggs.gnu.org ([2001:4830:134:3::10]:52508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yo-0007JM-7m
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yn-0008N0-C7
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Yn-0008Ma-6I
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:33 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:47 +0200
Message-Id: <1507211474-188400-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/40] m68k: mcf5208: use generic cpu_model
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, laurent@vivier.eu, huth@tuxfamily.org

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
CC: laurent@vivier.eu
CC: huth@tuxfamily.org
---
 hw/m68k/mcf5208.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b9dde75..cfac845 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -217,7 +217,6 @@ static void mcf_fec_init(MemoryRegion *sysmem, NICInf=
o *nd, hwaddr base,
 static void mcf5208evb_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     M68kCPU *cpu;
     CPUM68KState *env;
@@ -229,10 +228,7 @@ static void mcf5208evb_init(MachineState *machine)
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
-    if (!cpu_model) {
-        cpu_model =3D "m5208";
-    }
-    cpu =3D M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
+    cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     /* Initialize CPU registers.  */
@@ -321,6 +317,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->desc =3D "MCF5206EVB";
     mc->init =3D mcf5208evb_init;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m5208");
 }
=20
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
--=20
2.7.4
