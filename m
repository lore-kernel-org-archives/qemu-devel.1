Received: from eggs.gnu.org ([209.51.188.92]:33458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKNPd-000624-HF
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKNPc-00025b-NK
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:30:41 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 15:30:28 +0200
Message-Id: <20190427133028.12874-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/dma: Compile the bcm2835_dma device as
 common object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This device is used by both ARM (BCM2836, for raspi2) and AArch64
(BCM2837, for raspi3) targets, and is not CPU-specific.
Move it to common object, so we build it once for all targets.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/dma/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index 79affecc390..8b39f9c6004 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -14,4 +14,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zdma.o
=20
 obj-$(CONFIG_OMAP) +=3D omap_dma.o soc_dma.o
 obj-$(CONFIG_PXA2XX) +=3D pxa2xx_dma.o
-obj-$(CONFIG_RASPI) +=3D bcm2835_dma.o
+common-obj-$(CONFIG_RASPI) +=3D bcm2835_dma.o
--=20
2.20.1
