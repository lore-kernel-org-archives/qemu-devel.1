Received: from eggs.gnu.org ([2001:4830:134:3::10]:56755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70R-0001Wl-Vv
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70L-000443-O4
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:42:57 +1000
Message-Id: <20170927074316.4454-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/26] ppc: QOMify g3beige machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_oldworld.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 61838c3e6f..bc7c8b7bd7 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -371,8 +371,10 @@ static int heathrow_kvm_type(const char *arg)
     return 2;
 }
=20
-static void heathrow_machine_init(MachineClass *mc)
+static void heathrow_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
     mc->desc =3D "Heathrow based PowerMAC";
     mc->init =3D ppc_heathrow_init;
     mc->block_default_type =3D IF_IDE;
@@ -385,4 +387,15 @@ static void heathrow_machine_init(MachineClass *mc)
     mc->kvm_type =3D heathrow_kvm_type;
 }
=20
-DEFINE_MACHINE("g3beige", heathrow_machine_init)
+static const TypeInfo ppc_heathrow_machine_info =3D {
+    .name          =3D MACHINE_TYPE_NAME("g3beige"),
+    .parent        =3D TYPE_MACHINE,
+    .class_init    =3D heathrow_class_init
+};
+
+static void ppc_heathrow_register_types(void)
+{
+    type_register_static(&ppc_heathrow_machine_info);
+}
+
+type_init(ppc_heathrow_register_types);
--=20
2.13.5
