Received: from eggs.gnu.org ([2001:4830:134:3::10]:34643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Xr-0008Us-Hq
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Xq-00023b-KM
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85Xq-00022K-EN
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:59 +0200
Message-Id: <20171027142107.15542-32-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 31/39] sparc: leon3: use generic cpu_model
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-35-git-send-email-imammedo@redhat.com>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/sparc/leon3.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index ec2816bf94..8c66d5af24 100644
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
2.13.6
