Received: from eggs.gnu.org ([2001:4830:134:3::10]:37920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro07-0001il-IL
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro06-00072s-N0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:27 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:37514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro06-00072T-Hu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:26 -0400
Received: by mail-pg0-x229.google.com with SMTP id d8so22188871pgt.4
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:04 -0700
Message-Id: <20170912162513.21694-8-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 07/16] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 98b9b26fd3..419f008277 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -486,7 +486,7 @@ typedef struct CPUARMState {
          * the two execution states, and means we do not need to explicitly
          * map these registers when changing states.
          */
-        float64 regs[64];
+        float64 regs[64] __attribute__((aligned(16)));
 
         uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
-- 
2.13.5
