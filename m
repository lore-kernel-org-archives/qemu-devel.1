Received: from eggs.gnu.org ([2001:4830:134:3::10]:36848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3Q-0000M0-Nj
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3I-0000no-Dp
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:16 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3I-0000n1-8M
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:08 -0500
Received: by mail-pf0-x241.google.com with SMTP id j28so9930482pfk.8
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:36 -0800
Message-Id: <20171218171758.16964-5-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 04/26] target/arm: Align vector registers
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
