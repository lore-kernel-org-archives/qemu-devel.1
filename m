Received: from eggs.gnu.org ([209.51.188.92]:47054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcG-0006rk-AX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRB-0006AT-0f
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:30 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFR9-00069M-BE
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:28 -0500
Received: by mail-ot1-x341.google.com with SMTP id g16so12158073otg.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:07 -0800
Message-Id: <20190128223118.5255-2-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 01/12] target/arm: Introduce
 isar_feature_aa64_bti
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

Also create field definitions for id_aa64pfr1 from ARMv8.5.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Include MTE and RAS_FRAC fields of AA64PFR1.
---
 target/arm/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ff81db420d..d7190f0712 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1672,6 +1672,11 @@ FIELD(ID_AA64PFR0, GIC, 24, 4)
 FIELD(ID_AA64PFR0, RAS, 28, 4)
 FIELD(ID_AA64PFR0, SVE, 32, 4)
 
+FIELD(ID_AA64PFR1, BT, 0, 4)
+FIELD(ID_AA64PFR1, SBSS, 4, 4)
+FIELD(ID_AA64PFR1, MTE, 8, 4)
+FIELD(ID_AA64PFR1, RAS_FRAC, 12, 4)
+
 FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
 FIELD(ID_AA64MMFR0, ASIDBITS, 4, 4)
 FIELD(ID_AA64MMFR0, BIGEND, 8, 4)
@@ -3319,6 +3324,11 @@ static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
 }
 
+static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
-- 
2.17.2
