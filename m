Received: from eggs.gnu.org ([2001:4830:134:3::10]:50918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eewAh-0003F8-IJ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eewAg-0008Mu-7g
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:03:27 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:45150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eewAg-0008MO-02
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 00:03:26 -0500
Received: by mail-pf0-x241.google.com with SMTP id a88so7490641pfe.12
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 21:03:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 25 Jan 2018 20:57:25 -0800
Message-Id: <20180126045742.5487-4-richard.henderson@linaro.org>
In-Reply-To: <20180126045742.5487-1-richard.henderson@linaro.org>
References: <20180126045742.5487-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v11 03/20] tcg: Standardize integral arguments
 to expanders
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

Some functions use intN_t arguments, some use uintN_t, some just
used "unsigned".  To aid putting function pointers in tables, we
need consistency.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h | 16 ++++++++--------
 tcg/tcg-op.c | 42 +++++++++++++++++++++---------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 0c02d86b8b..a684ab5890 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -269,12 +269,12 @@ void tcg_gen_mb(TCGBar);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
+void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
+void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
+void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
+void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -458,12 +458,12 @@ static inline void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
+void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
+void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
+void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
+void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0c509bfe46..3467787323 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -140,7 +140,7 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     TCGv_i32 t0;
     /* Some cases can be optimized here.  */
@@ -148,17 +148,17 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
     case 0:
         tcg_gen_movi_i32(ret, 0);
         return;
-    case 0xffffffffu:
+    case -1:
         tcg_gen_mov_i32(ret, arg1);
         return;
-    case 0xffu:
+    case 0xff:
         /* Don't recurse with tcg_gen_ext8u_i32.  */
         if (TCG_TARGET_HAS_ext8u_i32) {
             tcg_gen_op2_i32(INDEX_op_ext8u_i32, ret, arg1);
             return;
         }
         break;
-    case 0xffffu:
+    case 0xffff:
         if (TCG_TARGET_HAS_ext16u_i32) {
             tcg_gen_op2_i32(INDEX_op_ext16u_i32, ret, arg1);
             return;
@@ -199,9 +199,9 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
+void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    tcg_debug_assert(arg2 < 32);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
@@ -211,9 +211,9 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
     }
 }
 
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
+void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    tcg_debug_assert(arg2 < 32);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
@@ -223,9 +223,9 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
     }
 }
 
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
+void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    tcg_debug_assert(arg2 < 32);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
@@ -1201,7 +1201,7 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     TCGv_i64 t0;
 
@@ -1216,23 +1216,23 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
     case 0:
         tcg_gen_movi_i64(ret, 0);
         return;
-    case 0xffffffffffffffffull:
+    case -1:
         tcg_gen_mov_i64(ret, arg1);
         return;
-    case 0xffull:
+    case 0xff:
         /* Don't recurse with tcg_gen_ext8u_i64.  */
         if (TCG_TARGET_HAS_ext8u_i64) {
             tcg_gen_op2_i64(INDEX_op_ext8u_i64, ret, arg1);
             return;
         }
         break;
-    case 0xffffu:
+    case 0xffff:
         if (TCG_TARGET_HAS_ext16u_i64) {
             tcg_gen_op2_i64(INDEX_op_ext16u_i64, ret, arg1);
             return;
         }
         break;
-    case 0xffffffffull:
+    case 0xffffffffu:
         if (TCG_TARGET_HAS_ext32u_i64) {
             tcg_gen_op2_i64(INDEX_op_ext32u_i64, ret, arg1);
             return;
@@ -1332,9 +1332,9 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
     }
 }
 
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
+void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    tcg_debug_assert(arg2 < 64);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_shifti_i64(ret, arg1, arg2, 0, 0);
     } else if (arg2 == 0) {
@@ -1346,9 +1346,9 @@ void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
     }
 }
 
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
+void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    tcg_debug_assert(arg2 < 64);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_shifti_i64(ret, arg1, arg2, 1, 0);
     } else if (arg2 == 0) {
@@ -1360,9 +1360,9 @@ void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
     }
 }
 
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
+void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    tcg_debug_assert(arg2 < 64);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_shifti_i64(ret, arg1, arg2, 1, 1);
     } else if (arg2 == 0) {
-- 
2.14.3
