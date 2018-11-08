Received: from eggs.gnu.org ([2001:4830:134:3::10]:43576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFQ-0005KA-Og
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFM-0003zL-Or
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:37 +1100
Message-Id: <20181108121646.26173-14-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/22] spapr_pci: convert g_malloc() to g_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

When allocating an array, it is a recommended coding practice to call
g_new(FooType, n) instead of g_malloc(n * sizeof(FooType)) because
it takes care to avoid overflow when calculating the size of the
allocated block and it returns FooType *, which allows the compiler
to perform type checking.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 58afa46204..2374d55fc1 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1882,7 +1882,7 @@ static int spapr_pci_pre_save(void *opaque)
     if (!sphb->msi_devs_num) {
         return 0;
     }
-    sphb->msi_devs =3D g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_ms=
i_mig));
+    sphb->msi_devs =3D g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
=20
     g_hash_table_iter_init(&iter, sphb->msi);
     for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
--=20
2.19.1
