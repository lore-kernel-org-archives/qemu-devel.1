Received: from eggs.gnu.org ([209.51.188.92]:45892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDtw-0000Kn-AB
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDts-0002VA-MN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:06 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwDtq-0002Sx-RJ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:03 -0500
Received: by mail-pg1-x542.google.com with SMTP id h11so8440055pgl.0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 14:30:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 14:29:51 -0800
Message-Id: <20190219222952.22183-5-richard.henderson@linaro.org>
In-Reply-To: <20190219222952.22183-1-richard.henderson@linaro.org>
References: <20190219222952.22183-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 4/5] target/arm: Enable ARMv8.2-FHM for -cpu
 max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 1 +
 target/arm/cpu64.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8ea6569088..b9fa548718 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2003,6 +2003,7 @@ static void arm_max_initfn(Object *obj)
             t = cpu->isar.id_isar6;
             t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
+            t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
             cpu->isar.id_isar6 = t;
 
             t = cpu->id_mmfr4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 69e4134f79..1b0c427277 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -308,6 +308,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
@@ -347,6 +348,7 @@ static void aarch64_max_initfn(Object *obj)
         u = cpu->isar.id_isar6;
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
+        u = FIELD_DP32(u, ID_ISAR6, FHM, 1);
         cpu->isar.id_isar6 = u;
 
         /*
-- 
2.17.2
