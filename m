Received: from eggs.gnu.org ([209.51.188.92]:35887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AR-0001tt-W6
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AQ-0000YB-RG
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AL-0000JD-9d
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id y8so4480033wmi.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.13
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:49 +0000
Message-Id: <20190205170510.21984-2-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/22] target/arm: Introduce
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

From: Richard Henderson <richard.henderson@linaro.org>

Also create field definitions for id_aa64pfr1 from ARMv8.5.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190128223118.5255-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a68bcc9fedb..0c7ea39f1ae 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1681,6 +1681,11 @@ FIELD(ID_AA64PFR0, GIC, 24, 4)
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
@@ -3328,6 +3333,11 @@ static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
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
2.20.1
