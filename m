Received: from eggs.gnu.org ([2001:4830:134:3::10]:47463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB6o-0007Rk-1X
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eDB6j-00057R-Ut
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:42 -0500
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:57917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eDB6j-00055i-Pa
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:20:37 -0500
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 791879C349
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 16:20:36 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 10 Nov 2017 15:20:07 +0000
Message-Id: <20171110152017.24324-2-clg@kaod.org>
In-Reply-To: <20171110152017.24324-1-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 01/11] spapr: add pseries 2.12
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d682f013d422..a2dcbee07214 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3687,6 +3687,20 @@ static const TypeInfo spapr_machine_info =3D {
     type_init(spapr_machine_register_##suffix)
=20
 /*
+ * pseries-2.12
+ */
+static void spapr_machine_2_12_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_2_12_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class *=
/
+}
+
+DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
+
+/*
  * pseries-2.11
  */
 static void spapr_machine_2_11_instance_options(MachineState *machine)
@@ -3698,7 +3712,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
     /* Defaults for the latest behaviour inherited from the base class *=
/
 }
=20
-DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
+DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
=20
 /*
  * pseries-2.10
--=20
2.13.6
