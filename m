Received: from eggs.gnu.org ([209.51.188.92]:56145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHn-0004g4-S7
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHk-0007kA-De
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZHk-0007jq-5c
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:08 -0500
Received: by mail-pl1-x644.google.com with SMTP id u6so5107838plm.8
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:18:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:17:34 +1100
Message-Id: <20190110121736.23448-10-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-1-richard.henderson@linaro.org>
References: <20190110121736.23448-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/11] target/arm: Enable BTI for -cpu max
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
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 713d2d5579..64fbe75eca 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -372,6 +372,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
         cpu->isar.id_aa64pfr0 = t;
 
+        t = cpu->isar.id_aa64pfr1;
+        t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+        cpu->isar.id_aa64pfr1 = t;
+
         t = cpu->isar.id_aa64mmfr1;
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
-- 
2.17.2
