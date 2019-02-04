Received: from eggs.gnu.org ([209.51.188.92]:34801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkpA-0007kI-L9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkp8-0006Y8-PW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqkp6-0006UZ-Sh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:34 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 21:26:07 +0100
Message-Id: <20190204202609.26956-5-philmd@redhat.com>
In-Reply-To: <20190204202609.26956-1-philmd@redhat.com>
References: <20190204202609.26956-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/6] mips: Express dependencies of the
 Boston machine with kconfig
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

Boston is built around a Xilinx FPGA, which includes a PCIe root port
and an UART. An Intel EG20T PCH connects the I/O peripherals, but only
the SATA bus is emulated.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips64el-softmmu.mak | 4 ----
 hw/mips/Kconfig                      | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips6=
4el-softmmu.mak
index 23445cfcf9..c6f1f9c9aa 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -4,8 +4,4 @@ include mips-softmmu-common.mak
 CONFIG_IDE_VIA=3Dy
 CONFIG_FULONG=3Dy
 CONFIG_VT82C686=3Dy
-CONFIG_AHCI=3Dy
 CONFIG_MIPS_BOSTON=3Dy
-CONFIG_FITLOADER=3Dy
-CONFIG_PCI_EXPRESS=3Dy
-CONFIG_PCI_EXPRESS_XILINX=3Dy
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index ee6290d497..2940ff39ab 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -49,3 +49,8 @@ config MIPS_CPS
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
