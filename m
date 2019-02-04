Received: from eggs.gnu.org ([209.51.188.92]:34773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkp8-0007iK-Nh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkp6-0006Wy-RT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqkp6-0006TG-LY
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:32 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 21:26:06 +0100
Message-Id: <20190204202609.26956-4-philmd@redhat.com>
In-Reply-To: <20190204202609.26956-1-philmd@redhat.com>
References: <20190204202609.26956-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/6] mips: Express dependencies of the r4k
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This platform use standard PC devices connected to an ISA bus.
Networking is provided by a ne2000 chipset.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

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
