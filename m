Received: from eggs.gnu.org ([2001:4830:134:3::10]:42434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fb0H9-0000rQ-Cg
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fb0H8-00079U-Ad
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:23698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fb0H8-0006vV-0Z
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:06 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu,  5 Jul 2018 17:09:56 +0800
Message-Id: <1530781798-183214-4-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1530781798-183214-1-git-send-email-robert.hu@linux.intel.com>
References: <1530781798-183214-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v4 3/5] i386: Add CPUID bit for PCONFIG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com, wei.w.wang@intel.com, jingqi.liu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

PCONFIG: Platform configuration, enumerated by CPUID.(EAX=07H, ECX=0):
EDX[bit18].

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 878b1ce..b83d0a9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -997,7 +997,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "pconfig", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", NULL,
             NULL, "arch-capabilities", NULL, "ssbd",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c2b297b..12a7e6c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -689,6 +689,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
+#define CPUID_7_0_EDX_PCONFIG (1U << 18)       /* Platform Configuration */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
-- 
1.8.3.1
