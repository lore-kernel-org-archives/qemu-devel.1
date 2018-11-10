Received: from eggs.gnu.org ([2001:4830:134:3::10]:49725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLSDM-00084i-6E
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 07:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gLSDG-000263-0T
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 07:18:11 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gLSDE-0001tl-Ai
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 07:18:05 -0500
Received: by mail-wr1-x442.google.com with SMTP id j17-v6so4522518wrq.11
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 04:18:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 10 Nov 2018 13:17:11 +0100
Message-Id: <20181110121711.15257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.1] target/arm: Fix typo in
 tlbi_aa64_vmalle1_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

This would cause an infinite recursion or loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 96301930cc..a327988c66 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3155,7 +3155,7 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = ENV_GET_CPU(env);
 
     if (tlb_force_broadcast(env)) {
-        tlbi_aa64_vmalle1_write(env, NULL, value);
+        tlbi_aa64_vmalle1is_write(env, NULL, value);
         return;
     }
 
-- 
2.17.2
