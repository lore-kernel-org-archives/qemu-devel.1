Received: from eggs.gnu.org ([2001:4830:134:3::10]:43935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7imG-0003q6-9h
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7imA-0007I8-HA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7imA-0007Gs-1B
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:04:50 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:34 +0200
Message-Id: <20171026140404.21948-10-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/39] m68k: an5206: use generic cpu_model
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
