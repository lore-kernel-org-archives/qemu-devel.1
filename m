Received: from eggs.gnu.org ([2001:4830:134:3::10]:36963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53X-0002vg-Vv
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53T-0007cY-6W
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:59 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:48776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gW53S-0007Yh-Sn
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:55 -0500
Received: from player695.ha.ovh.net (unknown [10.109.143.145])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7EA1ED51DD
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 20:47:53 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun,  9 Dec 2018 20:46:08 +0100
Message-Id: <20181209194610.29727-18-clg@kaod.org>
In-Reply-To: <20181209194610.29727-1-clg@kaod.org>
References: <20181209194610.29727-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 17/19] spapr: Add a pseries-4.0 machine type
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/compat.h |  3 +++
 hw/ppc/spapr.c      | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 6f4d5fc64704..70958328fe7a 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
+#define HW_COMPAT_3_1 \
+    /* empty */
+
 #define HW_COMPAT_3_0 \
     /* empty */
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fa41927d95dd..4012ebd794a4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3971,19 +3971,38 @@ static const TypeInfo spapr_machine_info =3D {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
=20
- /*
+/*
+ * pseries-4.0
+ */
+static void spapr_machine_4_0_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_4_0_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class *=
/
+}
+
+DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
+
+/*
  * pseries-3.1
  */
+#define SPAPR_COMPAT_3_1                                              \
+    HW_COMPAT_3_1
+
 static void spapr_machine_3_1_instance_options(MachineState *machine)
 {
+    spapr_machine_4_0_instance_options(machine);
 }
=20
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class *=
/
+    spapr_machine_4_0_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
 }
=20
-DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
+DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
=20
 /*
  * pseries-3.0
--=20
2.17.2
