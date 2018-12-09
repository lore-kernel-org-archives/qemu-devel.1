Received: from eggs.gnu.org ([2001:4830:134:3::10]:37082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53j-0003VF-GB
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53d-0008EH-HB
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:10 -0500
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:49475)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gW53d-00088q-AY
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:05 -0500
Received: from player695.ha.ovh.net (unknown [10.109.143.18])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 0FDC219C5DC
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 20:48:04 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun,  9 Dec 2018 20:46:10 +0100
Message-Id: <20181209194610.29727-20-clg@kaod.org>
In-Reply-To: <20181209194610.29727-1-clg@kaod.org>
References: <20181209194610.29727-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 19/19] spapr: add a 'pseries-4.0-dual'
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This pseries machine makes use of a new sPAPR IRQ backend supporting
both interrupt modes : XIVE and XICS, the default being XICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3cc134a0b673..d9fd4851824e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4000,6 +4000,21 @@ static void spapr_machine_4_0_xive_class_options(M=
achineClass *mc)
=20
 DEFINE_SPAPR_MACHINE(4_0_xive, "4.0-xive", false);
=20
+static void spapr_machine_4_0_dual_instance_options(MachineState *machin=
e)
+{
+    spapr_machine_4_0_instance_options(machine);
+}
+
+static void spapr_machine_4_0_dual_class_options(MachineClass *mc)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
+    spapr_machine_4_0_class_options(mc);
+    smc->irq =3D &spapr_irq_dual;
+}
+
+DEFINE_SPAPR_MACHINE(4_0_dual, "4.0-dual", false);
+
 /*
  * pseries-3.1
  */
--=20
2.17.2
