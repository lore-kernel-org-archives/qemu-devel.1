Received: from eggs.gnu.org ([2001:4830:134:3::10]:51143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURY-0004i4-5X
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURX-0001v7-De
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:00 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:39193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURX-0001uf-7a
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:59 -0500
Received: by mail-pg0-x241.google.com with SMTP id w17so3810899pgv.6
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:26:59 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.26.56 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:26:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:00 -0800
Message-Id: <20180124232625.30105-21-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 20/45] target/hppa: Log unimplemented
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
