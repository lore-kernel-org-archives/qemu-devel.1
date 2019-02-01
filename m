Received: from eggs.gnu.org ([209.51.188.92]:59033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbME-0008H2-4T
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0003jk-1i
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:58 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMA-0003JC-LC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:54 -0500
Received: by mail-wm1-x334.google.com with SMTP id y139so6605566wmc.5
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.06
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:14 +0000
Message-Id: <20190201160653.13829-9-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/47] hw/arm/iotkit: Rename files to
 hw/arm/armsse.[ch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rename the files that used to be iotkit.[ch] to
armsse.[ch] to reflect the fact they new cover
multiple Arm subsystems for embedded.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190121185118.18550-8-peter.maydell@linaro.org
---
 hw/arm/Makefile.objs                  | 2 +-
 include/hw/arm/{iotkit.h => armsse.h} | 4 ++--
 hw/arm/{iotkit.c => armsse.c}         | 2 +-
 hw/arm/mps2-tz.c                      | 2 +-
 MAINTAINERS                           | 4 ++--
 default-configs/arm-softmmu.mak       | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename include/hw/arm/{iotkit.h => armsse.h} (99%)
 rename hw/arm/{iotkit.c => armsse.c} (99%)

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 50c7b4a927d..22b7f0ed0ba 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -34,7 +34,7 @@ obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) += mps2.o
 obj-$(CONFIG_MPS2) += mps2-tz.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
-obj-$(CONFIG_IOTKIT) += iotkit.o
+obj-$(CONFIG_ARMSSE) += armsse.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
 obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
 obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o mcimx6ul-evk.o
diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/armsse.h
similarity index 99%
rename from include/hw/arm/iotkit.h
rename to include/hw/arm/armsse.h
index 521d1f73757..ff512054988 100644
--- a/include/hw/arm/iotkit.h
+++ b/include/hw/arm/armsse.h
@@ -58,8 +58,8 @@
  *  + named GPIO outputs mscexp_ns[0..15]
  */
 
-#ifndef IOTKIT_H
-#define IOTKIT_H
+#ifndef ARMSSE_H
+#define ARMSSE_H
 
 #include "hw/sysbus.h"
 #include "hw/arm/armv7m.h"
diff --git a/hw/arm/iotkit.c b/hw/arm/armsse.c
similarity index 99%
rename from hw/arm/iotkit.c
rename to hw/arm/armsse.c
index 7ff14fd5aef..8554be14128 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/armsse.c
@@ -15,7 +15,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
-#include "hw/arm/iotkit.h"
+#include "hw/arm/armsse.h"
 #include "hw/arm/arm.h"
 
 struct ARMSSEInfo {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 5824335b4fb..3859f17d98b 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -46,7 +46,7 @@
 #include "hw/misc/mps2-fpgaio.h"
 #include "hw/misc/tz-mpc.h"
 #include "hw/misc/tz-msc.h"
-#include "hw/arm/iotkit.h"
+#include "hw/arm/armsse.h"
 #include "hw/dma/pl080.h"
 #include "hw/ssi/pl022.h"
 #include "hw/devices.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 234e5c413bd..c2ad4e52c9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -623,8 +623,8 @@ F: hw/arm/mps2.c
 F: hw/arm/mps2-tz.c
 F: hw/misc/mps2-*.c
 F: include/hw/misc/mps2-*.h
-F: hw/arm/iotkit.c
-F: include/hw/arm/iotkit.h
+F: hw/arm/armsse.c
+F: include/hw/arm/armsse.h
 F: hw/misc/iotkit-secctl.c
 F: include/hw/misc/iotkit-secctl.h
 F: hw/misc/iotkit-sysctl.c
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 2420491aacd..3f200157879 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -114,7 +114,7 @@ CONFIG_MPS2_SCC=y
 CONFIG_TZ_MPC=y
 CONFIG_TZ_MSC=y
 CONFIG_TZ_PPC=y
-CONFIG_IOTKIT=y
+CONFIG_ARMSSE=y
 CONFIG_IOTKIT_SECCTL=y
 CONFIG_IOTKIT_SYSCTL=y
 CONFIG_IOTKIT_SYSINFO=y
-- 
2.20.1
