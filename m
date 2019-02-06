Received: from eggs.gnu.org ([209.51.188.92]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFbe-0007HS-FF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFQZ-0003Ll-K2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:16 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grFQZ-0003LZ-EM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:15 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so6074642wra.6
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 21:07:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 05:07:01 +0000
Message-Id: <20190206050701.11847-6-richard.henderson@linaro.org>
In-Reply-To: <20190206050701.11847-1-richard.henderson@linaro.org>
References: <20190206050701.11847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 5/5] target/arm: Remove neon min/max helpers
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

These are now unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h      | 12 ------------
 target/arm/neon_helper.c | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 53a38188c6..9874c35ea9 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -276,18 +276,6 @@ DEF_HELPER_2(neon_cge_s16, i32, i32, i32)
 DEF_HELPER_2(neon_cge_u32, i32, i32, i32)
 DEF_HELPER_2(neon_cge_s32, i32, i32, i32)
 
-DEF_HELPER_2(neon_min_u8, i32, i32, i32)
-DEF_HELPER_2(neon_min_s8, i32, i32, i32)
-DEF_HELPER_2(neon_min_u16, i32, i32, i32)
-DEF_HELPER_2(neon_min_s16, i32, i32, i32)
-DEF_HELPER_2(neon_min_u32, i32, i32, i32)
-DEF_HELPER_2(neon_min_s32, i32, i32, i32)
-DEF_HELPER_2(neon_max_u8, i32, i32, i32)
-DEF_HELPER_2(neon_max_s8, i32, i32, i32)
-DEF_HELPER_2(neon_max_u16, i32, i32, i32)
-DEF_HELPER_2(neon_max_s16, i32, i32, i32)
-DEF_HELPER_2(neon_max_u32, i32, i32, i32)
-DEF_HELPER_2(neon_max_s32, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_u8, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_s8, i32, i32, i32)
 DEF_HELPER_2(neon_pmin_u16, i32, i32, i32)
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index c2c6491a83..3249005b62 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -581,12 +581,6 @@ NEON_VOP(cge_u32, neon_u32, 1)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) dest = (src1 < src2) ? src1 : src2
-NEON_VOP(min_s8, neon_s8, 4)
-NEON_VOP(min_u8, neon_u8, 4)
-NEON_VOP(min_s16, neon_s16, 2)
-NEON_VOP(min_u16, neon_u16, 2)
-NEON_VOP(min_s32, neon_s32, 1)
-NEON_VOP(min_u32, neon_u32, 1)
 NEON_POP(pmin_s8, neon_s8, 4)
 NEON_POP(pmin_u8, neon_u8, 4)
 NEON_POP(pmin_s16, neon_s16, 2)
@@ -594,12 +588,6 @@ NEON_POP(pmin_u16, neon_u16, 2)
 #undef NEON_FN
 
 #define NEON_FN(dest, src1, src2) dest = (src1 > src2) ? src1 : src2
-NEON_VOP(max_s8, neon_s8, 4)
-NEON_VOP(max_u8, neon_u8, 4)
-NEON_VOP(max_s16, neon_s16, 2)
-NEON_VOP(max_u16, neon_u16, 2)
-NEON_VOP(max_s32, neon_s32, 1)
-NEON_VOP(max_u32, neon_u32, 1)
 NEON_POP(pmax_s8, neon_s8, 4)
 NEON_POP(pmax_u8, neon_u8, 4)
 NEON_POP(pmax_s16, neon_s16, 2)
-- 
2.17.2
