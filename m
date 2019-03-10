Received: from eggs.gnu.org ([209.51.188.92]:42644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Hk-0005Bd-1O
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Hi-0002is-UR
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38Hi-0002iL-O6
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:14 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:50 +0100
Message-Id: <20190310235351.1863-8-philmd@redhat.com>
In-Reply-To: <20190310235351.1863-1-philmd@redhat.com>
References: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/8] hw/i386: The 'isapc' machine is built
 around a PIIX3 southbridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index f6b74e2dc0..56e72abb8c 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -52,8 +52,6 @@ config I440FX
     select PC_PCI
     select PC_ACPI
     select ACPI_SMBUS
-    select PCI_PIIX
-    select IDE_PIIX
     select DIMM
     select SMBIOS
     select VMPORT
@@ -62,13 +60,12 @@ config I440FX
=20
 config ISAPC
     bool
-    select ISA_BUS
     select PC
-    select IDE_ISA
     select VGA_ISA
     # FIXME: it is in the same file as i440fx, and does not compile
     # if separated
     depends on I440FX
+    select PIIX3
     # QEMU isapc weirdness: it uses PIIX3 with ACPI features from PIIX4
     select ACPI_PIIX4
=20
--=20
2.20.1
