Received: from eggs.gnu.org ([209.51.188.92]:51879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39Ft-0007Ue-4q
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39Fs-0007TU-Dn
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h39Fs-0007TA-7p
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:24 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:56:17 +0100
Message-Id: <20190311005618.19007-7-philmd@redhat.com>
In-Reply-To: <20190311005618.19007-1-philmd@redhat.com>
References: <20190311005618.19007-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/7] hw/pci-host: Use CONFIG_PCI_BONITO to
 select the Bonito North Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: James Hogan <jhogan@kernel.org>, Yang Zhong <yang.zhong@intel.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Ease the kconfig selection by introducing CONFIG_PCI_BONITO to select
the Bonito North Bridge.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips64el-softmmu.mak | 1 +
 hw/pci-host/Kconfig                  | 4 ++++
 hw/pci-host/Makefile.objs            | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index c7409d23d2..88b66a91d7 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -3,6 +3,7 @@
 include mips-softmmu-common.mak
 CONFIG_IDE_VIA=3Dy
 CONFIG_FULONG=3Dy
+CONFIG_PCI_BONITO=3Dy
 CONFIG_JAZZ=3Dy
 CONFIG_VT82C686=3Dy
 CONFIG_MIPS_BOSTON=3Dy
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index b39ea297ba..9abadafaf5 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -49,3 +49,7 @@ config PCI_EXPRESS_XILINX
 config PCI_EXPRESS_DESIGNWARE
     bool
     select PCI_EXPRESS
+
+config PCI_BONITO
+    select PCI
+    bool
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index a9cd3e022d..d6e86b9b89 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -12,7 +12,7 @@ common-obj-$(CONFIG_PPCE500_PCI) +=3D ppce500.o
 common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
=20
 common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
-common-obj-$(CONFIG_FULONG) +=3D bonito.o
+common-obj-$(CONFIG_PCI_BONITO) +=3D bonito.o
 common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
--=20
2.20.1
