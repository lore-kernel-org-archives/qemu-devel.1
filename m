Received: from eggs.gnu.org ([2001:4830:134:3::10]:33847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Vu-0002Ba-5K
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Vr-0008D0-0p
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85Vq-0008CQ-RB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:32 +0200
Message-Id: <20171027142107.15542-5-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 04/39] cris: use generic cpu_model parsing
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
Message-Id: <1507211474-188400-8-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/cris/axis_dev88.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 5eb552bce2..9ccc4350a5 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -251,7 +251,6 @@ static
 void axisdev88_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     CRISCPU *cpu;
@@ -268,10 +267,7 @@ void axisdev88_init(MachineState *machine)
     MemoryRegion *phys_intmem =3D g_new(MemoryRegion, 1);
=20
     /* init CPUs */
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "crisv32";
-    }
-    cpu =3D CRIS_CPU(cpu_generic_init(TYPE_CRIS_CPU, cpu_model));
+    cpu =3D CRIS_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     /* allocate RAM */
@@ -359,6 +355,7 @@ static void axisdev88_machine_init(MachineClass *mc)
     mc->desc =3D "AXIS devboard 88";
     mc->init =3D axisdev88_init;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D CRIS_CPU_TYPE_NAME("crisv32");
 }
=20
 DEFINE_MACHINE("axis-dev88", axisdev88_machine_init)
--=20
2.13.6
