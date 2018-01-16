Received: from eggs.gnu.org ([2001:4830:134:3::10]:59721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI1U-0005Fx-Ll
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebI1T-0003M3-QT
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:52 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebI1T-0003Lo-LS
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:34:51 -0500
Received: by mail-pf0-x243.google.com with SMTP id b25so2705885pfd.9
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:34:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 15 Jan 2018 19:33:53 -0800
Message-Id: <20180116033404.31532-16-richard.henderson@linaro.org>
In-Reply-To: <20180116033404.31532-1-richard.henderson@linaro.org>
References: <20180116033404.31532-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 15/26] target/arm: Align vector registers
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
