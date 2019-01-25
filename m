Received: from eggs.gnu.org ([209.51.188.92]:59534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn9cA-0004vq-Os
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn9cA-0006F5-1q
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gn9c9-0006CY-EG
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:17 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 25 Jan 2019 20:06:06 -0200
Message-Id: <20190125220606.4864-3-ehabkost@redhat.com>
In-Reply-To: <20190125220606.4864-1-ehabkost@redhat.com>
References: <20190125220606.4864-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] i386: Make arch_capabilities migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Tao Xu <tao5.xu@intel.com>

Now that kvm_arch_get_supported_cpuid() will only return
arch_capabilities if QEMU is able to initialize the MSR properly,
we know that the feature is safely migratable.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f5412592d..3ff91d794d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1088,7 +1088,6 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_0_EDX_FEATURES,
-        .unmigratable_flags = CPUID_7_0_EDX_ARCH_CAPABILITIES,
     },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
-- 
2.18.0.rc1.1.g3f1ff2140
