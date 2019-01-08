Received: from eggs.gnu.org ([209.51.188.92]:53131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvd-0000oe-Dq
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvb-0005PA-G1
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:57 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzvZ-0005Ld-HX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:54 -0500
Received: by mail-pf1-x441.google.com with SMTP id h3so2626415pfg.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:27 +1000
Message-Id: <20190108223129.5570-30-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 29/31] target/arm: Enable PAuth for -cpu max
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
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4b544a1c58..1974f1aeb7 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -316,6 +316,10 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64isar1;
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
+        t = FIELD_DP64(t, ID_AA64ISAR1, API, 0);
+        t = FIELD_DP64(t, ID_AA64ISAR1, GPA, 1);
+        t = FIELD_DP64(t, ID_AA64ISAR1, GPI, 0);
         cpu->isar.id_aa64isar1 = t;
 
         t = cpu->isar.id_aa64pfr0;
-- 
2.17.2
