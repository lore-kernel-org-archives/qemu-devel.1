Received: from eggs.gnu.org ([209.51.188.92]:42583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnw-0000m0-EH
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnr-000191-CI
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:15 +1100
Message-Id: <20190310082703.1245-13-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/60] target/ppc/spapr: Enable mitigations by
 default for pseries-4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

There are currently 3 mitigations the availability of which is controlled
by the spapr-caps mechanism, cap-cfpc, cap-sbbc, and cap-ibs. Enable thes=
e
mitigations by default for the pseries-4.0 machine type.

By now machine firmware should have been upgraded to allow these
settings.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-Id: <20190301044609.9626-3-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 37fd7a1411..946bbcf9ee 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4307,9 +4307,9 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
-    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_WORKAROUND;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_WORKAROUND;
+    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_WORKAROUND;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB *=
/
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
@@ -4389,6 +4389,9 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
     smc->update_dt_enabled =3D false;
     smc->dr_phb_enabled =3D false;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
 }
=20
--=20
2.20.1
