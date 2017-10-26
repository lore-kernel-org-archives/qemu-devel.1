Received: from eggs.gnu.org ([2001:4830:134:3::10]:44505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7inS-0004xY-6A
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7inN-0000N7-6D
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7inM-0000MN-U5
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:06:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:48 +0200
Message-Id: <20171026140404.21948-24-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/39] xtensa: lx60/lx200/ml605/kc705: use
 generic cpu_model parsing
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
Message-Id: <1507211474-188400-27-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/xtensa/xtfpga.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index a19ccebdba..1971ecfdc5 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -220,19 +220,14 @@ static void lx_init(const LxBoardDesc *board, Machi=
neState *machine)
     DriveInfo *dinfo;
     pflash_t *flash =3D NULL;
     QemuOpts *machine_opts =3D qemu_get_machine_opts();
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D qemu_opt_get(machine_opts, "kernel")=
;
     const char *kernel_cmdline =3D qemu_opt_get(machine_opts, "append");
     const char *dtb_filename =3D qemu_opt_get(machine_opts, "dtb");
     const char *initrd_filename =3D qemu_opt_get(machine_opts, "initrd")=
;
     int n;
=20
-    if (!cpu_model) {
-        cpu_model =3D XTENSA_DEFAULT_CPU_MODEL;
-    }
-
     for (n =3D 0; n < smp_cpus; n++) {
-        cpu =3D XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model))=
;
+        cpu =3D XTENSA_CPU(cpu_create(machine->cpu_type));
         env =3D &cpu->env;
=20
         env->sregs[PRID] =3D n;
@@ -454,6 +449,7 @@ static void xtensa_lx60_class_init(ObjectClass *oc, v=
oid *data)
     mc->desc =3D "lx60 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init =3D xtensa_lx60_init;
     mc->max_cpus =3D 4;
+    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
 }
=20
 static const TypeInfo xtensa_lx60_type =3D {
@@ -469,6 +465,7 @@ static void xtensa_lx200_class_init(ObjectClass *oc, =
void *data)
     mc->desc =3D "lx200 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init =3D xtensa_lx200_init;
     mc->max_cpus =3D 4;
+    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
 }
=20
 static const TypeInfo xtensa_lx200_type =3D {
@@ -484,6 +481,7 @@ static void xtensa_ml605_class_init(ObjectClass *oc, =
void *data)
     mc->desc =3D "ml605 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init =3D xtensa_ml605_init;
     mc->max_cpus =3D 4;
+    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
 }
=20
 static const TypeInfo xtensa_ml605_type =3D {
@@ -499,6 +497,7 @@ static void xtensa_kc705_class_init(ObjectClass *oc, =
void *data)
     mc->desc =3D "kc705 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init =3D xtensa_kc705_init;
     mc->max_cpus =3D 4;
+    mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
 }
=20
 static const TypeInfo xtensa_kc705_type =3D {
--=20
2.13.6
