Received: from eggs.gnu.org ([2001:4830:134:3::10]:40403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmtQ-0008Bu-KN
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmtM-00058G-KU
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:16 -0500
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:37085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCmtM-00057u-E8
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:29:12 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3C4B09BCAA
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:29:11 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Nov 2017 11:14:29 +0100
Message-Id: <20171109101439.390-3-clg@kaod.org>
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
References: <20171109101439.390-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 02/12] ppc/xics: remove useless if
 condition
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

The previous code section uses a 'first < 0' test and returns. Therefore,
there is no need to test the 'first' variable against '>=3D 0' afterwards=
.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_spapr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index d98ea8b13068..e8c0a1b3e903 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -329,10 +329,8 @@ int spapr_ics_alloc_block(ICSState *ics, int num, bo=
ol lsi,
         return -1;
     }
=20
-    if (first >=3D 0) {
-        for (i =3D first; i < first + num; ++i) {
-            ics_set_irq_type(ics, i, lsi);
-        }
+    for (i =3D first; i < first + num; ++i) {
+        ics_set_irq_type(ics, i, lsi);
     }
     first +=3D ics->offset;
=20
--=20
2.13.6
