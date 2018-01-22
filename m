Received: from eggs.gnu.org ([2001:4830:134:3::10]:60239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0V-0005Ye-Ah
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0U-0006Xk-Hy
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:51 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0U-0006XO-CV
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:50 -0500
Received: by mail-pg0-x242.google.com with SMTP id n17so6074587pgf.10
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:42:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:41:54 -0800
Message-Id: <20180122034217.19593-21-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 20/43] target/hppa: Log unimplemented
 instructions
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cad661e39f..7334206b44 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4207,6 +4207,8 @@ static DisasJumpType translate_table_int(DisasContext *ctx, uint32_t insn,
             return table[i].trans(ctx, insn, &table[i]);
         }
     }
+    qemu_log_mask(LOG_UNIMP, "UNIMP insn %08x @ " TARGET_FMT_lx "\n",
+                  insn, ctx->base.pc_next);
     return gen_illegal(ctx);
 }
 
-- 
2.14.3
