Received: from eggs.gnu.org ([209.51.188.92]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9em-0004oY-Rj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ej-0006hs-Fm
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9ee-0006aF-G3
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id y5so181206wma.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.10
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:18 +0100
Message-Id: <20190429170030.11323-31-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/42] hw/dma: Compile the bcm2835_dma device as
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This device is used by both ARM (BCM2836, for raspi2) and AArch64
(BCM2837, for raspi3) targets, and is not CPU-specific.
Move it to common object, so we build it once for all targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190427133028.12874-1-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index 79affecc390..8b39f9c6004 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -14,4 +14,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zdma.o
 
 obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
-obj-$(CONFIG_RASPI) += bcm2835_dma.o
+common-obj-$(CONFIG_RASPI) += bcm2835_dma.o
-- 
2.20.1
