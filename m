Received: from eggs.gnu.org ([2001:4830:134:3::10]:37451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdF-0007KF-Cg
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejYdE-00050O-PL
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:01 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejYdE-0004zw-JY
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:56:00 -0500
Received: by mail-pl0-x243.google.com with SMTP id j19-v6so986030pll.2
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:56:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  7 Feb 2018 14:55:31 -0800
Message-Id: <20180207225540.31698-12-richard.henderson@linaro.org>
In-Reply-To: <20180207225540.31698-1-richard.henderson@linaro.org>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/20] target/arm: Align vector registers
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d2bb59eded..8d41f783dc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -492,7 +492,7 @@ typedef struct CPUARMState {
          * the two execution states, and means we do not need to explicitly
          * map these registers when changing states.
          */
-        uint64_t regs[64];
+        uint64_t regs[64] QEMU_ALIGNED(16);
 
         uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
-- 
2.14.3
