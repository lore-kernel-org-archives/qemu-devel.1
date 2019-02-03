Received: from eggs.gnu.org ([209.51.188.92]:45166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqPvl-0002FN-1i
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqPvk-0006xm-6Z
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqPvk-0006xG-0q
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:00 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  3 Feb 2019 23:07:40 +0100
Message-Id: <20190203220744.11734-3-philmd@redhat.com>
In-Reply-To: <20190203220744.11734-1-philmd@redhat.com>
References: <20190203220744.11734-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] mips: Express dependencies of the Jazz
 machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The Jazz use the RC4030 Asic to provide an EISA bus and DMA/IRQ. The
framebuffer display is managed by a G364, the network card is a Sonic
DP83932. A QLogic ESP216 provides a SCSI bus.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips-softmmu-common.mak |  1 -
 default-configs/mips64-softmmu.mak      |  6 ------
 default-configs/mips64el-softmmu.mak    |  6 ------
 hw/mips/Kconfig                         | 17 +++++++++++++++++
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index aa73a4a822..a1681edec4 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -3,7 +3,6 @@
 CONFIG_ISA_BUS=3Dy
 CONFIG_PCI=3Dy
 CONFIG_PCI_DEVICES=3Dy
-CONFIG_ESP=3Dy
 CONFIG_VGA_ISA=3Dy
 CONFIG_VGA_ISA_MM=3Dy
 CONFIG_VGA_CIRRUS=3Dy
diff --git a/default-configs/mips64-softmmu.mak b/default-configs/mips64-=
softmmu.mak
index bad7496672..ea66ce0b72 100644
--- a/default-configs/mips64-softmmu.mak
+++ b/default-configs/mips64-softmmu.mak
@@ -1,9 +1,3 @@
 # Default configuration for mips64-softmmu
=20
 include mips-softmmu-common.mak
-CONFIG_RC4030=3Dy
-CONFIG_DP8393X=3Dy
-CONFIG_DS1225Y=3Dy
-CONFIG_JAZZ=3Dy
-CONFIG_G364FB=3Dy
-CONFIG_JAZZ_LED=3Dy
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index 8b255efc54..23445cfcf9 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -2,13 +2,7 @@
=20
 include mips-softmmu-common.mak
 CONFIG_IDE_VIA=3Dy
-CONFIG_RC4030=3Dy
-CONFIG_DP8393X=3Dy
-CONFIG_DS1225Y=3Dy
 CONFIG_FULONG=3Dy
-CONFIG_JAZZ=3Dy
-CONFIG_G364FB=3Dy
-CONFIG_JAZZ_LED=3Dy
 CONFIG_VT82C686=3Dy
 CONFIG_AHCI=3Dy
 CONFIG_MIPS_BOSTON=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 3433e97e1a..ab006477c7 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -12,6 +12,23 @@ config MIPSSIM
=20
 config JAZZ
     bool
+    select ISA_BUS
+    select RC4030
+    select I8259
+    select I8254
+    select I8257
+    select PCSPK
+    select VGA_ISA_MM
+    select G364FB
+    select DP8393X
+    select ESP
+    select FDC
+    select MC146818RTC
+    select PCKBD
+    select SERIAL
+    select PARALLEL
+    select DS1225Y
+    select JAZZ_LED
=20
 config FULONG
     bool
--=20
2.20.1
