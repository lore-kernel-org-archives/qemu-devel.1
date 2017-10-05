Received: from eggs.gnu.org ([2001:4830:134:3::10]:52929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZE-0007mx-HX
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZD-0000Px-L7
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06ZD-0000Oj-C0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:59 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:51:08 +0200
Message-Id: <1507211474-188400-35-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 34/40] sparc: leon3: use generic cpu_model
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, chouteau@adacore.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: mark.cave-ayland@ilande.co.uk
CC: atar4qemu@gmail.com
CC: chouteau@adacore.com
---
 hw/sparc/leon3.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index ec2816b..8c66d5a 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -107,7 +107,6 @@ static void leon3_set_pil_in(void *opaque, uint32_t p=
il_in)
 static void leon3_generic_hw_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     SPARCCPU *cpu;
     CPUSPARCState   *env;
@@ -122,11 +121,7 @@ static void leon3_generic_hw_init(MachineState *mach=
ine)
     ResetData  *reset_info;
=20
     /* Init CPU */
-    if (!cpu_model) {
-        cpu_model =3D "LEON3";
-    }
-
-    cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
+    cpu =3D SPARC_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     cpu_sparc_set_id(env, 0);
@@ -222,6 +217,7 @@ static void leon3_generic_machine_init(MachineClass *=
mc)
 {
     mc->desc =3D "Leon-3 generic";
     mc->init =3D leon3_generic_hw_init;
+    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("LEON3");
 }
=20
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
--=20
2.7.4
