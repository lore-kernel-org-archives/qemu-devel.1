Received: from eggs.gnu.org ([2001:4830:134:3::10]:43683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQA9-0003m0-Rq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQA4-0002vR-8R
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:16:21 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 16 Jan 2018 13:15:57 +0100
Message-Id: <1516104958-3881-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1516104958-3881-1-git-send-email-thuth@redhat.com>
References: <1516104958-3881-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] hw/ppc/Makefile: Add a way to disable the
 PPC4xx boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, BALATON Zoltan <balaton@eik.bme.hu>

We've got the config switch CONFIG_PPC4XX, so we should use it
in the Makefile accordingly and only include the PPC4xx boards
if this switch has been enabled. (Note: Unfortunately, the files
ppc4xx_devs.c and ppc405_uc.c still have to be included in the
build anyway to fulfil some complicated linker dependencies ...
so these are subject to a more thourough clean-up later)

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 7efc686..cf772dc 100644
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
1.8.3.1
