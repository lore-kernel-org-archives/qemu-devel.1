Received: from eggs.gnu.org ([209.51.188.92]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38HI-0004gU-Sl
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38HH-0002PR-W3
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38HH-0002Ol-MU
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:47 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:47 +0100
Message-Id: <20190310235351.1863-5-philmd@redhat.com>
In-Reply-To: <20190310235351.1863-1-philmd@redhat.com>
References: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/8] hw/southbridge: Add the PIIX3 chipset to
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The PIIX3 (Intel 82371SB) is a bridge between PCI <-> ISA.

It is an exhanced PIIX, thus contains the same features.
It also contains:
 - separate Master/Slave IDE mode
 - compliant to PCI rev 2.1 specifications
 - IOAPIC
 - USB UHCI (2 ports)
 - USB Legacy Support (emulated devices):
   - 8042 Keyboard Controller
   - A20-Gate

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 681e6f1bce..f8494edd67 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -37,6 +37,15 @@ config PIIX
     #select NMI_PIIX
     select ISA_BUS
=20
+config PIIX3
+    bool
+    select PIIX
+    #select PCI_PIIX3
+    #select IDE_PIIX3
+    select IOAPIC
+    select USB_UHCI
+    select I8042
+
 config PIIX4
     bool
     # For historical reasons, SuperIO devices are created in the board
--=20
2.20.1
