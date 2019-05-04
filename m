Received: from eggs.gnu.org ([209.51.188.92]:41709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbk-0007hA-If
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbj-00049c-I5
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:12 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbj-00048Y-C7
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id u17so3971243pfn.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:52:35 -0700
Message-Id: <20190504055300.18426-7-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 06/31] tcg/arm: Use tcg_out_mov_reg in
 tcg_out_mov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com

We have a function that takes an additional condition parameter
over the standard backend interface.  It already takes care of
eliding no-op moves.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index abf0c444b4..130b6bef1e 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2267,7 +2267,7 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static inline void tcg_out_mov(TCGContext *s, TCGType type,
                                TCGReg ret, TCGReg arg)
 {
-    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0));
+    tcg_out_mov_reg(s, COND_AL, ret, arg);
 }
 
 static inline void tcg_out_movi(TCGContext *s, TCGType type,
-- 
2.17.1
