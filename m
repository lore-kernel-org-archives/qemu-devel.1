Received: from eggs.gnu.org ([2001:4830:134:3::10]:44181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d4qDj-0006Un-A5
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d4qDi-0006cR-G0
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:46988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d4qDi-0006br-AR
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 30 Apr 2017 16:52:54 +0200
Message-Id: <20170430145254.25616-4-aurelien@aurel32.net>
In-Reply-To: <20170430145254.25616-1-aurelien@aurel32.net>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170430145254.25616-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v5++ 3/3] target/mips: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/mips/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1a7ac07c67..559f8fed89 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10725,7 +10725,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
                 save_cpu_state(ctx, 0);
                 gen_helper_raise_exception_debug(cpu_env);
             }
-            tcg_gen_exit_tb(0);
+            tcg_gen_lookup_and_goto_ptr(cpu_PC);
             break;
         default:
             fprintf(stderr, "unknown branch 0x%x\n", proc_hflags);
-- 
2.11.0
