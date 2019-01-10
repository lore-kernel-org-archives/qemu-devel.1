Received: from eggs.gnu.org ([209.51.188.92]:55846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHQ-0004Qt-Ne
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHQ-0007Tr-1Z
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:48 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZHP-0007Sd-Rl
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:17:47 -0500
Received: by mail-pg1-x542.google.com with SMTP id j10so4776284pga.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:17:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:17:26 +1100
Message-Id: <20190110121736.23448-2-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-1-richard.henderson@linaro.org>
References: <20190110121736.23448-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/11] target/arm: Introduce
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8512ca3552..fadb74d9a6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1630,6 +1630,9 @@ FIELD(ID_AA64PFR0, GIC, 24, 4)
 FIELD(ID_AA64PFR0, RAS, 28, 4)
 FIELD(ID_AA64PFR0, SVE, 32, 4)
 
+FIELD(ID_AA64PFR1, BT, 0, 4)
+FIELD(ID_AA64PFR1, SBSS, 4, 4)
+
 FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
 FIELD(ID_AA64MMFR0, ASIDBITS, 4, 4)
 FIELD(ID_AA64MMFR0, BIGEND, 8, 4)
@@ -3268,6 +3271,11 @@ static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
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
