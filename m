Received: from eggs.gnu.org ([2001:4830:134:3::10]:56295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5Dac-0006Gf-1R
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5DaY-0002PY-Qh
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:34 -0400
Received: from mail-co1nam03on0088.outbound.protection.outlook.com
	([104.47.40.88]:63760
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e5DaY-0002P3-Eb
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:30 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 19 Oct 2017 09:18:27 -0700
Message-ID: <44428b086df78ccd0cb030593290bc3a7c2b8a1d.1508390588.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508390588.git.alistair.francis@xilinx.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 45/46] target: Use qemu_log() instead of
 fprintf(stderr, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 target/cris/translate.c      |  2 +-
 target/ppc/translate.c       | 22 +++++++++++-----------
 target/sh4/translate.c       |  4 ++--
 target/unicore32/translate.c |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 38a999e6f1..e04aa2ae2b 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -138,7 +138,7 @@ typedef struct DisasContext {
 
 static void gen_BUG(DisasContext *dc, const char *file, int line)
 {
-    fprintf(stderr, "BUG: pc=%x %s %d\n", dc->pc, file, line);
+    qemu_log("BUG: pc=%x %s %d\n", dc->pc, file, line);
     if (qemu_log_separate()) {
         qemu_log("BUG: pc=%x %s %d\n", dc->pc, file, line);
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a81ff69d75..ed77d293c1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3955,11 +3955,11 @@ static inline void gen_op_mfspr(DisasContext *ctx)
              * allowing userland application to read the PVR
              */
             if (sprn != SPR_PVR) {
-                fprintf(stderr, "Trying to read privileged spr %d (0x%03x) at "
-                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                qemu_log("Trying to read privileged spr %d (0x%03x) at "
+                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
                 if (qemu_log_separate()) {
                     qemu_log("Trying to read privileged spr %d (0x%03x) at "
-                             TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+                              TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
                 }
             }
             gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
@@ -3972,8 +3972,8 @@ static inline void gen_op_mfspr(DisasContext *ctx)
             return;
         }
         /* Not defined */
-        fprintf(stderr, "Trying to read invalid spr %d (0x%03x) at "
-                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+        qemu_log("Trying to read invalid spr %d (0x%03x) at "
+                 TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
         if (qemu_log_separate()) {
             qemu_log("Trying to read invalid spr %d (0x%03x) at "
                      TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
@@ -4118,8 +4118,8 @@ static void gen_mtspr(DisasContext *ctx)
             (*write_cb)(ctx, sprn, rS(ctx->opcode));
         } else {
             /* Privilege exception */
-            fprintf(stderr, "Trying to write privileged spr %d (0x%03x) at "
-                    TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+            qemu_log("Trying to write privileged spr %d (0x%03x) at "
+                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
             if (qemu_log_separate()) {
                 qemu_log("Trying to write privileged spr %d (0x%03x) at "
                          TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
@@ -4139,8 +4139,8 @@ static void gen_mtspr(DisasContext *ctx)
             qemu_log("Trying to write invalid spr %d (0x%03x) at "
                      TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
         }
-        fprintf(stderr, "Trying to write invalid spr %d (0x%03x) at "
-                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+        qemu_log("Trying to write invalid spr %d (0x%03x) at "
+                 TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
 
 
         /* The behaviour depends on MSR:PR and SPR# bit 0x10,
@@ -7382,8 +7382,8 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
         if (tcg_check_temp_count()) {
-            fprintf(stderr, "Opcode %02x %02x %02x %02x (%08x) leaked "
-                    "temporaries\n", opc1(ctx.opcode), opc2(ctx.opcode),
+            qemu_log("Opcode %02x %02x %02x %02x (%08x) leaked "
+                     "temporaries\n", opc1(ctx.opcode), opc2(ctx.opcode),
                     opc3(ctx.opcode), opc4(ctx.opcode), ctx.opcode);
             exit(1);
         }
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8db9fba26e..0c5796ff91 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -438,7 +438,7 @@ static void _decode_opc(DisasContext * ctx)
 	}
 
 #if 0
-    fprintf(stderr, "Translating opcode 0x%04x\n", ctx->opcode);
+    qemu_log("Translating opcode 0x%04x\n", ctx->opcode);
 #endif
 
     switch (ctx->opcode) {
@@ -1799,7 +1799,7 @@ static void _decode_opc(DisasContext * ctx)
         break;
     }
 #if 0
-    fprintf(stderr, "unknown instruction 0x%04x at pc 0x%08x\n",
+    qemu_log_mask(LOG_UNIMP, "unknown instruction 0x%04x at pc 0x%08x\n",
 	    ctx->opcode, ctx->pc);
     fflush(stderr);
 #endif
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 6c094d59d7..1bd7827ee8 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1940,7 +1940,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         disas_uc32_insn(env, dc);
 
         if (num_temps) {
-            fprintf(stderr, "Internal resource leak before %08x\n", dc->pc);
+            qemu_log("Internal resource leak before %08x\n", dc->pc);
             num_temps = 0;
         }
 
-- 
2.11.0
