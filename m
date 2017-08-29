Received: from eggs.gnu.org ([2001:4830:134:3::10]:38883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dma5S-0000PO-Oh
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dma5R-000437-QG
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:33:22 -0400
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 29 Aug 2017 02:33:11 -0400
Message-Id: <20170829063313.10237-3-bobby.prani@gmail.com>
In-Reply-To: <20170829063313.10237-1-bobby.prani@gmail.com>
References: <20170829063313.10237-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC v3 PATCH 3/5] mttcg: Add tcg target default
 memory ordering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org, Claudio Fontana <claudio.fontana@huawei.com>, Richard Henderson <rth@twiddle.net>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, "open list:AArch64 target" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 tcg/aarch64/tcg-target.h | 2 ++
 tcg/arm/tcg-target.h     | 2 ++
 tcg/ia64/tcg-target.h    | 2 ++
 tcg/mips/tcg-target.h    | 2 ++
 tcg/ppc/tcg-target.h     | 2 ++
 tcg/s390/tcg-target.h    | 2 ++
 tcg/sparc/tcg-target.h   | 2 ++
 7 files changed, 14 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 55a46ac825..b41a248bee 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -117,4 +117,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     __builtin___clear_cache((char *)start, (char *)stop);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 5ef1086710..a38be15a39 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -134,4 +134,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     __builtin___clear_cache((char *) start, (char *) stop);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/ia64/tcg-target.h b/tcg/ia64/tcg-target.h
index 901bb7575d..8f475fe742 100644
--- a/tcg/ia64/tcg-target.h
+++ b/tcg/ia64/tcg-target.h
@@ -195,4 +195,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     asm volatile (";;sync.i;;srlz.i;;");
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d75cb63ed3..e9558d15bc 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -206,4 +206,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
     cacheflush ((void *)start, stop-start, ICACHE);
 }
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 5f4a40a5b4..5a092b038a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -125,4 +125,6 @@ extern bool have_isa_3_00;
 
 void flush_icache_range(uintptr_t start, uintptr_t stop);
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 #endif
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 957f0c0afe..dc0e59193c 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -133,6 +133,8 @@ extern uint64_t s390_facilities;
 
 #define TCG_TARGET_EXTEND_ARGS 1
 
+#define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
 enum {
     TCG_AREG0 = TCG_REG_R10,
 };
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 854a0afd70..4515c9ab48 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -162,6 +162,8 @@ extern bool use_vis3_instructions;
 
 #define TCG_AREG0 TCG_REG_I0
 
+#define TCG_TARGET_DEFAULT_MO (0)
+
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
     uintptr_t p;
-- 
2.13.0
