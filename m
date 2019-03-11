Received: from eggs.gnu.org ([209.51.188.92]:51948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39G0-0007bK-OT
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39G0-0007Yb-1f
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h39Fz-0007Y7-Ro
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:31 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:56:18 +0100
Message-Id: <20190311005618.19007-8-philmd@redhat.com>
In-Reply-To: <20190311005618.19007-1-philmd@redhat.com>
References: <20190311005618.19007-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 7/7] hw/mips: Express dependencies of the
 Fulong 2E machine with Kconfig
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

The Fulong 2E machine uses a Loongson 2E as CPU, a Bonito64 system
controller as North Bridge and a VT82C686 chipset as South Bridge.
The network card chipset is a RTL8139D.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: Loongson 2E =3D CPU, Fulong 2E =3D machine (Aleksandar)
---
 default-configs/mips64el-softmmu.mak |  3 ---
 hw/isa/Kconfig                       | 13 +++++++++----
 hw/mips/Kconfig                      |  5 +++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index 88b66a91d7..d0814e76af 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -1,9 +1,6 @@
 # Default configuration for mips64el-softmmu
=20
 include mips-softmmu-common.mak
-CONFIG_IDE_VIA=3Dy
 CONFIG_FULONG=3Dy
-CONFIG_PCI_BONITO=3Dy
 CONFIG_JAZZ=3Dy
-CONFIG_VT82C686=3Dy
 CONFIG_MIPS_BOSTON=3Dy
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 57e09a0cb8..30055aed82 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -32,10 +32,15 @@ config PIIX4
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
index bd6e3be2cd..b06d70bf01 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -43,6 +43,11 @@ config JAZZ
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
