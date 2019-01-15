Received: from eggs.gnu.org ([209.51.188.92]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYZ-0002jb-7j
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPRK-00018Y-4s
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:56300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPRJ-000130-S4
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:11:38 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:10:38 +0800
Message-Id: <20190115141108.934-8-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 07/37] hw/ppc/Makefile.objs: Build all
 boards conditinally with CONFIG_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_PPC405, CONFIG_PPC440, CONFIG_MAC_OLDWORLD, CONFIG_MAX_NEWWORLD
and CONFIG_VIRTEX configuration options created for
default-configs/ppc*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/ppc-softmmu.mak |  7 ++++++-
 hw/ppc/Makefile.objs            | 12 ++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 23d871fb3e..96088f47ca 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -34,7 +34,6 @@ CONFIG_M41T80=y
 CONFIG_VGA_CIRRUS=y
 
 # For Macs
-CONFIG_MAC=y
 CONFIG_ESCC=y
 CONFIG_MACIO=y
 CONFIG_MACIO_GPIO=y
@@ -69,3 +68,9 @@ CONFIG_PC87312=y
 CONFIG_PCSPK=y
 CONFIG_IDE_ISA=y
 CONFIG_CS4231A=y
+
+CONFIG_PPC405=y
+CONFIG_PPC440=y
+CONFIG_MAC_OLDWORLD=y
+CONFIG_MAC_NEWWORLD=y
+CONFIG_VIRTEX=
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 4e0c1c0941..2ce7973219 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -13,20 +13,20 @@ obj-y += spapr_pci_vfio.o
 endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
-obj-y += ppc4xx_devs.o ppc405_uc.o
-obj-$(CONFIG_PPC4XX) += ppc4xx_pci.o ppc405_boards.o
-obj-$(CONFIG_PPC4XX) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
+obj-$(CONFIG_PPC405) += ppc405_boards.o  ppc405_uc.o
+obj-$(CONFIG_PPC440) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
+obj-$(CONFIG_PPC4XX) += ppc4xx_pci.o ppc4xx_devs.o
 obj-$(CONFIG_SAM460EX) += sam460ex.o
 # PReP
 obj-$(CONFIG_PREP) += prep.o
 obj-$(CONFIG_PREP) += prep_systemio.o
 obj-${CONFIG_RS6000_MC} += rs6000_mc.o
 # OldWorld PowerMac
-obj-$(CONFIG_MAC) += mac_oldworld.o
+obj-$(CONFIG_MAC_OLDWORLD) += mac_oldworld.o
 # NewWorld PowerMac
-obj-$(CONFIG_MAC) += mac_newworld.o
+obj-$(CONFIG_MAC_NEWWORLD) += mac_newworld.o
 # e500
 obj-$(CONFIG_E500) += e500.o mpc8544ds.o e500plat.o
 obj-$(CONFIG_E500) += mpc8544_guts.o ppce500_spin.o
 # PowerPC 440 Xilinx ML507 reference board.
-obj-$(CONFIG_XILINX) += virtex_ml507.o
+obj-$(CONFIG_VIRTEX) += virtex_ml507.o
-- 
2.17.1
