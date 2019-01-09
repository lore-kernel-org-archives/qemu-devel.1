Received: from eggs.gnu.org ([209.51.188.92]:51594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghFaE-0000uI-Co
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghFaB-0007si-4P
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:15:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39808
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ghFaA-0007nR-RU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:15:50 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09F9VbK063535
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 10:15:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pwhswwkcx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 10:15:46 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 9 Jan 2019 15:15:44 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  9 Jan 2019 16:15:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190109151532.20504-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/xive: fix remaining XiveFabric names
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 2 +-
 hw/intc/xive.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 4cd2e54c4958..0f935a146c66 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -146,7 +146,7 @@
 #include "hw/ppc/xive_regs.h"
=20
 /*
- * XIVE Fabric (Interface between Source and Router)
+ * XIVE Notifier (Interface between Source and Router)
  */
=20
 typedef struct XiveNotifier {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 469c90e50c6a..39aac9f89d2a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1659,9 +1659,9 @@ static const TypeInfo xive_end_source_info =3D {
 };
=20
 /*
- * XIVE Fabric
+ * XIVE Notifier
  */
-static const TypeInfo xive_fabric_info =3D {
+static const TypeInfo xive_notifier_info =3D {
     .name =3D TYPE_XIVE_NOTIFIER,
     .parent =3D TYPE_INTERFACE,
     .class_size =3D sizeof(XiveNotifierClass),
@@ -1670,7 +1670,7 @@ static const TypeInfo xive_fabric_info =3D {
 static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
-    type_register_static(&xive_fabric_info);
+    type_register_static(&xive_notifier_info);
     type_register_static(&xive_router_info);
     type_register_static(&xive_end_source_info);
     type_register_static(&xive_tctx_info);
--=20
2.20.1
