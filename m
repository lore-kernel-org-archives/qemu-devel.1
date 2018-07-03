Received: from eggs.gnu.org ([2001:4830:134:3::10]:39852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKX-0002rN-Er
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKV-00071h-Ma
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:54 +1000
Message-Id: <20180703055804.13449-26-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 25/35] hw/ppc: Give sam46ex its own config option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

At present the Sam460ex board is activated by the general CONFIG_PPC4XX
option.  However that includes the board for both ppc-softmmu and
(deprecated) ppcemb-softmmu builds.  As Sam460ex is developed, that would
require adding more things into ppcemb-softmmu, which we don't want to do.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak | 1 +
 hw/ppc/Makefile.objs            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 851b4afc21..475120bda2 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -22,6 +22,7 @@ CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
 # For Sam460ex
+CONFIG_SAM460EX=y
 CONFIG_USB_EHCI_SYSBUS=y
 CONFIG_SM501=y
 CONFIG_IDE_SII3112=y
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 86d82a6ec3..bcab6323b7 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -14,7 +14,8 @@ obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
 obj-y += ppc4xx_devs.o ppc405_uc.o
 obj-$(CONFIG_PPC4XX) += ppc4xx_pci.o ppc405_boards.o
-obj-$(CONFIG_PPC4XX) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o sam460ex.o
+obj-$(CONFIG_PPC4XX) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
+obj-$(CONFIG_SAM460EX) += sam460ex.o
 # PReP
 obj-$(CONFIG_PREP) += prep.o
 obj-$(CONFIG_PREP) += prep_systemio.o
-- 
2.17.1
