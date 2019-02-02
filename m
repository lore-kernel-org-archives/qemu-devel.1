Received: from eggs.gnu.org ([209.51.188.92]:50257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppfn-0000WB-Vz
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppfn-0002dV-4i
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:56070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gppfm-0002Ky-Mm
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:25:07 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Sat,  2 Feb 2019 15:24:40 +0800
Message-Id: <20190202072456.6468-12-yang.zhong@intel.com>
In-Reply-To: <20190202072456.6468-1-yang.zhong@intel.com>
References: <20190202072456.6468-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/27] hw/ppc/Makefile.objs: Build all
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
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_PPC405, CONFIG_PPC440, CONFIG_MAC_OLDWORLD, CONFIG_MAX_NEWWORLD
and CONFIG_VIRTEX configuration options created for
default-configs/ppc*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc-softmmu.mak |  7 ++++++-
 hw/ppc/Makefile.objs            | 11 ++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 23d871fb3e..7f80f0ccba 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -21,6 +21,10 @@ CONFIG_E500=y
 CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
 CONFIG_PLATFORM_BUS=y
 CONFIG_ETSEC=y
+CONFIG_PPC405=y
+CONFIG_PPC440=y
+CONFIG_VIRTEX=y
+
 # For Sam460ex
 CONFIG_SAM460EX=y
 CONFIG_USB_EHCI_SYSBUS=y
@@ -34,7 +38,6 @@ CONFIG_M41T80=y
 CONFIG_VGA_CIRRUS=y
 
 # For Macs
-CONFIG_MAC=y
 CONFIG_ESCC=y
 CONFIG_MACIO=y
 CONFIG_MACIO_GPIO=y
@@ -50,6 +53,8 @@ CONFIG_GRACKLE_PCI=y
 CONFIG_UNIN_PCI=y
 CONFIG_DEC_PCI=y
 CONFIG_IDE_MACIO=y
+CONFIG_MAC_OLDWORLD=y
+CONFIG_MAC_NEWWORLD=y
 
 # For PReP
 CONFIG_PREP=y
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 4e0c1c0941..7d815b7d57 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -14,19 +14,20 @@ endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
 obj-y += ppc4xx_devs.o ppc405_uc.o
-obj-$(CONFIG_PPC4XX) += ppc4xx_pci.o ppc405_boards.o
-obj-$(CONFIG_PPC4XX) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
+obj-$(CONFIG_PPC405) += ppc405_boards.o
+obj-$(CONFIG_PPC440) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
+obj-$(CONFIG_PPC4XX) += ppc4xx_pci.o
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
