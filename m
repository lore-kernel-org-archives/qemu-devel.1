Received: from eggs.gnu.org ([2001:4830:134:3::10]:38659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQr-0001yn-2U
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQm-0005RT-5w
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:13 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:33140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMQl-0005QE-Vo
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:08 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7A4F023549
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:49:06 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:32 +0100
Message-Id: <1487252865-12064-10-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/22] ppc/xics: remove xics_find_source()
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
index 2decb921e4e3..bfd3a539561a 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -737,18 +737,6 @@ static const TypeInfo xics_interface_info =3D {
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
 qemu_irq xics_get_qirq(XICSInterface *xi, int irq)
 {
     XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 896fa5d87c1c..e10426e98e31 100644
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
