Received: from eggs.gnu.org ([2001:4830:134:3::10]:38182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMK5-0001Di-8I
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMK1-0007j6-9w
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:45 -0500
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:51744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMK1-0007iP-2p
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:41 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id AEF50B3A92
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:30:39 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:18 +0100
Message-Id: <1488205773-30436-12-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 11/26] ppc/xics: remove xics_find_source()
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 12 ------------
 include/hw/ppc/xics.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 23e45a87d47a..a71d3858b13f 100644
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
index b88071529d5b..db2bb04de831 100644
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
2.7.4
