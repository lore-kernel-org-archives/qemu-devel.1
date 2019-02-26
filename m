Received: from eggs.gnu.org ([209.51.188.92]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlx-00063t-FX
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUls-0003Jw-Ei
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:58 +1100
Message-Id: <20190226045304.25618-45-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 44/50] spapr: enable PHB hotplug for default
 pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

The 'dr_phb_enabled' field of that class can be set as part of
machine-specific init code. It will be used to conditionally
enable creation of DRC objects and device-tree description to
facilitate hotplug of PHBs.

Since we can't migrate this state to older machine types,
default the option to true and disable it for older machine
types.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <155059673433.1466090.6188091133769611501.stgit@bahia.lab.tou=
louse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7422c05254..5d8b8c9e53 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4290,6 +4290,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq =3D &spapr_irq_xics;
+    smc->dr_phb_enabled =3D true;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -4361,6 +4362,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
=20
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
     smc->update_dt_enabled =3D false;
+    smc->dr_phb_enabled =3D false;
 }
=20
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
--=20
2.20.1
