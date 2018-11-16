Received: from eggs.gnu.org ([2001:4830:134:3::10]:34585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrq-0000bV-Bt
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrl-00019T-9g
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:54 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:50952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbrj-0000nO-04
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:49 -0500
Received: from player734.ha.ovh.net (unknown [10.109.146.53])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 689F51739A8
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 12:00:23 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:22 +0100
Message-Id: <20181116105729.23240-30-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 29/36] ppc/xics: remove abort() in
 icp_kvm_init()
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

Replace the abort with an error report which will be handled by the
caller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index efad1b19d821..9662e208fa81 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -131,7 +131,8 @@ static void icp_kvm_init(ICPState *icp, Error **errp)
     int ret;
=20
     if (kernel_xics_fd =3D=3D -1) {
-        abort();
+        error_setg(errp, "KVM XICS device is not initialized");
+        return;
     }
=20
     cs =3D icp->cs;
--=20
2.17.2
