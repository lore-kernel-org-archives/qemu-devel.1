Received: from eggs.gnu.org ([2001:4830:134:3::10]:52151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBA-0002pe-Vf
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBA-0008VW-2s
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:04 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwB9-0008V4-SY
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:03 -0500
Received: by mail-pg0-x242.google.com with SMTP id g16so3004232pgn.7
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:05 -0800
Message-Id: <20180128231528.22719-21-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 20/43] target/hppa: Log unimplemented
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
index 1cd57f5a90..6288bb9f67 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4218,6 +4218,8 @@ static DisasJumpType translate_table_int(DisasContext *ctx, uint32_t insn,
             return table[i].trans(ctx, insn, &table[i]);
         }
     }
+    qemu_log_mask(LOG_UNIMP, "UNIMP insn %08x @ " TARGET_FMT_lx "\n",
+                  insn, ctx->base.pc_next);
     return gen_illegal(ctx);
 }
 
-- 
2.14.3
