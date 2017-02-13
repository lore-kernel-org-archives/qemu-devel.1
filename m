Received: from eggs.gnu.org ([2001:4830:134:3::10]:45505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8o-0004xt-Ki
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8n-0001XC-JC
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:34 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8n-0001Wz-F0
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:33 -0500
Received: by mail-qt0-x244.google.com with SMTP id h53so15006432qth.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:28 +1100
Message-Id: <20170213212536.31871-17-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/24] target/openrisc: Enable trap, csync, msync,
 psync for user mode
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

Not documented as disabled for user mode.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/translate.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index f91ab6a..6c8f05c 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1134,52 +1134,20 @@ static void dec_sys(DisasContext *dc, uint32_t insn)
 
     case 0x100:    /* l.trap */
         LOG_DIS("l.trap %d\n", K16);
-#if defined(CONFIG_USER_ONLY)
-        return;
-#else
-        if (dc->mem_idx == MMU_USER_IDX) {
-            gen_illegal_exception(dc);
-            return;
-        }
         tcg_gen_movi_tl(cpu_pc, dc->pc);
         gen_exception(dc, EXCP_TRAP);
-#endif
         break;
 
     case 0x300:    /* l.csync */
         LOG_DIS("l.csync\n");
-#if defined(CONFIG_USER_ONLY)
-        return;
-#else
-        if (dc->mem_idx == MMU_USER_IDX) {
-            gen_illegal_exception(dc);
-            return;
-        }
-#endif
         break;
 
     case 0x200:    /* l.msync */
         LOG_DIS("l.msync\n");
-#if defined(CONFIG_USER_ONLY)
-        return;
-#else
-        if (dc->mem_idx == MMU_USER_IDX) {
-            gen_illegal_exception(dc);
-            return;
-        }
-#endif
         break;
 
     case 0x270:    /* l.psync */
         LOG_DIS("l.psync\n");
-#if defined(CONFIG_USER_ONLY)
-        return;
-#else
-        if (dc->mem_idx == MMU_USER_IDX) {
-            gen_illegal_exception(dc);
-            return;
-        }
-#endif
         break;
 
     default:
-- 
2.9.3
