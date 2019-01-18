Received: from eggs.gnu.org ([209.51.188.92]:43209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbb-0002sP-3s
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVba-0007Vu-2a
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:47 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbZ-0007VC-Qf
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:45 -0500
Received: by mail-wr1-x430.google.com with SMTP id s12so15435560wrt.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.43 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:49 +0000
Message-Id: <20190118145805.6852-34-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/49] target/arm: Enable PAuth for -cpu max
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
Message-id: 20190108223129.5570-30-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4b544a1c588..1974f1aeb74 100644
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
2.20.1
