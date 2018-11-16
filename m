Received: from eggs.gnu.org ([2001:4830:134:3::10]:34546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrp-0000bD-Bw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbri-00018b-TI
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:53 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:40191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbrg-00013y-Fi
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:46 -0500
Received: from player734.ha.ovh.net (unknown [10.109.160.143])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 9AE23D42C1
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 12:00:34 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:24 +0100
Message-Id: <20181116105729.23240-32-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 31/36] spapr/xive: export the
 spapr_xive_kvm_init() routine
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

We will need it to initialize the KVM XIVE device globally from the
machine when the XIVE interrupt mode is selected.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h | 2 ++
 hw/intc/spapr_xive_kvm.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index fa7f3d7718da..1d134a681326 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -107,4 +107,6 @@ void spapr_xive_mmio_map(sPAPRXive *xive);
 #define TYPE_XIVE_TCTX_KVM   "xive-tctx-kvm"
 #define XIVE_TCTX_KVM(obj)   OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCT=
X_KVM)
=20
+void spapr_xive_kvm_init(sPAPRXive *xive, Error **errp);
+
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index b9fee4ea240f..cb2aa6e81274 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -809,7 +809,7 @@ static void spapr_xive_kvm_instance_init(Object *obj)
                               NULL);
 }
=20
-static void spapr_xive_kvm_init(sPAPRXive *xive, Error **errp)
+void spapr_xive_kvm_init(sPAPRXive *xive, Error **errp)
 {
     Error *local_err =3D NULL;
     size_t tima_len;
--=20
2.17.2
