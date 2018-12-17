Received: from eggs.gnu.org ([2001:4830:134:3::10]:58644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1U3-0007kY-E3
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1U0-0007eI-3n
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:31 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:45359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZ1Tz-0007cr-45
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:27 -0500
Received: from player718.ha.ovh.net (unknown [10.109.143.208])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B7332D5554
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:35:25 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 17 Dec 2018 23:34:44 +0100
Message-Id: <20181217223445.28594-7-clg@kaod.org>
In-Reply-To: <20181217223445.28594-1-clg@kaod.org>
References: <20181217223445.28594-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 6/7] spapr: change default CPU type to POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index aefa0f4ea430..8ea680fcde1e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3967,7 +3967,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
=20
     smc->dr_lmb_enabled =3D true;
     smc->update_dt_enabled =3D true;
-    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path =3D spapr_get_fw_dev_path;
@@ -4066,6 +4066,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
=20
     spapr_machine_4_0_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
     smc->update_dt_enabled =3D false;
 }
=20
--=20
2.17.2
