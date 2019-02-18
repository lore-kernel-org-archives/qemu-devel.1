Received: from eggs.gnu.org ([209.51.188.92]:39407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxw-0006ce-Fv
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxt-0003Cj-Vd
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:27 +1100
Message-Id: <20190218143049.17142-22-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/43] xics: Drop the KVM ICP class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The KVM ICP class isn't used anymore. Drop it.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155023081228.1011724.12474992370439652538.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c    | 18 ------------------
 include/hw/ppc/xics.h |  3 ---
 2 files changed, 21 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 4eebced516..fae4ac431f 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -152,23 +152,6 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
     QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
 }
=20
-static void icp_kvm_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    ICPStateClass *icpc =3D ICP_CLASS(klass);
-
-    device_class_set_parent_realize(dc, icp_kvm_realize,
-                                    &icpc->parent_realize);
-}
-
-static const TypeInfo icp_kvm_info =3D {
-    .name =3D TYPE_KVM_ICP,
-    .parent =3D TYPE_ICP,
-    .instance_size =3D sizeof(ICPState),
-    .class_init =3D icp_kvm_class_init,
-    .class_size =3D sizeof(ICPStateClass),
-};
-
 /*
  * ICS-KVM
  */
@@ -425,7 +408,6 @@ fail:
 static void xics_kvm_register_types(void)
 {
     type_register_static(&ics_kvm_info);
-    type_register_static(&icp_kvm_info);
 }
=20
 type_init(xics_kvm_register_types)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index ab61dc2401..fae54e6f28 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -50,9 +50,6 @@ typedef struct XICSFabric XICSFabric;
 #define TYPE_ICP "icp"
 #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
=20
-#define TYPE_KVM_ICP "icp-kvm"
-#define KVM_ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_KVM_ICP)
-
 #define TYPE_PNV_ICP "pnv-icp"
 #define PNV_ICP(obj) OBJECT_CHECK(PnvICPState, (obj), TYPE_PNV_ICP)
=20
--=20
2.20.1
