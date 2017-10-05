Received: from eggs.gnu.org ([2001:4830:134:3::10]:53028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZL-0007tt-NI
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZK-0000XO-Jp
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06ZK-0000WJ-E9
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:52:06 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:51:13 +0200
Message-Id: <1507211474-188400-40-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 39/40] mips: mipssim: replace cpu_model with
 cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, yongbok.kim@imgtec.com, aurelien@aurel32.net

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: yongbok.kim@imgtec.com
CC: aurelien@aurel32.net
---
 hw/mips/mips_mipssim.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index a092072..e5d3654 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -141,7 +141,6 @@ static void
 mips_mipssim_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -156,14 +155,7 @@ mips_mipssim_init(MachineState *machine)
     int bios_size;
=20
     /* Init CPUs. */
-    if (cpu_model =3D=3D NULL) {
-#ifdef TARGET_MIPS64
-        cpu_model =3D "5Kf";
-#else
-        cpu_model =3D "24Kf";
-#endif
-    }
-    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+    cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
@@ -235,6 +227,11 @@ static void mips_mipssim_machine_init(MachineClass *=
mc)
 {
     mc->desc =3D "MIPS MIPSsim platform";
     mc->init =3D mips_mipssim_init;
+#ifdef TARGET_MIPS64
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("5Kf");
+#else
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
+#endif
 }
=20
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
--=20
2.7.4
