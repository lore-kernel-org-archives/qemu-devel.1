Received: from eggs.gnu.org ([2001:4830:134:3::10]:55879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxu-0004mc-66
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxq-0005VO-HU
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:46 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxq-0005Uo-C1
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:42 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so4293939otk.9
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:24:08 -0600
Message-Id: <20181214052410.11863-26-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 25/27] target/arm: Enable PAuth for -cpu max
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
index 1d57be0c91..84f70b2a24 100644
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
