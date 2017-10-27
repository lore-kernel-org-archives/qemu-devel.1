Received: from eggs.gnu.org ([2001:4830:134:3::10]:34431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85XR-0007Fu-FS
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85XQ-0001aK-Hi
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85XQ-0001Zu-BH
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:53 +0200
Message-Id: <20171027142107.15542-26-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 25/39] unicore32: use generic cpu_model
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
Message-Id: <1507211474-188400-29-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/unicore32/puv3.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 504ea46211..1b39cc035b 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -112,7 +112,6 @@ static void puv3_load_kernel(const char *kernel_filen=
ame)
 static void puv3_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *initrd_filename =3D machine->initrd_filename;
     CPUUniCore32State *env;
@@ -123,11 +122,7 @@ static void puv3_init(MachineState *machine)
         exit(1);
     }
=20
-    if (!cpu_model) {
-        cpu_model =3D "UniCore-II";
-    }
-
-    cpu =3D UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model=
));
+    cpu =3D UNICORE32_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     puv3_soc_init(env);
@@ -140,6 +135,7 @@ static void puv3_machine_init(MachineClass *mc)
     mc->desc =3D "PKUnity Version-3 based on UniCore32";
     mc->init =3D puv3_init;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D UNICORE32_CPU_TYPE_NAME("UniCore-II");
 }
=20
 DEFINE_MACHINE("puv3", puv3_machine_init)
--=20
2.13.6
