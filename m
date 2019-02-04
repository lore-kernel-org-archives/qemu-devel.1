Received: from eggs.gnu.org ([209.51.188.92]:34938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkpX-00085o-Ou
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkpX-0006ky-06
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqkpW-0006kU-Qk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:58 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 21:26:09 +0100
Message-Id: <20190204202609.26956-7-philmd@redhat.com>
In-Reply-To: <20190204202609.26956-1-philmd@redhat.com>
References: <20190204202609.26956-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/6] mips: Express dependencies of the
 Loongson 2E machine with kconfig
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

The Loongson 2E uses a Bonito64 system controller as North Bridge and a
VT82C686 chipset as South Bridge. The network card chipset is a RTL8139D.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips64el-softmmu.mak |  3 ---
 hw/isa/Kconfig                       | 13 +++++++++----
 hw/mips/Kconfig                      |  5 +++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index 9e80711275..326c5cd520 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -1,8 +1,5 @@
 # Default configuration for mips64el-softmmu
=20
 include mips-softmmu-common.mak
-CONFIG_IDE_VIA=3Dy
 CONFIG_FULONG=3Dy
-CONFIG_PCI_BONITO=3Dy
-CONFIG_VT82C686=3Dy
 CONFIG_MIPS_BOSTON=3Dy
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
