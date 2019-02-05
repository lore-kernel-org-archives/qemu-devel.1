Received: from eggs.gnu.org ([209.51.188.92]:36009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AU-0001ud-Ca
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AS-0000Zy-1b
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:33617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AR-0000L4-PB
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id r24so20610wmh.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.24
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:57 +0000
Message-Id: <20190205170510.21984-10-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/22] target/arm: Enable BTI for -cpu max
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
Message-id: 20190128223118.5255-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7107ec8d7eb..eff0f164dd0 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -324,6 +324,10 @@ static void aarch64_max_initfn(Object *obj)
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
2.20.1
