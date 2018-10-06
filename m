Received: from eggs.gnu.org ([2001:4830:134:3::10]:34480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO9-0000Ab-8i
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO7-0007He-Pa
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8uO7-00075m-H6
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  6 Oct 2018 17:45:06 -0400
Message-Id: <20181006214508.5331-5-cota@braap.org>
In-Reply-To: <20181006214508.5331-1-cota@braap.org>
References: <20181006214508.5331-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 4/6] tcg: define TCG_TARGET_TLB_MAX_INDEX_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Pranith Kumar <bobby.prani@gmail.com>

This paves the way for implementing a dynamically-sized softmmu.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/aarch64/tcg-target.h | 1 +
 tcg/arm/tcg-target.h     | 1 +
 tcg/i386/tcg-target.h    | 2 ++
 tcg/mips/tcg-target.h    | 2 ++
 tcg/ppc/tcg-target.h     | 1 +
 tcg/s390/tcg-target.h    | 1 +
 tcg/sparc/tcg-target.h   | 1 +
 tcg/tci/tcg-target.h     | 1 +
 8 files changed, 10 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 9aea1d1771..55af43d55f 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -15,6 +15,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 #undef TCG_TARGET_STACK_GROWSUP
 
 typedef enum {
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 94b3578c55..0cd07906b3 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -60,6 +60,7 @@ extern int arm_arch;
 #undef TCG_TARGET_STACK_GROWSUP
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 8
 
 typedef enum {
     TCG_REG_R0 = 0,
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 9fdf37f23c..4e79e0a550 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -200,6 +200,8 @@ extern bool have_avx2;
 # define TCG_AREG0 TCG_REG_EBP
 #endif
 
+#define TCG_TARGET_TLB_MAX_INDEX_BITS (32 - CPU_TLB_ENTRY_BITS)
+
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index a8222476f0..b791e2b4cd 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -39,6 +39,8 @@
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 #define TCG_TARGET_NB_REGS 32
 
+#define TCG_TARGET_TLB_MAX_INDEX_BITS (16 - CPU_TLB_ENTRY_BITS)
+
 typedef enum {
     TCG_REG_ZERO = 0,
     TCG_REG_AT,
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index be52ad1d2e..e0ad7c122d 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,6 +34,7 @@
 #define TCG_TARGET_NB_REGS 32
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 6f2b06a7d1..a1e25e13b3 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -27,6 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 2
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 
 typedef enum TCGReg {
     TCG_REG_R0 = 0,
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index d8339bf010..72ace760d5 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -29,6 +29,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 12
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 26140d78cb..3f28219afc 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -43,6 +43,7 @@
 #define TCG_TARGET_INTERPRETER 1
 #define TCG_TARGET_INSN_UNIT_SIZE 1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
+#define TCG_TARGET_TLB_MAX_INDEX_BITS 32
 
 #if UINTPTR_MAX == UINT32_MAX
 # define TCG_TARGET_REG_BITS 32
-- 
2.17.1
