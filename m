Received: from eggs.gnu.org ([209.51.188.92]:38226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8d-0000ZP-Pi
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8X-0007RD-AC
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:59 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:55 +1100
Message-Id: <20190204090124.26191-9-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/37] ppc/xive: fix remaining XiveFabric names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 6 +++---
 include/hw/ppc/xive.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a3cb0cf0e3..7f567a57d2 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1576,9 +1576,9 @@ static const TypeInfo xive_end_source_info =3D {
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
@@ -1587,7 +1587,7 @@ static const TypeInfo xive_fabric_info =3D {
 static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
-    type_register_static(&xive_fabric_info);
+    type_register_static(&xive_notifier_info);
     type_register_static(&xive_router_info);
     type_register_static(&xive_end_source_info);
     type_register_static(&xive_tctx_info);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ec23253ba4..5d31c801ee 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -145,7 +145,7 @@
 #include "hw/ppc/xive_regs.h"
=20
 /*
- * XIVE Fabric (Interface between Source and Router)
+ * XIVE Notifier (Interface between Source and Router)
  */
=20
 typedef struct XiveNotifier {
--=20
2.20.1
