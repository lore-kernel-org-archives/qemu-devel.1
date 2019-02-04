Received: from eggs.gnu.org ([209.51.188.92]:34772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkp8-0007iJ-Nh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkp6-0006Ws-Oi
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqkp6-0006QH-Gx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:32 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 21:26:04 +0100
Message-Id: <20190204202609.26956-2-philmd@redhat.com>
In-Reply-To: <20190204202609.26956-1-philmd@redhat.com>
References: <20190204202609.26956-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/6] mips: Express dependencies of the
 MIPSsim machine with kconfig
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

The MIPSsim machine only emulates an 8250 UART and a simple network
controller, connected via an ISA bus.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips-softmmu-common.mak | 1 -
 hw/mips/Kconfig                         | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index 0795d522db..8c5fdf5ee1 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -26,7 +26,6 @@ CONFIG_PIIX4=3Dy
 CONFIG_IDE_ISA=3Dy
 CONFIG_IDE_PIIX=3Dy
 CONFIG_NE2000_ISA=3Dy
-CONFIG_MIPSNET=3Dy
 CONFIG_PFLASH_CFI01=3Dy
 CONFIG_I8259=3Dy
 CONFIG_MC146818RTC=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index cdc07e59b6..3433e97e1a 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -6,6 +6,9 @@ config MALTA
=20
 config MIPSSIM
     bool
+    select ISA_BUS
+    select SERIAL_ISA
+    select MIPSNET
=20
 config JAZZ
     bool
--=20
2.20.1
