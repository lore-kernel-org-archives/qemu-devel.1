Received: from eggs.gnu.org ([209.51.188.92]:34864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkpG-0007q6-Fd
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkpE-0006bh-LT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqkpC-0006Zy-Oj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 21:26:08 +0100
Message-Id: <20190204202609.26956-6-philmd@redhat.com>
In-Reply-To: <20190204202609.26956-1-philmd@redhat.com>
References: <20190204202609.26956-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/6] hw/pci-host: Use CONFIG_PCI_BONITO to
 select the Bonito North Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

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
index c6f1f9c9aa..9e80711275 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -3,5 +3,6 @@
 include mips-softmmu-common.mak
 CONFIG_IDE_VIA=3Dy
 CONFIG_FULONG=3Dy
+CONFIG_PCI_BONITO=3Dy
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
