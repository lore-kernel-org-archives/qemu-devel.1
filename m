Received: from eggs.gnu.org ([209.51.188.92]:45064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNLXz-0005nB-Aa
	for qemu-devel@nongnu.org; Sun, 05 May 2019 14:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNLXy-0002ZT-ER
	for qemu-devel@nongnu.org; Sun, 05 May 2019 14:07:35 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  5 May 2019 20:07:18 +0200
Message-Id: <20190505180719.31913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/timer: Compile devices not target-dependent
 as common objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

All these devices do not contain any target-specific code. While
most of them are arch-specific, they are shared between different
targets of the same arch family (ARM and AArch64, MIPS32/MIPS64,
multiple endianess, ...).
Put them into common-obj-y to compile them once for all targets.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/Makefile.objs | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 0e9a4530f84..a92e22938cb 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -25,20 +25,20 @@ common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.=
o
 common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
 common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_timer.o
=20
-obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_pwm.o
-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
-obj-$(CONFIG_OMAP) +=3D omap_gptimer.o
-obj-$(CONFIG_OMAP) +=3D omap_synctimer.o
-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_timer.o
-obj-$(CONFIG_SH4) +=3D sh_timer.o
-obj-$(CONFIG_DIGIC) +=3D digic-timer.o
-obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
+common-obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
+common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
+common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_pwm.o
+common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
+common-obj-$(CONFIG_OMAP) +=3D omap_gptimer.o
+common-obj-$(CONFIG_OMAP) +=3D omap_synctimer.o
+common-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_timer.o
+common-obj-$(CONFIG_SH4) +=3D sh_timer.o
+common-obj-$(CONFIG_DIGIC) +=3D digic-timer.o
+common-obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
=20
 obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
=20
-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
+common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
=20
 common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
--=20
2.20.1
