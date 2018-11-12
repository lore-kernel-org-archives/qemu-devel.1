Received: from eggs.gnu.org ([2001:4830:134:3::10]:54236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3K-0003z6-EZ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3G-000527-NU
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:24 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3G-000502-FM
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:22 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so1844596wrt.7
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:57 +0100
Message-Id: <20181112214503.22941-12-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 11/17] tcg/aarch64: Use B not BL for
 tcg_out_goto_long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

This was a typo copying from tcg_out_call, apparently.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index ea5fe33fca..403f5caf14 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1139,7 +1139,7 @@ static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target,
 {
     ptrdiff_t offset = target - s->code_ptr;
     if (offset == sextract64(offset, 0, 26)) {
-        tcg_out_insn(s, 3206, BL, offset);
+        tcg_out_insn(s, 3206, B, offset);
     } else {
         tcg_out_movi(s, TCG_TYPE_I64, scratch, (intptr_t)target);
         tcg_out_insn(s, 3207, BR, scratch);
-- 
2.17.2
