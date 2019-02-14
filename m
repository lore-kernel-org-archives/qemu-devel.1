Received: from eggs.gnu.org ([209.51.188.92]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLH-00080q-S4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLG-0004ra-5M
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLF-0004oG-OT
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id v26so7193444wmh.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:55 +0000
Message-Id: <20190214190603.25030-20-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/27] target/arm: Remove neon min/max helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

These are now unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190209033847.9014-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h      | 12 ------------
 target/arm/neon_helper.c | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 53a38188c66..9874c35ea97 100644
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
index c2c6491a83e..3249005b627 100644
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
2.20.1
