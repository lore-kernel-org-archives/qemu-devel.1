Received: from eggs.gnu.org ([2001:4830:134:3::10]:59022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1D-0006IG-Qj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1B-0007hq-Uy
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe19-0007SR-UQ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:00 -0500
Received: by mail-ot1-x32b.google.com with SMTP id w25so4078187otm.13
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:17 -0600
Message-Id: <20181214031923.29527-28-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 26/32] tcg: Add TCG_TARGET_HAS_MEMORY_BSWAP
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

For now, defined universally as true, since we previously required
backends to implement swapped memory operations.  Future patches
may now remove that support where it is onerous.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h |   1 +
 tcg/arm/tcg-target.h     |   1 +
 tcg/i386/tcg-target.h    |   2 +
 tcg/mips/tcg-target.h    |   1 +
 tcg/ppc/tcg-target.h     |   1 +
 tcg/s390/tcg-target.h    |   1 +
 tcg/sparc/tcg-target.h   |   1 +
 tcg/tci/tcg-target.h     |   2 +
 tcg/tcg-op.c             | 118 ++++++++++++++++++++++++++++++++++++++-
 9 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 9aea1d1771..f966a4fcb3 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -137,6 +137,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mul_vec          1
 
 #define TCG_TARGET_DEFAULT_MO (0)
+#define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 94b3578c55..16172f73a3 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -131,6 +131,7 @@ enum {
 };
 
 #define TCG_TARGET_DEFAULT_MO (0)
+#define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index c523d5f5e1..f378d29568 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -220,6 +220,8 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
+#define TCG_TARGET_HAS_MEMORY_BSWAP  1
+
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index a8222476f0..5cb8672470 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -203,6 +203,7 @@ extern bool use_mips32r2_instructions;
 #endif
 
 #define TCG_TARGET_DEFAULT_MO (0)
+#define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index be52ad1d2e..52c1bb04b1 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -128,6 +128,7 @@ void flush_icache_range(uintptr_t start, uintptr_t stop);
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_DEFAULT_MO (0)
+#define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 6f2b06a7d1..853ed6e7aa 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -135,6 +135,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_CALL_STACK_OFFSET	160
 
 #define TCG_TARGET_EXTEND_ARGS 1
+#define TCG_TARGET_HAS_MEMORY_BSWAP   1
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index d8339bf010..a0ed2a3342 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -164,6 +164,7 @@ extern bool use_vis3_instructions;
 #define TCG_AREG0 TCG_REG_I0
 
 #define TCG_TARGET_DEFAULT_MO (0)
+#define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 26140d78cb..086f34e69a 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -198,6 +198,8 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
    We prefer consistency across hosts on this.  */
 #define TCG_TARGET_DEFAULT_MO  (0)
 
+#define TCG_TARGET_HAS_MEMORY_BSWAP     1
+
 static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
                                             uintptr_t jmp_addr, uintptr_t addr)
 {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 887b371a81..1ad095cc35 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2694,25 +2694,78 @@ static void tcg_gen_req_mo(TCGBar type)
 
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    TCGMemOp orig_memop;
+
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
                                addr, trace_mem_get_info(memop, 0));
+
+    orig_memop = memop;
+    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
+        memop &= ~MO_BSWAP;
+        /* The bswap primitive requires zero-extended input.  */
+        if ((memop & MO_SSIZE) == MO_SW) {
+            memop &= ~MO_SIGN;
+        }
+    }
+
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
+
+    if ((orig_memop ^ memop) & MO_BSWAP) {
+        switch (orig_memop & MO_SIZE) {
+        case MO_16:
+            tcg_gen_bswap16_i32(val, val);
+            if (orig_memop & MO_SIGN) {
+                tcg_gen_ext16s_i32(val, val);
+            }
+            break;
+        case MO_32:
+            tcg_gen_bswap32_i32(val, val);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
 }
 
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
+    TCGv_i32 swap = NULL;
+
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
                                addr, trace_mem_get_info(memop, 1));
+
+    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
+        swap = tcg_temp_new_i32();
+        switch (memop & MO_SIZE) {
+        case MO_16:
+            tcg_gen_ext16u_i32(swap, val);
+            tcg_gen_bswap16_i32(swap, swap);
+            break;
+        case MO_32:
+            tcg_gen_bswap32_i32(swap, val);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        val = swap;
+        memop &= ~MO_BSWAP;
+    }
+
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
+
+    if (swap) {
+        tcg_temp_free_i32(swap);
+    }
 }
 
 void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
-    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    TCGMemOp orig_memop;
+
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
         if (memop & MO_SIGN) {
@@ -2723,24 +2776,85 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
         return;
     }
 
+    tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 1, 0);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
                                addr, trace_mem_get_info(memop, 0));
+
+    orig_memop = memop;
+    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
+        memop &= ~MO_BSWAP;
+        /* The bswap primitive requires zero-extended input.  */
+        if ((memop & MO_SIGN) && (memop & MO_SIZE) < MO_64) {
+            memop &= ~MO_SIGN;
+        }
+    }
+
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
+
+    if ((orig_memop ^ memop) & MO_BSWAP) {
+        switch (orig_memop & MO_SIZE) {
+        case MO_16:
+            tcg_gen_bswap16_i64(val, val);
+            if (orig_memop & MO_SIGN) {
+                tcg_gen_ext16s_i64(val, val);
+            }
+            break;
+        case MO_32:
+            tcg_gen_bswap32_i64(val, val);
+            if (orig_memop & MO_SIGN) {
+                tcg_gen_ext32s_i64(val, val);
+            }
+            break;
+        case MO_64:
+            tcg_gen_bswap64_i64(val, val);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
 }
 
 void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
-    tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    TCGv_i64 swap = NULL;
+
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
         return;
     }
 
+    tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
                                addr, trace_mem_get_info(memop, 1));
+
+    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
+        swap = tcg_temp_new_i64();
+        switch (memop & MO_SIZE) {
+        case MO_16:
+            tcg_gen_ext16u_i64(swap, val);
+            tcg_gen_bswap16_i64(swap, swap);
+            break;
+        case MO_32:
+            tcg_gen_ext32u_i64(swap, val);
+            tcg_gen_bswap32_i64(swap, swap);
+            break;
+        case MO_64:
+            tcg_gen_bswap64_i64(swap, val);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        val = swap;
+        memop &= ~MO_BSWAP;
+    }
+
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
+
+    if (swap) {
+        tcg_temp_free_i64(swap);
+    }
 }
 
 static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
-- 
2.17.2
