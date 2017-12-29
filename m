Received: from eggs.gnu.org ([2001:4830:134:3::10]:50810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDL-00036g-GK
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDJ-0004lz-IE
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:19 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:46064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDJ-0004lJ-Cq
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:17 -0500
Received: by mail-pl0-x243.google.com with SMTP id o2so22510907plk.12
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:28 -0800
Message-Id: <20171229063145.29167-22-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 21/38] target/hppa: Log unimplemented
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
Cc: deller@gmx.de

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 77d3821924..a670d9d777 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4209,6 +4209,8 @@ static DisasJumpType translate_table_int(DisasContext *ctx, uint32_t insn,
             return table[i].trans(ctx, insn, &table[i]);
         }
     }
+    qemu_log_mask(LOG_UNIMP, "UNIMP insn %08x @ " TARGET_FMT_lx "\n",
+                  insn, ctx->base.pc_next);
     return gen_illegal(ctx);
 }
 
-- 
2.14.3
