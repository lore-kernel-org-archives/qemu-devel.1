Received: from eggs.gnu.org ([2001:4830:134:3::10]:52506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yo-0007J9-1M
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yi-0008LA-Eo
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Yi-0008Kx-8m
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:28 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:43 +0200
Message-Id: <1507211474-188400-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/40] lm32: milkymist: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, michael@walle.cc

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Michael Walle <michael@walle.cc>
---
CC: michael@walle.cc
---
 hw/lm32/milkymist.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 4db4d2d..d4e765f 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -80,7 +80,6 @@ static void main_cpu_reset(void *opaque)
 static void
 milkymist_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -108,10 +107,7 @@ milkymist_init(MachineState *machine)
=20
     reset_info =3D g_malloc0(sizeof(ResetInfo));
=20
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "lm32-full";
-    }
-    cpu =3D LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
+    cpu =3D LM32_CPU(cpu_create(machine->cpu_type));
=20
     env =3D &cpu->env;
     reset_info->cpu =3D cpu;
@@ -216,6 +212,7 @@ static void milkymist_machine_init(MachineClass *mc)
     mc->desc =3D "Milkymist One";
     mc->init =3D milkymist_init;
     mc->is_default =3D 0;
+    mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
 }
=20
 DEFINE_MACHINE("milkymist", milkymist_machine_init)
--=20
2.7.4
