Received: from eggs.gnu.org ([209.51.188.92]:50565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUtJ-0008Q8-Fe
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goUt5-0003ck-I3
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:01:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goUt2-0003bq-Pf
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:01:19 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 16:00:25 +0100
Message-Id: <20190129150029.29829-2-philmd@redhat.com>
In-Reply-To: <20190129150029.29829-1-philmd@redhat.com>
References: <20190129150029.29829-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/5] hw/lm32: Move LM32 specific hardware
 out of common-obj list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The LM32 specific hardware is only used by the LM32 target,
it is pointless to compile those objects in other targets.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/audio/Makefile.objs   | 2 +-
 hw/char/Makefile.objs    | 6 +++---
 hw/display/Makefile.objs | 4 ++--
 hw/intc/Makefile.objs    | 2 +-
 hw/timer/Makefile.objs   | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
index 63db383709..c771797c2d 100644
--- a/hw/audio/Makefile.objs
+++ b/hw/audio/Makefile.objs
@@ -13,6 +13,6 @@ common-obj-$(CONFIG_PL041) +=3D pl041.o lm4549.o
=20
 common-obj-$(CONFIG_CS4231) +=3D cs4231.o
 common-obj-$(CONFIG_MARVELL_88W8618) +=3D marvell_88w8618.o
-common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-ac97.o
+obj-$(CONFIG_MILKYMIST) +=3D milkymist-ac97.o
=20
 common-obj-y +=3D soundhw.o
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index c4947d7ae7..2c8999a910 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -26,9 +26,9 @@ common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
 common-obj-$(CONFIG_ISA_DEBUG) +=3D debugcon.o
 common-obj-$(CONFIG_GRLIB) +=3D grlib_apbuart.o
 common-obj-$(CONFIG_IMX) +=3D imx_serial.o
-common-obj-$(CONFIG_LM32) +=3D lm32_juart.o
-common-obj-$(CONFIG_LM32) +=3D lm32_uart.o
-common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-uart.o
+obj-$(CONFIG_LM32) +=3D lm32_juart.o
+obj-$(CONFIG_LM32) +=3D lm32_uart.o
+obj-$(CONFIG_MILKYMIST) +=3D milkymist-uart.o
 common-obj-$(CONFIG_SCLPCONSOLE) +=3D sclpconsole.o sclpconsole-lm.o
=20
 obj-$(CONFIG_VIRTIO) +=3D virtio-serial-bus.o
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 97acd5b6cb..5b770817c7 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -25,10 +25,10 @@ common-obj-$(CONFIG_BOCHS_DISPLAY) +=3D edid-region.o
 common-obj-$(CONFIG_BLIZZARD) +=3D blizzard.o
 common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_fimd.o
 common-obj-$(CONFIG_FRAMEBUFFER) +=3D framebuffer.o
-common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
+obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
=20
-common-obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
+obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
 milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS)
 milkymist-tmu2.o-libs :=3D $(X11_LIBS)
=20
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 301a8e972d..82bbbefdeb 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -7,7 +7,7 @@ common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-pmu-iomod-intc=
.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-ipi.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_pic.o
 common-obj-$(CONFIG_IMX) +=3D imx_avic.o imx_gpcv2.o
-common-obj-$(CONFIG_LM32) +=3D lm32_pic.o
+obj-$(CONFIG_LM32) +=3D lm32_pic.o
 common-obj-$(CONFIG_REALVIEW) +=3D realview_gic.o
 common-obj-$(CONFIG_SLAVIO) +=3D slavio_intctl.o
 common-obj-$(CONFIG_IOAPIC) +=3D ioapic_common.o
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 0e9a4530f8..3a7740f447 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -20,8 +20,8 @@ common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_timer.o
 common-obj-$(CONFIG_GRLIB) +=3D grlib_gptimer.o
 common-obj-$(CONFIG_IMX) +=3D imx_epit.o
 common-obj-$(CONFIG_IMX) +=3D imx_gpt.o
-common-obj-$(CONFIG_LM32) +=3D lm32_timer.o
-common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
+obj-$(CONFIG_LM32) +=3D lm32_timer.o
+obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
 common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_timer.o
=20
--=20
2.20.1
