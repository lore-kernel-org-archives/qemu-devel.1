Received: from eggs.gnu.org ([2001:4830:134:3::10]:35070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gAtO9-0008Vf-WE
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gAtO4-0006SD-6m
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:05:41 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:53478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gAtO2-0006L1-Vb
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:05:36 -0400
Received: from player691.ha.ovh.net (unknown [10.109.143.145])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id EF9541899E3
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 11:05:14 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 12 Oct 2018 11:05:09 +0200
Message-ID: <153933510947.3834759.3504000962964977142.stgit@bahia.lan>
In-Reply-To: <153933509870.3834759.13291133122604475240.stgit@bahia.lan>
References: <153933509870.3834759.13291133122604475240.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/2] spapr_pci: convert g_malloc() to g_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

When allocating an array, it is a recommended coding practice to call
g_new(FooType, n) instead of g_malloc(n * sizeof(FooType)) because
it takes care to avoid overflow when calculating the size of the
allocated block and it returns FooType *, which allows the compiler
to perform type checking.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c2271e6ed462..0537ce018f51 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1883,7 +1883,7 @@ static int spapr_pci_pre_save(void *opaque)
     if (!sphb->msi_devs_num) {
         return 0;
     }
-    sphb->msi_devs = g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_msi_mig));
+    sphb->msi_devs = g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
 
     g_hash_table_iter_init(&iter, sphb->msi);
     for (i = 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
