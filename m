Received: from eggs.gnu.org ([2001:4830:134:3::10]:54291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvY-0001m7-Gl
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvV-00039B-AB
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvV-00038i-35
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:17 -0300
Message-Id: <20180625222524.382-6-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] i386: Remove osxsave CPUID flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

OSXAVE is not a static feature flag: it changes dynamically at
runtime depending on CR4, and it was never configurable: KVM
never returned OSXSAVE on GET_SUPPORTED_CPUID, and it is not
included in TCG_EXT_FEATURES.

Remove OSXSAVE from the feature name array so users don't try to
configure it manually.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180611203855.13269-1-ehabkost@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9da4920421..60deae3100 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -788,7 +788,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fma", "cx16", "xtpr", "pdcm",
             NULL, "pcid", "dca", "sse4.1",
             "sse4.2", "x2apic", "movbe", "popcnt",
-            "tsc-deadline", "aes", "xsave", "osxsave",
+            "tsc-deadline", "aes", "xsave", NULL /* osxsave */,
             "avx", "f16c", "rdrand", "hypervisor",
         },
         .cpuid_eax = 1, .cpuid_reg = R_ECX,
-- 
2.18.0.rc1.1.g3f1ff2140
