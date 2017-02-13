Received: from eggs.gnu.org ([2001:4830:134:3::10]:46094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdD1C-0002cJ-Dk
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdD18-00071d-0A
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:33:58 -0500
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:53203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdD17-000712-Pr
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:33:53 -0500
Received: from player786.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9A560AC11F
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 10:33:50 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 13 Feb 2017 10:33:24 +0100
Message-Id: <1486978404-17509-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/xics: fix XICSStateClass parent class
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

XICSState inherits from SysBusDevice and so the object class should
inherit from SysBusDeviceClass.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xics.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 3f0c31610aa4..e8794aa5cba8 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -71,7 +71,7 @@ typedef struct ICSState ICSState;
 typedef struct ICSIRQState ICSIRQState;
=20
 struct XICSStateClass {
-    DeviceClass parent_class;
+    SysBusDeviceClass parent_class;
=20
     void (*cpu_setup)(XICSState *icp, PowerPCCPU *cpu);
     void (*set_nr_irqs)(XICSState *icp, uint32_t nr_irqs, Error **errp);
--=20
2.7.4
