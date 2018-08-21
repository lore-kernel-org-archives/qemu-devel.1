Received: from eggs.gnu.org ([2001:4830:134:3::10]:56504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMt-0004Bi-P2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMo-0000Ml-W7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:31 +1000
Message-Id: <20180821043343.7514-15-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/26] spapr: Add a pseries-3.1 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e5d825374e..a732f59205 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4059,19 +4059,38 @@ static const TypeInfo spapr_machine_info =3D {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
=20
+ /*
+ * pseries-3.1
+ */
+static void spapr_machine_3_1_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_3_1_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class *=
/
+}
+
+DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
+
 /*
  * pseries-3.0
  */
+#define SPAPR_COMPAT_3_0                                              \
+    HW_COMPAT_3_0
+
 static void spapr_machine_3_0_instance_options(MachineState *machine)
 {
+    spapr_machine_3_1_instance_options(machine);
 }
=20
 static void spapr_machine_3_0_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class *=
/
+    spapr_machine_3_1_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
 }
=20
-DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
+DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
=20
 /*
  * pseries-2.12
--=20
2.17.1
