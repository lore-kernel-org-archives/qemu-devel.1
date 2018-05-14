Received: from eggs.gnu.org ([2001:4830:134:3::10]:52576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILi5-00088c-BR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILi4-00087W-3c
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:49 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILi3-000861-TF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:48 -0400
Received: by mail-pf0-x244.google.com with SMTP id c10-v6so6658570pfi.12
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:12:09 -0700
Message-Id: <20180514221219.7091-19-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 18/28] target/riscv: Remove
 floatX_maybe_silence_nan from conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

This is now handled properly by the generic softfloat code.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/fpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index abbadead5c..fdb87d8d82 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -279,14 +279,12 @@ uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 
 uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
 {
-    rs1 = float64_to_float32(rs1, &env->fp_status);
-    return float32_maybe_silence_nan(rs1, &env->fp_status);
+    return float64_to_float32(rs1, &env->fp_status);
 }
 
 uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
 {
-    rs1 = float32_to_float64(rs1, &env->fp_status);
-    return float64_maybe_silence_nan(rs1, &env->fp_status);
+    return float32_to_float64(rs1, &env->fp_status);
 }
 
 uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
-- 
2.17.0
