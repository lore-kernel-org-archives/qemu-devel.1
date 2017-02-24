Received: from eggs.gnu.org ([2001:4830:134:3::10]:60677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCyb-0005tS-N8
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCyX-0007DD-LO
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:19:49 -0500
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:37057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chCyX-0007Aw-Ea
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:19:45 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 533EDCFA7A
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:19:44 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Feb 2017 11:18:10 +0100
Message-Id: <1487931503-10607-12-git-send-email-clg@kaod.org>
In-Reply-To: <1487931503-10607-1-git-send-email-clg@kaod.org>
References: <1487931503-10607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/24] ppc/xics: remove xics_find_source()
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

It is not used anymore now that we have the QOM interface for XICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        | 12 ------------
 include/hw/ppc/xics.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 92bf44a1a82b..04138bea0abe 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -737,18 +737,6 @@ static const TypeInfo xics_fabric_info =3D {
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
index 8a367a27e04d..aaf84b451d3f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -222,7 +222,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
=20
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
=20
-ICSState *xics_find_source(XICSState *icp, int irq);
 void ics_resend(ICSState *ics);
=20
 #endif /* XICS_H */
--=20
2.7.4
