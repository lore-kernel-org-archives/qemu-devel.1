Received: from eggs.gnu.org ([2001:4830:134:3::10]:48610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTex-0005LZ-Vf
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTev-0006JW-L6
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqTeq-0006Gu-D8
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:34 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 16 Aug 2018 22:33:57 -0300
Message-Id: <20180817013400.13353-6-ehabkost@redhat.com>
In-Reply-To: <20180817013400.13353-1-ehabkost@redhat.com>
References: <20180817013400.13353-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] i386: Add CPUID bit for WBNOINVD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>

From: Robert Hoo <robert.hu@linux.intel.com>

WBNOINVD: Write back and do not invalidate cache, enumerated by
CPUID.(EAX=80000008H, ECX=0):EBX[bit 9].

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1530781798-183214-5-git-send-email-robert.hu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 2 ++
 target/i386/cpu.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4a95c63640..9cad5812cd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -694,6 +694,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
+#define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
+                                                                             do not invalidate cache */
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3e25773d26..4f08cedfcf 100644
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
-- 
2.18.0.rc1.1.g3f1ff2140
