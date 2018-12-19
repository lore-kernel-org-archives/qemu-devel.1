Received: from eggs.gnu.org ([2001:4830:134:3::10]:48403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZc9l-0003wo-Uy
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZc9j-0005kX-9f
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:45:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gZc9i-0005da-SN
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:44:59 -0500
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed, 19 Dec 2018 21:44:41 +0800
Message-Id: <1545227081-213696-3-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH 2/2] Revert "i386: Add CPUID bit for PCONFIG"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: qemu-devel@nongnu.org, robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

This reverts commit 5131dc433df54b37e8e918d8fba7fe10344e7a7b.
For new instruction 'PCONFIG' will not be exposed to guest.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6113d0..08d4307 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1040,7 +1040,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, "pconfig", NULL,
+            NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
             NULL, "arch-capabilities", NULL, "ssbd",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ef41a03..66707d7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -692,7 +692,6 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
-#define CPUID_7_0_EDX_PCONFIG (1U << 18)       /* Platform Configuration */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
-- 
1.8.3.1
