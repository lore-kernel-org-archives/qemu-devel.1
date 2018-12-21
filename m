Received: from eggs.gnu.org ([2001:4830:134:3::10]:60977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDeh-0001Q7-Km
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDed-0000bv-8X
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:27 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:46:05 +1100
Message-Id: <20181221054606.22007-40-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 39/40] spapr: change default CPU type to POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 65c6065602..19a07c5c9d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3931,7 +3931,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     hc->unplug =3D spapr_machine_device_unplug;
=20
     smc->dr_lmb_enabled =3D true;
-    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path =3D spapr_get_fw_dev_path;
@@ -4028,6 +4028,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
 {
     spapr_machine_4_0_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
 }
=20
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
--=20
2.19.2
