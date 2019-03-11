Received: from eggs.gnu.org ([209.51.188.92]:51800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39Fa-0007Fs-Dn
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39FZ-0007HA-Jn
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h39FZ-0007FO-DV
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:57:05 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:56:15 +0100
Message-Id: <20190311005618.19007-5-philmd@redhat.com>
In-Reply-To: <20190311005618.19007-1-philmd@redhat.com>
References: <20190311005618.19007-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/7] hw/mips: Remove the redundant
 CONFIG_MIPS_ITU Makefile variable
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

The Inter-Thread Communication Unit (ITU, introduced in commit
34fa7e83e11) is part of the Coherent Processing System (CPS),
as describe in commit 408294352ad:

    Make ITU available in the system if CPU supports multithreading
    and is part of CPS.

Replate the CONFIG_MIPS_ITU variable by the CONFIG_MIPS_CPS one.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips-softmmu-common.mak | 1 -
 hw/misc/Kconfig                         | 3 ---
 hw/misc/Makefile.objs                   | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index 2ca57bfee1..c5b148b1c6 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -29,7 +29,6 @@ CONFIG_I8259=3Dy
 CONFIG_MC146818RTC=3Dy
 CONFIG_EMPTY_SLOT=3Dy
 CONFIG_MIPS_CPS=3Dy
-CONFIG_MIPS_ITU=3Dy
 CONFIG_R4K=3Dy
 CONFIG_MALTA=3Dy
 CONFIG_MIPSSIM=3Dy
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2c60be99bc..3125cf86f2 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -80,9 +80,6 @@ config IMX
 config STM32F2XX_SYSCFG
     bool
=20
-config MIPS_ITU
-    bool
-
 config MPS2_FPGAIO
     bool
=20
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c71e07ae35..22565d72af 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -59,7 +59,7 @@ obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
 obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.o
 obj-$(CONFIG_MIPS_CPS) +=3D mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) +=3D mips_cpc.o
-obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
+obj-$(CONFIG_MIPS_CPS) +=3D mips_itu.o
 obj-$(CONFIG_MPS2_FPGAIO) +=3D mps2-fpgaio.o
 obj-$(CONFIG_MPS2_SCC) +=3D mps2-scc.o
=20
--=20
2.20.1
