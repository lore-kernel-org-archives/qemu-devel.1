Received: from eggs.gnu.org ([2001:4830:134:3::10]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMR1-000286-1J
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQw-0005Zs-J6
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:23 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:46952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMQw-0005Ye-CN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:18 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id DA8A6241B2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:49:16 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:34 +0100
Message-Id: <1487252865-12064-12-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/22] ppc/xics: remove the XICS list of ICS
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

This is not used anymore.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        | 8 --------
 hw/ppc/spapr.c        | 1 -
 include/hw/ppc/xics.h | 2 --
 3 files changed, 11 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d679313cd49f..5131587ce088 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -146,13 +146,6 @@ static void xics_common_reset(DeviceState *d)
     }
 }
=20
-static void xics_common_initfn(Object *obj)
-{
-    XICSState *xics =3D XICS_COMMON(obj);
-
-    QLIST_INIT(&xics->ics);
-}
-
 static void xics_common_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
@@ -165,7 +158,6 @@ static const TypeInfo xics_common_info =3D {
     .parent        =3D TYPE_DEVICE,
     .instance_size =3D sizeof(XICSState),
     .class_size    =3D sizeof(XICSStateClass),
-    .instance_init =3D xics_common_initfn,
     .class_init    =3D xics_common_class_init,
 };
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a2a64d7de41d..d1946ebcac69 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -122,7 +122,6 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
     if (err) {
         goto error;
     }
-    QLIST_INSERT_HEAD(&xics->ics, spapr->ics, list);
=20
     xics->ss =3D g_malloc0(nr_servers * sizeof(ICPState));
     xics->nr_servers =3D nr_servers;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index e10426e98e31..c15d8e2a8ae6 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -82,7 +82,6 @@ struct XICSState {
     /*< public >*/
     uint32_t nr_servers;
     ICPState *ss;
-    QLIST_HEAD(, ICSState) ics;
 };
=20
 #define TYPE_ICP "icp"
@@ -152,7 +151,6 @@ struct ICSState {
     qemu_irq *qirqs;
     ICSIRQState *irqs;
     XICSState *xics;
-    QLIST_ENTRY(ICSState) list;
 };
=20
 static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
--=20
2.7.4
