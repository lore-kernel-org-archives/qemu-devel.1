Received: from eggs.gnu.org ([2001:4830:134:3::10]:37835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DO-0007lN-4h
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DK-0007Bu-9T
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DK-0007Bf-4A
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:26 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:49 +0100
Message-Id: <20161222152300.32395-15-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/25] target-i386: Add Intel SHA_NI instruction
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yi Sun <yi.y.sun@linux.intel.com>

From: Yi Sun <yi.y.sun@linux.intel.com>

Add SHA_NI feature bit. Its spec can be found at:
https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Message-Id: <1481683803-10051-1-git-send-email-yi.y.sun@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index de1f30e..993f825 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -422,7 +422,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
             "clwb", NULL, "avx512pf", "avx512er",
-            "avx512cd", NULL, "avx512bw", "avx512vl",
+            "avx512cd", "sha-ni", "avx512bw", "avx512vl",
         },
         .cpuid_eax = 7,
         .cpuid_needs_ecx = true, .cpuid_ecx = 0,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c605724..d0bf624 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -621,6 +621,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EBX_AVX512PF (1U << 26) /* AVX-512 Prefetch */
 #define CPUID_7_0_EBX_AVX512ER (1U << 27) /* AVX-512 Exponential and Reciprocal */
 #define CPUID_7_0_EBX_AVX512CD (1U << 28) /* AVX-512 Conflict Detection */
+#define CPUID_7_0_EBX_SHA_NI   (1U << 29) /* SHA1/SHA256 Instruction Extensions */
 #define CPUID_7_0_EBX_AVX512BW (1U << 30) /* AVX-512 Byte and Word Instructions */
 #define CPUID_7_0_EBX_AVX512VL (1U << 31) /* AVX-512 Vector Length Extensions */
 
-- 
2.9.3
