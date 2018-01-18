Received: from eggs.gnu.org ([2001:4830:134:3::10]:43399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzWw-0002O5-QY
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzWt-0003t5-No
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzWt-0003rl-Hb
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:11 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:01:54 -0200
Message-Id: <20180118020157.25401-6-ehabkost@redhat.com>
In-Reply-To: <20180118020157.25401-1-ehabkost@redhat.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] i386: Add spec-ctrl CPUID bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Add the feature name and a CPUID_7_0_EDX_SPEC_CTRL macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180109154519.25634-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 10264b2e31..d7bae242cd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -667,6 +667,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
+#define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0e26fa4ea7..7f815458a5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -459,7 +459,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "spec-ctrl", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 7,
-- 
2.14.3
