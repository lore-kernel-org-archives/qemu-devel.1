Received: from eggs.gnu.org ([2001:4830:134:3::10]:60778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6eA-0006AK-SV
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6e6-0005bL-NG
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:50 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:62753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eS6e6-0005aT-Cl
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:46 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 21 Dec 2017 20:36:37 +0100
Message-Id: <20171221193640.27418-3-laurent@vivier.eu>
In-Reply-To: <20171221193640.27418-1-laurent@vivier.eu>
References: <20171221193640.27418-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/5] target/m68k: remove unused variable
 gen_throws_exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

It has been introduced by e6e5906b6e ("ColdFire target."),
but the content is never used.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20171220130815.20708-1-laurent@vivier.eu>
---
 target/m68k/translate.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index b60909222c..dfb2d5dad2 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -181,11 +181,6 @@ static void do_writebacks(DisasContext *s)
 #define IS_USER(s) s->user
 #endif
 
-/* XXX: move that elsewhere */
-/* ??? Fix exceptions.  */
-static void *gen_throws_exception;
-#define gen_last_qop NULL
-
 typedef void (*disas_proc)(CPUM68KState *env, DisasContext *s, uint16_t insn);
 
 #ifdef DEBUG_DISPATCH
@@ -310,7 +305,6 @@ static inline TCGv gen_load(DisasContext * s, int opsize, TCGv addr, int sign)
     default:
         g_assert_not_reached();
     }
-    gen_throws_exception = gen_last_qop;
     return tmp;
 }
 
@@ -331,7 +325,6 @@ static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val)
     default:
         g_assert_not_reached();
     }
-    gen_throws_exception = gen_last_qop;
 }
 
 typedef enum {
@@ -1001,7 +994,6 @@ static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
     }
     tcg_temp_free(tmp);
     tcg_temp_free_i64(t64);
-    gen_throws_exception = gen_last_qop;
 }
 
 static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
@@ -1056,7 +1048,6 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
     }
     tcg_temp_free(tmp);
     tcg_temp_free_i64(t64);
-    gen_throws_exception = gen_last_qop;
 }
 
 static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
@@ -5561,7 +5552,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     gen_tb_start(tb);
     do {
         pc_offset = dc->pc - pc_start;
-        gen_throws_exception = NULL;
         tcg_gen_insn_start(dc->pc, dc->cc_op);
         num_insns++;
 
-- 
2.14.3
