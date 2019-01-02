Received: from eggs.gnu.org ([208.118.235.92]:48977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1geZYa-0003hB-Q3
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1geZYX-0006Rp-Ls
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:59:08 -0500
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:41944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1geZYX-0006RK-Er
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:59:05 -0500
Received: from player773.ha.ovh.net (unknown [10.109.159.139])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 35B5D1C7C23
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 06:59:04 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  2 Jan 2019 06:57:41 +0100
Message-Id: <20190102055743.5052-9-clg@kaod.org>
In-Reply-To: <20190102055743.5052-1-clg@kaod.org>
References: <20190102055743.5052-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/10] ppc/xics: allow ICSState to have an
 offset 0
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

commit 15ed653fa49a ("ppc/xics: An ICS with offset 0 is assumed to be
uninitialized") introduced an extra check on the ICS offset which is
not strictly necessary.

Revert the change to be able to map the XICS IRQ number space on the
XIVE IRQ number space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xics.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 7668c381a887..07508cbd217e 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -139,8 +139,7 @@ struct ICSState {
=20
 static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
 {
-    return (ics->offset !=3D 0) && (nr >=3D ics->offset)
-        && (nr < (ics->offset + ics->nr_irqs));
+    return (nr >=3D ics->offset) && (nr < (ics->offset + ics->nr_irqs));
 }
=20
 struct ICSIRQState {
--=20
2.20.1
