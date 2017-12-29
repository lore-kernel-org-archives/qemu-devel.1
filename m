Received: from eggs.gnu.org ([2001:4830:134:3::10]:51031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDg-0003Tx-Jd
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDf-0004zx-VY
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:40 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:36839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDf-0004zR-QZ
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:39 -0500
Received: by mail-pl0-x243.google.com with SMTP id b12so22519805plm.3
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:45 -0800
Message-Id: <20171229063145.29167-39-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 38/38] target/hppa: Fix comment
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

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20171212212319.GA31494@ls3530.fritz.box>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 680a361d29..0b45c4a702 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3180,7 +3180,7 @@ static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
         /* FSTW without modification.  */
         return do_fstorew(ctx, ext2 * 32 + rt, rb, 0, 0, i, sp, 0);
     case 2:
-        /* LDW with modification.  */
+        /* STW with modification.  */
         return do_store(ctx, rt, rb, i, sp, (i < 0 ? 1 : -1), MO_TEUL);
     default:
         return gen_illegal(ctx);
-- 
2.14.3
