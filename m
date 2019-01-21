Received: from eggs.gnu.org ([209.51.188.92]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyN-0004ct-1I
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyM-0004Rc-5l
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:59 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyL-0004Qk-VJ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:58 -0500
Received: by mail-wr1-x42a.google.com with SMTP id r10so24429902wrs.10
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:05 +0100
Message-Id: <1548093980-43088-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/49] Revert "i386: Add CPUID bit for PCONFIG"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Robert Hoo <robert.hu@linux.intel.com>

From: Robert Hoo <robert.hu@linux.intel.com>

This reverts commit 5131dc433df54b37e8e918d8fba7fe10344e7a7b.
For new instruction 'PCONFIG' will not be exposed to guest.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1545227081-213696-3-git-send-email-robert.hu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2bcab80..d8430b4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1077,7 +1077,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, "pconfig", NULL,
+            NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
             NULL, "arch-capabilities", NULL, "ssbd",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 59656a7..95112b9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -694,7 +694,6 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
-#define CPUID_7_0_EDX_PCONFIG (1U << 18)       /* Platform Configuration */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
-- 
1.8.3.1
