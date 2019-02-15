Received: from eggs.gnu.org ([209.51.188.92]:33385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guj4y-0005Tt-LR
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guj4w-0003VA-3G
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:18 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1guj4v-0003Sh-GW
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:17 -0500
Received: by mail-pl1-x644.google.com with SMTP id k15so5404441pls.8
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:23:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Feb 2019 11:23:02 -0800
Message-Id: <20190215192302.27855-9-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-1-richard.henderson@linaro.org>
References: <20190215192302.27855-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 8/8] target/arm: Enable ARMv8.2-FHM for -cpu
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
