Received: from eggs.gnu.org ([2001:4830:134:3::10]:38178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgix-0002PV-1I
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiw-0007tv-7e
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:51 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgiw-0007to-1R
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:50 -0500
Received: by mail-pg0-x242.google.com with SMTP id v184so16784957pgv.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:52:49 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:47 -0800
Message-Id: <20170209045154.16868-16-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 15/22] target/openrisc: Enable trap, csync,
 msync, psync for user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Not documented as disabled for user mode.

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
