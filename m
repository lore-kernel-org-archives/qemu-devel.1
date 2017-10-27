Received: from eggs.gnu.org ([2001:4830:134:3::10]:33977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85WE-0002ex-SY
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85WD-00005v-QX
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85WD-00005B-Ko
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:37 +0200
Message-Id: <20171027142107.15542-10-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 09/39] m68k: an5206: use generic cpu_model
 parsing
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
Acked-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1507211474-188400-13-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/m68k/an5206.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index db634cbe89..5e067ea1c3 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -28,7 +28,6 @@
 static void an5206_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     M68kCPU *cpu;
     CPUM68KState *env;
@@ -39,10 +38,7 @@ static void an5206_init(MachineState *machine)
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
=20
-    if (!cpu_model) {
-        cpu_model =3D "m5206";
-    }
-    cpu =3D M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
+    cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     /* Initialize CPU registers.  */
@@ -94,6 +90,7 @@ static void an5206_machine_init(MachineClass *mc)
 {
     mc->desc =3D "Arnewsh 5206";
     mc->init =3D an5206_init;
+    mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m5206");
 }
=20
 DEFINE_MACHINE("an5206", an5206_machine_init)
--=20
2.13.6
