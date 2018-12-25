Received: from eggs.gnu.org ([208.118.235.92]:50380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtmo-0006hk-4r
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtmm-0000be-34
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:46 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:43278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtml-0000ap-TV
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:44 -0500
Received: by mail-pl1-x62a.google.com with SMTP id gn14so6803970plb.10
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:58:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:11 +1100
Message-Id: <20181225205529.10874-25-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/42] disas/microblaze: Remove unused REG_SP
 macro
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

This causes a build error with debian sid, riscv64 host:

disas/microblaze.c:179: error: "REG_SP" redefined [-Werror]
 #define REG_SP  1 /* stack pointer */

In file included from /usr/include/signal.h:306,
                 from include/qemu/osdep.h:101,
                 from disas/microblaze.c:36:
/usr/include/riscv64-linux-gnu/sys/ucontext.h:36: note: this is the location of the previous definition
 # define REG_SP 2

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
