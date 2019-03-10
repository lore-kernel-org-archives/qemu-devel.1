Received: from eggs.gnu.org ([209.51.188.92]:42398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Gq-0004N8-4U
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38Gp-0002CX-EQ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38Gp-0002CC-81
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:54:19 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:44 +0100
Message-Id: <20190310235351.1863-2-philmd@redhat.com>
In-Reply-To: <20190310235351.1863-1-philmd@redhat.com>
References: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/8] hw/i2c: The ACPI_SMBUS Kconfig depends on
 ACPI
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i2c/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index ef1caa6d89..ec62909fa1 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -17,6 +17,7 @@ config VERSATILE_I2C
 config ACPI_SMBUS
     bool
     select I2C
+    depends on ACPI
=20
 config BITBANG_I2C
     bool
--=20
2.20.1
