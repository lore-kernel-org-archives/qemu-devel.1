Received: from eggs.gnu.org ([2001:4830:134:3::10]:42449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fb0HA-0000rh-Hk
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fb0H9-0007Bf-Kj
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:23698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fb0H9-0006vV-BE
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:07 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu,  5 Jul 2018 17:09:57 +0800
Message-Id: <1530781798-183214-5-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1530781798-183214-1-git-send-email-robert.hu@linux.intel.com>
References: <1530781798-183214-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v4 4/5] i386: Add CPUID bit for WBNOINVD
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

WBNOINVD: Write back and do not invalidate cache, enumerated by
CPUID.(EAX=80000008H, ECX=0):EBX[bit 9].

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b83d0a9..8de15cb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1028,7 +1028,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "wbnoinvd", NULL, NULL,
             "ibpb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 12a7e6c..265f428 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -694,6 +694,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
+#define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
+                                                                             do not invalidate cache */
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
-- 
1.8.3.1
