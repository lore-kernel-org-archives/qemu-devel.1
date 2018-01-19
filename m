Received: from eggs.gnu.org ([2001:4830:134:3::10]:40947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTAc-00029x-Ib
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTAZ-0000t1-GY
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:10 -0500
Received: from ozlabs.org ([103.22.144.67]:48175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ecTAZ-0000sE-4Z
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 19 Jan 2018 20:40:05 +1100
Message-Id: <20180119094015.28266-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180119094015.28266-1-david@gibson.dropbear.id.au>
References: <20180119094015.28266-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/13] hw/ppc/Makefile: Add a way to disable the
 PPC4xx boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, lvivier@redhat.com, agraf@suse.de, qemu-ppc@nognu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

We've got the config switch CONFIG_PPC4XX, so we should use it
in the Makefile accordingly and only include the PPC4xx boards
if this switch has been enabled. (Note: Unfortunately, the files
ppc4xx_devs.c and ppc405_uc.c still have to be included in the
build anyway to fulfil some complicated linker dependencies ...
so these are subject to a more thourough clean-up later)

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 1faff853b7..ad1928c5d8 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -12,8 +12,8 @@ obj-y += spapr_pci_vfio.o
 endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
-obj-y += ppc405_boards.o ppc4xx_devs.o ppc405_uc.o ppc440_bamboo.o
-obj-y += ppc4xx_pci.o
+obj-y += ppc4xx_devs.o ppc405_uc.o
+obj-$(CONFIG_PPC4XX) += ppc4xx_pci.o ppc405_boards.o ppc440_bamboo.o
 # PReP
 obj-$(CONFIG_PREP) += prep.o
 obj-$(CONFIG_PREP) += prep_systemio.o
-- 
2.14.3
