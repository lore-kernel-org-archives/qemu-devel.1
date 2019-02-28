Received: from eggs.gnu.org ([209.51.188.92]:36493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJZG-0001gG-MK
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJZF-0004UW-9X
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJZE-0004Mu-P6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id x7so8764007wmj.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.09.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:09:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:34 +0000
Message-Id: <20190228110835.16159-16-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/16] target/arm: Enable ARMv8.2-FHM for -cpu
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219222952.22183-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c   | 1 +
 target/arm/cpu64.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a3baf4eeed1..54b61f917be 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2020,6 +2020,7 @@ static void arm_max_initfn(Object *obj)
             t = cpu->isar.id_isar6;
             t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
             t = FIELD_DP32(t, ID_ISAR6, DP, 1);
+            t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
             cpu->isar.id_isar6 = t;
 
             t = cpu->id_mmfr4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 69e4134f79f..1b0c427277b 100644
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
2.20.1
