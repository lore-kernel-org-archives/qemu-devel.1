Received: from eggs.gnu.org ([2001:4830:134:3::10]:39153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqN6-0006st-NP
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebqN2-0003nA-Nt
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:28 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebqN2-0003mf-E7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:15:24 -0500
Received: by mail-pg0-x244.google.com with SMTP id d6so11516175pgv.2
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:15:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 17 Jan 2018 08:14:26 -0800
Message-Id: <20180117161435.28981-12-richard.henderson@linaro.org>
In-Reply-To: <20180117161435.28981-1-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10.5 11/20] target/arm: Align vector registers
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
index 96316700dd..3ff4dea6b8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -492,7 +492,7 @@ typedef struct CPUARMState {
          * the two execution states, and means we do not need to explicitly
          * map these registers when changing states.
          */
-        float64 regs[64];
+        float64 regs[64] QEMU_ALIGNED(16);
 
         uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
-- 
2.14.3
