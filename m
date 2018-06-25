Received: from eggs.gnu.org ([2001:4830:134:3::10]:54326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvc-0001qU-S0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvb-0003Et-Q8
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvb-0003EE-Jo
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:20 -0300
Message-Id: <20180625222524.382-9-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/12] i386: Define AMD's no SSB mitigation
 needed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

AMD future CPUs expose a mechanism to tell the guest that the
Speculative Store Bypass Disable is not needed and that the
CPU is all good.

This is exposed via the CPUID 8000_0008.EBX[26] bit.

See 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf

A copy of this document is available at
        https://bugzilla.kernel.org/show_bug.cgi?id=199889

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-Id: <20180601153809.15259-3-konrad.wilk@oracle.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7234bebfcb..7a4484bb06 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1009,7 +1009,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "ibpb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "amd-ssbd", "virt-ssbd", NULL, NULL,
+            "amd-ssbd", "virt-ssbd", "amd-no-ssb", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 0x80000008,
-- 
2.18.0.rc1.1.g3f1ff2140
