Received: from eggs.gnu.org ([2001:4830:134:3::10]:52537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILi1-00084Q-Gz
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhz-0007xk-M8
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:45 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:47014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILhz-0007wJ-G6
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:43 -0400
Received: by mail-pg0-x241.google.com with SMTP id z4-v6so6056119pgu.13
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:12:06 -0700
Message-Id: <20180514221219.7091-16-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 15/28] target/hppa: Remove
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

This is now handled properly by the generic softfloat code.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a3af62daf7..912e8d5be4 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -341,7 +341,6 @@ float64 HELPER(fdiv_d)(CPUHPPAState *env, float64 a, float64 b)
 float64 HELPER(fcnv_s_d)(CPUHPPAState *env, float32 arg)
 {
     float64 ret = float32_to_float64(arg, &env->fp_status);
-    ret = float64_maybe_silence_nan(ret, &env->fp_status);
     update_fr0_op(env, GETPC());
     return ret;
 }
@@ -349,7 +348,6 @@ float64 HELPER(fcnv_s_d)(CPUHPPAState *env, float32 arg)
 float32 HELPER(fcnv_d_s)(CPUHPPAState *env, float64 arg)
 {
     float32 ret = float64_to_float32(arg, &env->fp_status);
-    ret = float32_maybe_silence_nan(ret, &env->fp_status);
     update_fr0_op(env, GETPC());
     return ret;
 }
-- 
2.17.0
