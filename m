Received: from eggs.gnu.org ([209.51.188.92]:36713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gp-0002qS-L8
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gn-0004Jo-Co
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:30 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gl-0004Ht-DV
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:29 -0500
Received: by mail-wr1-x441.google.com with SMTP id v16so2847211wrn.11
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:15:05 +0100
Message-Id: <1549390526-24246-56-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 55/76] hw/ppc/Makefile.objs: Build all boards
 conditinally with CONFIG_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>, Yang Zhong <yang.zhong@intel.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_PPC405, CONFIG_PPC440, CONFIG_MAC_OLDWORLD, CONFIG_MAX_NEWWORLD
and CONFIG_VIRTEX configuration options created for
default-configs/ppc*-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-12-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/ppc-softmmu.mak |  7 ++++++-
 hw/ppc/Makefile.objs            | 11 ++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 23d871f..7f80f0c 100644
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
index 1e753de..1111b21 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -13,19 +13,20 @@ obj-y += spapr_pci_vfio.o
 endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
-obj-$(CONFIG_PPC4XX) += ppc4xx_devs.o ppc4xx_pci.o ppc405_uc.o ppc405_boards.o
-obj-$(CONFIG_PPC4XX) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
+obj-$(CONFIG_PPC405) += ppc405_boards.o ppc405_uc.o
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
1.8.3.1
