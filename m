Received: from eggs.gnu.org ([2001:4830:134:3::10]:47852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZq1Z-0001yL-72
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 23:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZq1R-00078m-S7
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 23:33:27 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZq1P-00073f-SJ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 23:33:21 -0500
Received: by mail-pg1-x543.google.com with SMTP id c25so265034pgb.4
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 20:33:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 19 Dec 2018 20:33:15 -0800
Message-Id: <20181220043315.8848-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] disas/microblaze: Remove unused REG_SP macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com

This causes a build error with debian sid, riscv64 host:

disas/microblaze.c:179: error: "REG_SP" redefined [-Werror]
 #define REG_SP  1 /* stack pointer */

In file included from /usr/include/signal.h:306,
                 from include/qemu/osdep.h:101,
                 from disas/microblaze.c:36:
/usr/include/riscv64-linux-gnu/sys/ucontext.h:36: note: this is the location of the previous definition
 # define REG_SP 2

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/microblaze.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 598ecbc89d..c23605043a 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -176,7 +176,6 @@ enum microblaze_instr_type {
 #define REG_TLBSX 36869 /* MMU: TLB Search Index reg */
 
 /* alternate names for gen purpose regs */
-#define REG_SP  1 /* stack pointer */
 #define REG_ROSDP 2 /* read-only small data pointer */
 #define REG_RWSDP 13 /* read-write small data pointer */
 
-- 
2.17.2
