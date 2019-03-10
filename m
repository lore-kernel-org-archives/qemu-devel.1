Received: from eggs.gnu.org ([209.51.188.92]:42421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tno-0000di-RX
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnm-00015D-5h
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:05 +1100
Message-Id: <20190310082703.1245-3-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/60] vfio/spapr: Rename local systempagesize
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The "systempagesize" name suggests that it is the host system page size
while it is the smallest page size of memory backing the guest RAM so
let's rename it to stop confusion. This should cause no behavioral change=
.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190227085149.38596-4-aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/vfio/spapr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 88437a79e6..57fe758e54 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -148,14 +148,14 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
     uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
     unsigned entries, bits_total, bits_per_level, max_levels;
     struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
-    long systempagesize =3D qemu_getrampagesize();
+    long rampagesize =3D qemu_getrampagesize();
=20
     /*
      * The host might not support the guest supported IOMMU page size,
      * so we will use smaller physical IOMMU pages to back them.
      */
-    if (pagesize > systempagesize) {
-        pagesize =3D systempagesize;
+    if (pagesize > rampagesize) {
+        pagesize =3D rampagesize;
     }
     pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
                                    (pagesize | (pagesize - 1))));
--=20
2.20.1
