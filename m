Received: from eggs.gnu.org ([2001:4830:134:3::10]:56265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fY8bp-0005oc-1P
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fY8bk-0007yw-Tu
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:32717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fY8bk-0007x0-KX
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:32 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed, 27 Jun 2018 19:27:21 +0800
Message-Id: <1530098844-236851-3-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 2/5] i386: Add CPUID bit and feature words
 for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

Support of IA32_PRED_CMD MSR already be enumerated by same CPUID bit as
SPEC_CTRL.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e6c2f8a..953098c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1002,7 +1002,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", NULL,
-            NULL, NULL, NULL, "ssbd",
+            NULL, "arch-capabilities", NULL, "ssbd",
         },
         .cpuid_eax = 7,
         .cpuid_needs_ecx = true, .cpuid_ecx = 0,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 734a73e..1ef2040 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -688,6 +688,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
+#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities of RDCL_NO and IBRS_ALL*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
-- 
1.8.3.1
