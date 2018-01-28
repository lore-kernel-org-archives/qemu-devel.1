Received: from eggs.gnu.org ([2001:4830:134:3::10]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBV-000381-5b
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBU-0000OD-AF
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:25 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwBU-0000Mf-4S
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:24 -0500
Received: by mail-pg0-x244.google.com with SMTP id k68so3012630pga.3
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:19 -0800
Message-Id: <20180128231528.22719-35-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 34/43] target/hppa: Fix comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20171212212319.GA31494@ls3530.fritz.box>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a93e86c9e3..3327c085ff 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3193,7 +3193,7 @@ static DisasJumpType trans_store_w(DisasContext *ctx, uint32_t insn)
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
