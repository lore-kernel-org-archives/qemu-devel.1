Received: from eggs.gnu.org ([2001:4830:134:3::10]:36633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fXIMJ-0001mK-J7
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fXIMF-0007sr-NR
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:40:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:25155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fXIMF-0007sW-EU
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:40:03 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Mon, 25 Jun 2018 11:39:20 +0800
Message-Id: <1529897961-134132-5-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
References: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH 4/5] i386: Add CPUID bit for WBNOINVD
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

WBNOINVD: Write back and do not invalidate cache, enumerated by
CPUID.(EAX=80000008H, ECX=0):EBX[bit 9].

Reference:
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9e038c3..821b7bd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -923,7 +923,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "wbnoinvd", NULL, NULL,
             "ibpb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 61d23e5..c67216d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -692,6 +692,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities of RDCL_NO and IBRS_ALL*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
+#define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and do not invalidate cache */
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
-- 
1.8.3.1
