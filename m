Received: from eggs.gnu.org ([209.51.188.92]:45405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqPwN-0002j1-Hi
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqPwK-0007Fo-5h
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqPw9-00077r-FW
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:29 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  3 Feb 2019 23:07:44 +0100
Message-Id: <20190203220744.11734-7-philmd@redhat.com>
In-Reply-To: <20190203220744.11734-1-philmd@redhat.com>
References: <20190203220744.11734-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] mips: Express dependencies of the Loongson
 2E machine with kconfig
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

The Loongson 2E uses a Bonito64 system controller as North Bridge and a
VT82C686 chipset as South Bridge. The network card chipset is a RTL8139D.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips64el-softmmu.mak |  4 ----
 hw/isa/Kconfig                       | 13 +++++++++----
 hw/mips/Kconfig                      |  5 +++++
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index ee583758e1..aa4f0d1a44 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -1,7 +1,3 @@
 # Default configuration for mips64el-softmmu
=20
 include mips-softmmu-common.mak
-CONFIG_IDE_VIA=3Dy
-CONFIG_FULONG=3Dy
-CONFIG_PCI_BONITO=3Dy
-CONFIG_VT82C686=3Dy
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index d580471c00..bd6f60dd3d 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -33,10 +33,15 @@ config PIIX4
=20
 config VT82C686
     bool
-    select ISA_BUS
-    select ACPI_SMBUS
-    select SERIAL_ISA
-    select FDC
+    select PCI
+    select I8259
+    select I8254
+    select I8257
+    select PARALLEL
+    select IDE_ISA
+    select IDE_VIA
+    select USB_UHCI
+    #select PCKBD
=20
 config SMC37C669
     bool
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 2940ff39ab..16b2bdb068 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -42,6 +42,11 @@ config JAZZ
=20
 config FULONG
     bool
+    select PCI_BONITO
+    select VT82C686
+    select SMBUS_EEPROM
+    select RTL8139_PCI
+    select MC146818RTC
=20
 config MIPS_CPS
     bool
--=20
2.20.1
