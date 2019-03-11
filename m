Received: from eggs.gnu.org ([209.51.188.92]:51834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39Fi-0007N7-Pr
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39Fi-0007N2-1f
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h39Fh-0007Mi-S2
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:13 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:56:16 +0100
Message-Id: <20190311005618.19007-6-philmd@redhat.com>
In-Reply-To: <20190311005618.19007-1-philmd@redhat.com>
References: <20190311005618.19007-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/7] hw/mips: Express dependencies of the
 Boston machine with Kconfig
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

Boston is built around a Xilinx FPGA, which includes a PCIe root port
and an UART. An Intel EG20T PCH connects the I/O peripherals, but only
the SATA bus is emulated.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Paul Burton <pburton@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips64el-softmmu.mak | 4 ----
 hw/mips/Kconfig                      | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index a7b88318b2..c7409d23d2 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -5,8 +5,4 @@ CONFIG_IDE_VIA=3Dy
 CONFIG_FULONG=3Dy
 CONFIG_JAZZ=3Dy
 CONFIG_VT82C686=3Dy
-CONFIG_AHCI=3Dy
 CONFIG_MIPS_BOSTON=3Dy
-CONFIG_FITLOADER=3Dy
-CONFIG_PCI_EXPRESS=3Dy
-CONFIG_PCI_EXPRESS_XILINX=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 5678c9cf15..bd6e3be2cd 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -50,3 +50,8 @@ config MIPS_CPS
=20
 config MIPS_BOSTON
     bool
+    select FITLOADER
+    select MIPS_CPS
+    select PCI_EXPRESS_XILINX
+    select AHCI
+    select SERIAL
--=20
2.20.1
