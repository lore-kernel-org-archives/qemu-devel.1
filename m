Received: from eggs.gnu.org ([2001:4830:134:3::10]:52456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yj-0007G9-OE
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Yd-0008Ii-PC
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Yd-0008I6-Is
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:23 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:50:39 +0200
Message-Id: <1507211474-188400-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/40] alpha: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, rth@twiddle.net

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: rth@twiddle.net
---
 hw/alpha/dp264.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 1b12130..babd6ea 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -51,7 +51,6 @@ static int clipper_pci_map_irq(PCIDevice *d, int irq_nu=
m)
 static void clipper_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model ? machine->cpu_model : =
"ev67";
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -67,7 +66,7 @@ static void clipper_init(MachineState *machine)
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
     for (i =3D 0; i < smp_cpus; ++i) {
-        cpus[i] =3D ALPHA_CPU(cpu_generic_init(TYPE_ALPHA_CPU, cpu_model=
));
+        cpus[i] =3D ALPHA_CPU(cpu_create(machine->cpu_type));
     }
=20
     cpus[0]->env.trap_arg0 =3D ram_size;
@@ -179,6 +178,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D 4;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D ALPHA_CPU_TYPE_NAME("ev67");
 }
=20
 DEFINE_MACHINE("clipper", clipper_machine_init)
--=20
2.7.4
