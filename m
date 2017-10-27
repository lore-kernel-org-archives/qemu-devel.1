Received: from eggs.gnu.org ([2001:4830:134:3::10]:34497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85Xb-0007oG-Nw
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85XY-0001iH-KS
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85XY-0001hI-Ef
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:23:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:55 +0200
Message-Id: <20171027142107.15542-28-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 27/39] tricore: use generic cpu_model parsing
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
Message-Id: <1507211474-188400-31-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/tricore/tricore_testboard.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
index 0486f8a1d9..ac75eb2128 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -71,10 +71,7 @@ static void tricore_testboard_init(MachineState *machi=
ne, int board_id)
     MemoryRegion *pcp_data =3D g_new(MemoryRegion, 1);
     MemoryRegion *pcp_text =3D g_new(MemoryRegion, 1);
=20
-    if (!machine->cpu_model) {
-        machine->cpu_model =3D "tc1796";
-    }
-    cpu =3D TRICORE_CPU(cpu_generic_init(TYPE_TRICORE_CPU, machine->cpu_=
model));
+    cpu =3D TRICORE_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
     memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
                            2 * 1024 * 1024, &error_fatal);
@@ -114,6 +111,7 @@ static void ttb_machine_init(MachineClass *mc)
     mc->desc =3D "a minimal TriCore board";
     mc->init =3D tricoreboard_init;
     mc->is_default =3D 0;
+    mc->default_cpu_type =3D TRICORE_CPU_TYPE_NAME("tc1796");
 }
=20
 DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
--=20
2.13.6
