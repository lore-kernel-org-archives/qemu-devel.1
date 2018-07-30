Received: from eggs.gnu.org ([2001:4830:134:3::10]:56637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fk8tw-0004ou-GL
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fk8tr-0005W9-OH
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:11:56 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:56948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fk8tr-0005VW-H4
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:11:51 -0400
Received: from player787.ha.ovh.net (unknown [10.109.159.69])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id AF9D8C1D46
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 16:11:49 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 30 Jul 2018 16:11:31 +0200
Message-Id: <20180730141134.31153-2-clg@kaod.org>
In-Reply-To: <20180730141134.31153-1-clg@kaod.org>
References: <20180730141134.31153-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 1/4] spapr: Add a pseries-3.1 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/compat.h |  3 +++
 hw/ppc/spapr.c      | 23 +++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index c08f4040bb80..6f4d5fc64704 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
+#define HW_COMPAT_3_0 \
+    /* empty */
+
 #define HW_COMPAT_2_12 \
     {\
         .driver   =3D "migration",\
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 421b2dd09b51..3c72173c7e0f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4058,19 +4058,38 @@ static const TypeInfo spapr_machine_info =3D {
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
