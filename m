Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfT-0002SP-DJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfS-00044W-HB
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZfS-000449-AN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:30 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:36 +0400
Message-Id: <20181127092801.21777-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 03/28] target/xtensa: xtfpga:
 provide default memory sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Max Filippov <jcmvbkbc@gmail.com>

Provide default RAM sizes for all XTFPGA boards, so that when started
without -m option they do the right thing.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/xtensa/xtfpga.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index b3161de320..21094319a6 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -446,6 +446,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board,=
 MachineState *machine)
     }
 }
=20
+#define XTFPGA_MMU_RESERVED_MEMORY_SIZE (128 * MiB)
+
 static const hwaddr xtfpga_mmu_io[2] =3D {
     0xf0000000,
 };
@@ -568,6 +570,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, v=
oid *data)
     mc->init =3D xtfpga_lx60_init;
     mc->max_cpus =3D 4;
     mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size =3D 64 * MiB;
 }
=20
 static const TypeInfo xtfpga_lx60_type =3D {
@@ -584,6 +587,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass =
*oc, void *data)
     mc->init =3D xtfpga_lx60_nommu_init;
     mc->max_cpus =3D 4;
     mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size =3D 64 * MiB;
 }
=20
 static const TypeInfo xtfpga_lx60_nommu_type =3D {
@@ -600,6 +604,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, =
void *data)
     mc->init =3D xtfpga_lx200_init;
     mc->max_cpus =3D 4;
     mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size =3D 96 * MiB;
 }
=20
 static const TypeInfo xtfpga_lx200_type =3D {
@@ -616,6 +621,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass=
 *oc, void *data)
     mc->init =3D xtfpga_lx200_nommu_init;
     mc->max_cpus =3D 4;
     mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size =3D 96 * MiB;
 }
=20
 static const TypeInfo xtfpga_lx200_nommu_type =3D {
@@ -632,6 +638,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, =
void *data)
     mc->init =3D xtfpga_ml605_init;
     mc->max_cpus =3D 4;
     mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size =3D 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE=
;
 }
=20
 static const TypeInfo xtfpga_ml605_type =3D {
@@ -648,6 +655,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass=
 *oc, void *data)
     mc->init =3D xtfpga_ml605_nommu_init;
     mc->max_cpus =3D 4;
     mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size =3D 256 * MiB;
 }
=20
 static const TypeInfo xtfpga_ml605_nommu_type =3D {
@@ -664,6 +672,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, =
void *data)
     mc->init =3D xtfpga_kc705_init;
     mc->max_cpus =3D 4;
     mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size =3D 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
 }
=20
 static const TypeInfo xtfpga_kc705_type =3D {
@@ -680,6 +689,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass=
 *oc, void *data)
     mc->init =3D xtfpga_kc705_nommu_init;
     mc->max_cpus =3D 4;
     mc->default_cpu_type =3D XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size =3D 256 * MiB;
 }
=20
 static const TypeInfo xtfpga_kc705_nommu_type =3D {
--=20
2.20.0.rc1
