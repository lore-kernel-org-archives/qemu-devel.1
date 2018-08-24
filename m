Received: from eggs.gnu.org ([2001:4830:134:3::10]:35754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UI-0007en-SQ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UG-0004lx-FF
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UE-0004kS-JG
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UD-0006di-Bi
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:33 +0100
Message-Id: <20180824093343.11346-43-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 42/52] target/arm: Untabify iwmmxt_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Untabify the arm iwmmxt_helper.c.  This affects only the iwMMXt code.
We've never touched that code in years, so it's not going to get
fixed up by our "change when touched" process, and a bulk change is
not going to be too disruptive.

This commit was produced using Emacs "untabify" (plus one
by-hand removal of a space to fix a checkpatch nit); it is
a whitespace-only change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180821165215.29069-3-peter.maydell@linaro.org
---
 target/arm/iwmmxt_helper.c | 234 ++++++++++++++++++-------------------
 1 file changed, 117 insertions(+), 117 deletions(-)

diff --git a/target/arm/iwmmxt_helper.c b/target/arm/iwmmxt_helper.c
index f6a4fc5b7f0..24244d012cd 100644
--- a/target/arm/iwmmxt_helper.c
+++ b/target/arm/iwmmxt_helper.c
@@ -27,30 +27,30 @@
 /* iwMMXt macros extracted from GNU gdb.  */
 
 /* Set the SIMD wCASF flags for 8, 16, 32 or 64-bit operations.  */
-#define SIMD8_SET( v, n, b)	((v != 0) << ((((b) + 1) * 4) + (n)))
-#define SIMD16_SET(v, n, h)	((v != 0) << ((((h) + 1) * 8) + (n)))
-#define SIMD32_SET(v, n, w)	((v != 0) << ((((w) + 1) * 16) + (n)))
-#define SIMD64_SET(v, n)	((v != 0) << (32 + (n)))
+#define SIMD8_SET(v, n, b)      ((v != 0) << ((((b) + 1) * 4) + (n)))
+#define SIMD16_SET(v, n, h)     ((v != 0) << ((((h) + 1) * 8) + (n)))
+#define SIMD32_SET(v, n, w)     ((v != 0) << ((((w) + 1) * 16) + (n)))
+#define SIMD64_SET(v, n)        ((v != 0) << (32 + (n)))
 /* Flags to pass as "n" above.  */
-#define SIMD_NBIT	-1
-#define SIMD_ZBIT	-2
-#define SIMD_CBIT	-3
-#define SIMD_VBIT	-4
+#define SIMD_NBIT       -1
+#define SIMD_ZBIT       -2
+#define SIMD_CBIT       -3
+#define SIMD_VBIT       -4
 /* Various status bit macros.  */
-#define NBIT8(x)	((x) & 0x80)
-#define NBIT16(x)	((x) & 0x8000)
-#define NBIT32(x)	((x) & 0x80000000)
-#define NBIT64(x)	((x) & 0x8000000000000000ULL)
-#define ZBIT8(x)	(((x) & 0xff) == 0)
-#define ZBIT16(x)	(((x) & 0xffff) == 0)
-#define ZBIT32(x)	(((x) & 0xffffffff) == 0)
-#define ZBIT64(x)	(x == 0)
+#define NBIT8(x)        ((x) & 0x80)
+#define NBIT16(x)       ((x) & 0x8000)
+#define NBIT32(x)       ((x) & 0x80000000)
+#define NBIT64(x)       ((x) & 0x8000000000000000ULL)
+#define ZBIT8(x)        (((x) & 0xff) == 0)
+#define ZBIT16(x)       (((x) & 0xffff) == 0)
+#define ZBIT32(x)       (((x) & 0xffffffff) == 0)
+#define ZBIT64(x)       (x == 0)
 /* Sign extension macros.  */
-#define EXTEND8H(a)	((uint16_t) (int8_t) (a))
-#define EXTEND8(a)	((uint32_t) (int8_t) (a))
-#define EXTEND16(a)	((uint32_t) (int16_t) (a))
-#define EXTEND16S(a)	((int32_t) (int16_t) (a))
-#define EXTEND32(a)	((uint64_t) (int32_t) (a))
+#define EXTEND8H(a)     ((uint16_t) (int8_t) (a))
+#define EXTEND8(a)      ((uint32_t) (int8_t) (a))
+#define EXTEND16(a)     ((uint32_t) (int16_t) (a))
+#define EXTEND16S(a)    ((int32_t) (int16_t) (a))
+#define EXTEND32(a)     ((uint64_t) (int32_t) (a))
 
 uint64_t HELPER(iwmmxt_maddsq)(uint64_t a, uint64_t b)
 {
@@ -159,141 +159,141 @@ uint64_t HELPER(iwmmxt_macuw)(uint64_t a, uint64_t b)
 #define NZBIT64(x) \
     SIMD64_SET(NBIT64(x), SIMD_NBIT) | \
     SIMD64_SET(ZBIT64(x), SIMD_ZBIT)
-#define IWMMXT_OP_UNPACK(S, SH0, SH1, SH2, SH3)			\
+#define IWMMXT_OP_UNPACK(S, SH0, SH1, SH2, SH3)                         \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, b)))(CPUARMState *env, \
                                                  uint64_t a, uint64_t b) \
-{								\
-    a =							        \
-        (((a >> SH0) & 0xff) << 0) | (((b >> SH0) & 0xff) << 8) |	\
-        (((a >> SH1) & 0xff) << 16) | (((b >> SH1) & 0xff) << 24) |	\
-        (((a >> SH2) & 0xff) << 32) | (((b >> SH2) & 0xff) << 40) |	\
-        (((a >> SH3) & 0xff) << 48) | (((b >> SH3) & 0xff) << 56);	\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT8(a >> 0, 0) | NZBIT8(a >> 8, 1) |		        \
-        NZBIT8(a >> 16, 2) | NZBIT8(a >> 24, 3) |		\
-        NZBIT8(a >> 32, 4) | NZBIT8(a >> 40, 5) |		\
-        NZBIT8(a >> 48, 6) | NZBIT8(a >> 56, 7);		\
+{                                                               \
+    a =                                                                 \
+        (((a >> SH0) & 0xff) << 0) | (((b >> SH0) & 0xff) << 8) |       \
+        (((a >> SH1) & 0xff) << 16) | (((b >> SH1) & 0xff) << 24) |     \
+        (((a >> SH2) & 0xff) << 32) | (((b >> SH2) & 0xff) << 40) |     \
+        (((a >> SH3) & 0xff) << 48) | (((b >> SH3) & 0xff) << 56);      \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT8(a >> 0, 0) | NZBIT8(a >> 8, 1) |                         \
+        NZBIT8(a >> 16, 2) | NZBIT8(a >> 24, 3) |               \
+        NZBIT8(a >> 32, 4) | NZBIT8(a >> 40, 5) |               \
+        NZBIT8(a >> 48, 6) | NZBIT8(a >> 56, 7);                \
     return a;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, w)))(CPUARMState *env, \
                                         uint64_t a, uint64_t b) \
-{								\
-    a =							        \
-        (((a >> SH0) & 0xffff) << 0) |				\
-        (((b >> SH0) & 0xffff) << 16) |			        \
-        (((a >> SH2) & 0xffff) << 32) |			        \
-        (((b >> SH2) & 0xffff) << 48);				\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT8(a >> 0, 0) | NZBIT8(a >> 16, 1) |		\
-        NZBIT8(a >> 32, 2) | NZBIT8(a >> 48, 3);		\
+{                                                               \
+    a =                                                                 \
+        (((a >> SH0) & 0xffff) << 0) |                          \
+        (((b >> SH0) & 0xffff) << 16) |                                 \
+        (((a >> SH2) & 0xffff) << 32) |                                 \
+        (((b >> SH2) & 0xffff) << 48);                          \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT8(a >> 0, 0) | NZBIT8(a >> 16, 1) |                \
+        NZBIT8(a >> 32, 2) | NZBIT8(a >> 48, 3);                \
     return a;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, l)))(CPUARMState *env, \
                                         uint64_t a, uint64_t b) \
-{								\
-    a =							        \
-        (((a >> SH0) & 0xffffffff) << 0) |			\
-        (((b >> SH0) & 0xffffffff) << 32);			\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT32(a >> 0, 0) | NZBIT32(a >> 32, 1);		\
+{                                                               \
+    a =                                                                 \
+        (((a >> SH0) & 0xffffffff) << 0) |                      \
+        (((b >> SH0) & 0xffffffff) << 32);                      \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT32(a >> 0, 0) | NZBIT32(a >> 32, 1);               \
     return a;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, ub)))(CPUARMState *env, \
                                                   uint64_t x)   \
-{								\
-    x =							        \
-        (((x >> SH0) & 0xff) << 0) |				\
-        (((x >> SH1) & 0xff) << 16) |				\
-        (((x >> SH2) & 0xff) << 32) |				\
-        (((x >> SH3) & 0xff) << 48);				\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |		\
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);		\
+{                                                               \
+    x =                                                                 \
+        (((x >> SH0) & 0xff) << 0) |                            \
+        (((x >> SH1) & 0xff) << 16) |                           \
+        (((x >> SH2) & 0xff) << 32) |                           \
+        (((x >> SH3) & 0xff) << 48);                            \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |              \
+        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);              \
     return x;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, uw)))(CPUARMState *env, \
                                                   uint64_t x)   \
-{								\
-    x =							        \
-        (((x >> SH0) & 0xffff) << 0) |				\
-        (((x >> SH2) & 0xffff) << 32);				\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);		\
+{                                                               \
+    x =                                                                 \
+        (((x >> SH0) & 0xffff) << 0) |                          \
+        (((x >> SH2) & 0xffff) << 32);                          \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);               \
     return x;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, ul)))(CPUARMState *env, \
                                                   uint64_t x)   \
-{								\
-    x = (((x >> SH0) & 0xffffffff) << 0);			\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x >> 0);	\
+{                                                               \
+    x = (((x >> SH0) & 0xffffffff) << 0);                       \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x >> 0);      \
     return x;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, sb)))(CPUARMState *env, \
                                                   uint64_t x)   \
-{								\
-    x =							        \
-        ((uint64_t) EXTEND8H((x >> SH0) & 0xff) << 0) |	        \
-        ((uint64_t) EXTEND8H((x >> SH1) & 0xff) << 16) |	\
-        ((uint64_t) EXTEND8H((x >> SH2) & 0xff) << 32) |	\
-        ((uint64_t) EXTEND8H((x >> SH3) & 0xff) << 48);	        \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |		\
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);		\
+{                                                               \
+    x =                                                                 \
+        ((uint64_t) EXTEND8H((x >> SH0) & 0xff) << 0) |                 \
+        ((uint64_t) EXTEND8H((x >> SH1) & 0xff) << 16) |        \
+        ((uint64_t) EXTEND8H((x >> SH2) & 0xff) << 32) |        \
+        ((uint64_t) EXTEND8H((x >> SH3) & 0xff) << 48);                 \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |              \
+        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);              \
     return x;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, sw)))(CPUARMState *env, \
                                                   uint64_t x)   \
-{								\
-    x =							        \
-        ((uint64_t) EXTEND16((x >> SH0) & 0xffff) << 0) |	\
-        ((uint64_t) EXTEND16((x >> SH2) & 0xffff) << 32);	\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);		\
+{                                                               \
+    x =                                                                 \
+        ((uint64_t) EXTEND16((x >> SH0) & 0xffff) << 0) |       \
+        ((uint64_t) EXTEND16((x >> SH2) & 0xffff) << 32);       \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);               \
     return x;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_unpack, glue(S, sl)))(CPUARMState *env, \
                                                   uint64_t x)   \
-{								\
-    x = EXTEND32((x >> SH0) & 0xffffffff);			\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x >> 0);	\
+{                                                               \
+    x = EXTEND32((x >> SH0) & 0xffffffff);                      \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x >> 0);      \
     return x;                                                   \
 }
 IWMMXT_OP_UNPACK(l, 0, 8, 16, 24)
 IWMMXT_OP_UNPACK(h, 32, 40, 48, 56)
 
-#define IWMMXT_OP_CMP(SUFF, Tb, Tw, Tl, O)			\
+#define IWMMXT_OP_CMP(SUFF, Tb, Tw, Tl, O)                      \
 uint64_t HELPER(glue(iwmmxt_, glue(SUFF, b)))(CPUARMState *env,    \
                                         uint64_t a, uint64_t b) \
-{								\
-    a =							        \
-        CMP(0, Tb, O, 0xff) | CMP(8, Tb, O, 0xff) |		\
-        CMP(16, Tb, O, 0xff) | CMP(24, Tb, O, 0xff) |		\
-        CMP(32, Tb, O, 0xff) | CMP(40, Tb, O, 0xff) |		\
-        CMP(48, Tb, O, 0xff) | CMP(56, Tb, O, 0xff);		\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT8(a >> 0, 0) | NZBIT8(a >> 8, 1) |		        \
-        NZBIT8(a >> 16, 2) | NZBIT8(a >> 24, 3) |		\
-        NZBIT8(a >> 32, 4) | NZBIT8(a >> 40, 5) |		\
-        NZBIT8(a >> 48, 6) | NZBIT8(a >> 56, 7);		\
+{                                                               \
+    a =                                                                 \
+        CMP(0, Tb, O, 0xff) | CMP(8, Tb, O, 0xff) |             \
+        CMP(16, Tb, O, 0xff) | CMP(24, Tb, O, 0xff) |           \
+        CMP(32, Tb, O, 0xff) | CMP(40, Tb, O, 0xff) |           \
+        CMP(48, Tb, O, 0xff) | CMP(56, Tb, O, 0xff);            \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT8(a >> 0, 0) | NZBIT8(a >> 8, 1) |                         \
+        NZBIT8(a >> 16, 2) | NZBIT8(a >> 24, 3) |               \
+        NZBIT8(a >> 32, 4) | NZBIT8(a >> 40, 5) |               \
+        NZBIT8(a >> 48, 6) | NZBIT8(a >> 56, 7);                \
     return a;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_, glue(SUFF, w)))(CPUARMState *env,    \
                                         uint64_t a, uint64_t b) \
-{								\
-    a = CMP(0, Tw, O, 0xffff) | CMP(16, Tw, O, 0xffff) |	\
-        CMP(32, Tw, O, 0xffff) | CMP(48, Tw, O, 0xffff);	\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT16(a >> 0, 0) | NZBIT16(a >> 16, 1) |		\
-        NZBIT16(a >> 32, 2) | NZBIT16(a >> 48, 3);		\
+{                                                               \
+    a = CMP(0, Tw, O, 0xffff) | CMP(16, Tw, O, 0xffff) |        \
+        CMP(32, Tw, O, 0xffff) | CMP(48, Tw, O, 0xffff);        \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT16(a >> 0, 0) | NZBIT16(a >> 16, 1) |              \
+        NZBIT16(a >> 32, 2) | NZBIT16(a >> 48, 3);              \
     return a;                                                   \
-}								\
+}                                                               \
 uint64_t HELPER(glue(iwmmxt_, glue(SUFF, l)))(CPUARMState *env,    \
                                         uint64_t a, uint64_t b) \
-{								\
-    a = CMP(0, Tl, O, 0xffffffff) |				\
-        CMP(32, Tl, O, 0xffffffff);				\
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =			\
-        NZBIT32(a >> 0, 0) | NZBIT32(a >> 32, 1);		\
+{                                                               \
+    a = CMP(0, Tl, O, 0xffffffff) |                             \
+        CMP(32, Tl, O, 0xffffffff);                             \
+    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
+        NZBIT32(a >> 0, 0) | NZBIT32(a >> 32, 1);               \
     return a;                                                   \
 }
 #define CMP(SHR, TYPE, OPER, MASK) ((((TYPE) ((a >> SHR) & MASK) OPER \
-- 
2.18.0
