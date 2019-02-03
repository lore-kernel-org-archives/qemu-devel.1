Received: from eggs.gnu.org ([209.51.188.92]:45201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqPvo-0002Ie-Fr
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqPvn-0006zK-8j
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqPvn-0006yh-30
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:08:03 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  3 Feb 2019 23:07:41 +0100
Message-Id: <20190203220744.11734-4-philmd@redhat.com>
In-Reply-To: <20190203220744.11734-1-philmd@redhat.com>
References: <20190203220744.11734-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] mips: Express dependencies of the r4k
 platform with kconfig
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

This platform use standard PC devices connected to an ISA bus.
Networking is provided by a ne2000 chipset.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips-softmmu-common.mak |  1 -
 hw/mips/Kconfig                         | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index a1681edec4..aa3ca196b4 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -31,7 +31,6 @@ CONFIG_MC146818RTC=3Dy
 CONFIG_EMPTY_SLOT=3Dy
 CONFIG_MIPS_CPS=3Dy
 CONFIG_MIPS_ITU=3Dy
-CONFIG_R4K=3Dy
 CONFIG_MALTA=3Dy
 CONFIG_ACPI_SMBUS=3Dy
 CONFIG_SMBUS_EEPROM=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index ab006477c7..ee6290d497 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -1,5 +1,15 @@
 config R4K
     bool
+    select ISA_BUS
+    select SERIAL_ISA
+    select I8259
+    select I8254
+    select MC146818RTC
+    select VGA_ISA
+    select NE2000_ISA
+    select IDE_ISA
+    # I8042
+    select PCKBD
=20
 config MALTA
     bool
--=20
2.20.1
