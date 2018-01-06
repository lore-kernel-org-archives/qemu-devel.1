Received: from eggs.gnu.org ([2001:4830:134:3::10]:48202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevl-0007L0-Kq
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevk-0004i1-3P
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:13:57 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXevj-0004g6-Rz
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:13:56 -0500
Received: by mail-pg0-x244.google.com with SMTP id r2so2708151pgq.13
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:13:55 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.13.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:13:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:26 -0800
Message-Id: <20180106031346.6650-4-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 03/23] tcg: Standardize integral arguments
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

Some functions use intN_t arguments, some use uintN_t, some just
used "unsigned".  To aid putting function pointers in tables, we
need consistency.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h | 16 ++++++++--------
 tcg/tcg-op.c | 42 +++++++++++++++++++++---------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 9b0560e4d3..df2eabaa67 100644
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
