Received: from eggs.gnu.org ([2001:4830:134:3::10]:52870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06ZC-0007ja-69
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e06Z8-0000JJ-Cd
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e06Z8-0000Ie-7W
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:54 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 15:51:04 +0200
Message-Id: <1507211474-188400-31-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 30/40] tricore: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 hw/tricore/tricore_testboard.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
index 0486f8a..ac75eb2 100644
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
2.7.4
