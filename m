Received: from eggs.gnu.org ([209.51.188.92]:34966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfc-0005BA-PA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfa-0001Yc-Ow
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfY-0001Vl-Og
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so26962613wrq.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:44 +0100
Message-Id: <20190416125744.27770-27-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 26/26] target/arm: Enable FPU for Cortex-M4 and
 Cortex-M33
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Enable the FPU by default for the Cortex-M4 and Cortex-M33.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dd6c4f6da8d..00d3299e212 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1494,8 +1494,12 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
+    cpu->isar.mvfr0 = 0x10110021;
+    cpu->isar.mvfr1 = 0x11000011;
+    cpu->isar.mvfr2 = 0x00000000;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
     cpu->id_dfr0 = 0x00100000;
@@ -1522,9 +1526,13 @@ static void cortex_m33_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fd213; /* r0p3 */
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
+    cpu->isar.mvfr0 = 0x10110021;
+    cpu->isar.mvfr1 = 0x11000011;
+    cpu->isar.mvfr2 = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000210;
     cpu->id_dfr0 = 0x00200000;
-- 
2.20.1
