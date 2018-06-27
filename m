Received: from eggs.gnu.org ([2001:4830:134:3::10]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fY8bp-0005oe-1X
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fY8bm-00080k-8i
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:32719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fY8bl-0007zT-Vr
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:34 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed, 27 Jun 2018 19:27:22 +0800
Message-Id: <1530098844-236851-4-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 3/5] i386: Add CPUID bit for PCONFIG
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

PCONFIG: Platform configuration, enumerated by CPUID.(EAX=07H, ECX=0):
EDX[bit18].

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 953098c..c2c3cdb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -999,7 +999,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "pconfig", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", NULL,
             NULL, "arch-capabilities", NULL, "ssbd",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1ef2040..61d23e5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -687,6 +687,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
+#define CPUID_7_0_EDX_PCONFIG (1U << 18)       /* Platform Configuration */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities of RDCL_NO and IBRS_ALL*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
-- 
1.8.3.1
