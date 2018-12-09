Received: from eggs.gnu.org ([2001:4830:134:3::10]:37039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53c-0003HW-AE
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53Y-0007qc-77
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:04 -0500
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:51883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gW53X-0007mI-UX
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:00 -0500
Received: from player695.ha.ovh.net (unknown [10.109.159.132])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id B2364EE2B0
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 20:47:58 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun,  9 Dec 2018 20:46:09 +0100
Message-Id: <20181209194610.29727-19-clg@kaod.org>
In-Reply-To: <20181209194610.29727-1-clg@kaod.org>
References: <20181209194610.29727-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 18/19] spapr: add a 'pseries-4.0-xive'
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
the XIVE interrupt mode.

The guest OS is required to have support for the XIVE exploitation
mode of the POWER9 interrupt controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4012ebd794a4..3cc134a0b673 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3985,6 +3985,21 @@ static void spapr_machine_4_0_class_options(Machin=
eClass *mc)
=20
 DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
=20
+static void spapr_machine_4_0_xive_instance_options(MachineState *machin=
e)
+{
+    spapr_machine_4_0_instance_options(machine);
+}
+
+static void spapr_machine_4_0_xive_class_options(MachineClass *mc)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+
+    spapr_machine_4_0_class_options(mc);
+    smc->irq =3D &spapr_irq_xive;
+}
+
+DEFINE_SPAPR_MACHINE(4_0_xive, "4.0-xive", false);
+
 /*
  * pseries-3.1
  */
--=20
2.17.2
