Received: from eggs.gnu.org ([2001:4830:134:3::10]:59993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDdi-0000Wc-MG
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDdg-00070g-CY
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:45:33 +1100
Message-Id: <20181221054606.22007-8-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/40] spapr: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_iommu.c | 2 +-
 hw/ppc/spapr_vio.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 1b0880ac9e..b56466f89a 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -93,7 +93,7 @@ static uint64_t *spapr_tce_alloc_table(uint32_t liobn,
=20
     if (!table) {
         *fd =3D -1;
-        table =3D g_malloc0(nb_table * sizeof(uint64_t));
+        table =3D g_new0(uint64_t, nb_table);
     }
=20
     trace_spapr_iommu_new_table(liobn, table, *fd);
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 840d4a3c45..7e8a9ad093 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -730,7 +730,7 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
     }
=20
     /* Copy out into an array of pointers */
-    qdevs =3D g_malloc(sizeof(qdev) * num);
+    qdevs =3D g_new(DeviceState *, num);
     num =3D 0;
     QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
         qdevs[num++] =3D kid->child;
--=20
2.19.2
