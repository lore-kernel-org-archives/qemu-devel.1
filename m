Received: from eggs.gnu.org ([209.51.188.92]:42508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38HI-0004gB-H3
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38HH-0002P3-Il
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:48 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:46 +0100
Message-Id: <20190310235351.1863-4-philmd@redhat.com>
In-Reply-To: <20190310235351.1863-1-philmd@redhat.com>
References: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/8] hw/southbridge: Add the PIIX chipset to
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

The PIIX (Intel 82371FB) is a bridge between PCI <-> ISA.

It contains:
 - IDE interface (PIO and burst transfers)
 - one 82c54 timer (and speaker tone output)
 - two 82c59 interrupts controllers
 - two 8237 DMA controllers
 - Power Management (programmable SMI)
 - NMI

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ide/Kconfig |  1 +
 hw/isa/Kconfig | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index ab47b6a7a3..1d997240c1 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -17,6 +17,7 @@ config IDE_ISA
=20
 config IDE_PIIX
     bool
+    select IDE_ISA
     select IDE_PCI
     select IDE_QDEV
=20
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 57e09a0cb8..681e6f1bce 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -24,6 +24,19 @@ config PC87312
     select FDC
     select IDE_ISA
=20
+config PIIX
+    bool
+    select PCI_PIIX
+    select IDE_PIIX
+    select I8254
+    select I8259
+    select PCSPK
+    select I8257
+    #select PM_PIIX
+    #select SMI_PIIX
+    #select NMI_PIIX
+    select ISA_BUS
+
 config PIIX4
     bool
     # For historical reasons, SuperIO devices are created in the board
--=20
2.20.1
