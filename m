Received: from eggs.gnu.org ([209.51.188.92]:42666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Hn-0005Er-Vi
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Hn-0002l3-9v
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38Hn-0002kf-3f
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:19 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:51 +0100
Message-Id: <20190310235351.1863-9-philmd@redhat.com>
In-Reply-To: <20190310235351.1863-1-philmd@redhat.com>
References: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 8/8] hw/i386: Move ACPI_SMBUS out of I440FX
 (Kconfig)
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

The SMBus interface is a slow bus not related to the i440fx
northbridge, it comes from the PIIX3 southbridge.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 56e72abb8c..9ac833b930 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -51,7 +51,6 @@ config I440FX
     bool
     select PC_PCI
     select PC_ACPI
-    select ACPI_SMBUS
     select DIMM
     select SMBIOS
     select VMPORT
@@ -68,6 +67,7 @@ config ISAPC
     select PIIX3
     # QEMU isapc weirdness: it uses PIIX3 with ACPI features from PIIX4
     select ACPI_PIIX4
+    select ACPI_SMBUS
=20
 config Q35
     bool
--=20
2.20.1
