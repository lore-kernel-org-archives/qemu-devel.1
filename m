Received: from eggs.gnu.org ([2001:4830:134:3::10]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7p-00084Q-AG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7m-00007H-Dc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:29 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:49 +1100
Message-Id: <20170301044405.1792-35-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/50] ppc/xics: remove xics_find_source()
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

It is not used anymore now that we have the QOM interface for XICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 12 ------------
 include/hw/ppc/xics.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 23e45a8..a71d385 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -756,18 +756,6 @@ static const TypeInfo xics_fabric_info =3D {
 /*
  * Exported functions
  */
-ICSState *xics_find_source(XICSState *xics, int irq)
-{
-    ICSState *ics;
-
-    QLIST_FOREACH(ics, &xics->ics, list) {
-        if (ics_valid_irq(ics, irq)) {
-            return ics;
-        }
-    }
-    return NULL;
-}
-
 qemu_irq xics_get_qirq(XICSFabric *xi, int irq)
 {
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index b880715..db2bb04 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -224,7 +224,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
=20
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
=20
-ICSState *xics_find_source(XICSState *icp, int irq);
 void ics_resend(ICSState *ics);
=20
 #endif /* XICS_H */
--=20
2.9.3
