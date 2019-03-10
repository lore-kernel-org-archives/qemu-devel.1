Received: from eggs.gnu.org ([209.51.188.92]:42543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38HO-0004nf-PQ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38HO-0002Te-2M
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38HN-0002TK-Sd
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:54 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:48 +0100
Message-Id: <20190310235351.1863-6-philmd@redhat.com>
In-Reply-To: <20190310235351.1863-1-philmd@redhat.com>
References: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/8] hw/southbridge: Cleanup the PIIX4 chipset
 in Kconfig
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

The PIIX4 (Intel 82371AB) is a bridge between PCI <-> ISA.

It is an exhanced PIIX3, thus contains the same features.
It also contains:
 - Power Management (ACPI rev 1.0)
 - IDE UDMA/33
 - SMBus interface (host and slave)
 - RTC

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index f8494edd67..1c923dfd07 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -48,9 +48,13 @@ config PIIX3
=20
 config PIIX4
     bool
+    select PIIX3
+    #select ACPI_PIIX4
+    #select IDE_PIIX4
+    select ACPI_SMBUS
+    select MC146818RTC
     # For historical reasons, SuperIO devices are created in the board
     # for PIIX4.
-    select ISA_BUS
=20
 config VT82C686
     bool
--=20
2.20.1
