Received: from eggs.gnu.org ([2001:4830:134:3::10]:46975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw80-0008Ji-NY
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7w-0000II-L8
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:51 +1100
Message-Id: <20170301044405.1792-37-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/50] ppc/xics: remove the XICS list of ICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This is not used anymore.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 8 --------
 hw/ppc/spapr.c        | 1 -
 include/hw/ppc/xics.h | 2 --
 3 files changed, 11 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 97775c2..76b50dc 100644
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
index a5e6072..bce975a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -123,7 +123,6 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
     if (err) {
         goto error;
     }
-    QLIST_INSERT_HEAD(&xics->ics, ics, list);
=20
     xics->ss =3D g_malloc0(nr_servers * sizeof(ICPState));
     xics->nr_servers =3D nr_servers;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index db2bb04..15c52f9 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -83,7 +83,6 @@ struct XICSState {
     /*< public >*/
     uint32_t nr_servers;
     ICPState *ss;
-    QLIST_HEAD(, ICSState) ics;
 };
=20
 #define TYPE_ICP "icp"
@@ -154,7 +153,6 @@ struct ICSState {
     qemu_irq *qirqs;
     ICSIRQState *irqs;
     XICSState *xics;
-    QLIST_ENTRY(ICSState) list;
 };
=20
 static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
--=20
2.9.3
