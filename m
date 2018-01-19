Received: from eggs.gnu.org ([2001:4830:134:3::10]:58783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhp-0002NZ-4t
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhn-0000Ud-Au
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:09 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecOhn-0000Te-4e
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:07 -0500
Received: by mail-pg0-x244.google.com with SMTP id y27so552965pgc.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 20:55:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Jan 2018 20:54:37 -0800
Message-Id: <20180119045438.28582-16-richard.henderson@linaro.org>
In-Reply-To: <20180119045438.28582-1-richard.henderson@linaro.org>
References: <20180119045438.28582-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 15/16] target/arm: Simplify fp_exception_el
 for user-only
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
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c0e5f321c5..44814af99b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11707,6 +11707,7 @@ uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
  */
 static inline int fp_exception_el(CPUARMState *env)
 {
+#ifndef CONFIG_USER_ONLY
     int fpen;
     int cur_el = arm_current_el(env);
 
@@ -11763,7 +11764,7 @@ static inline int fp_exception_el(CPUARMState *env)
         /* Trap all FP ops to EL3 */
         return 3;
     }
-
+#endif
     return 0;
 }
 
-- 
2.14.3
