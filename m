Received: from eggs.gnu.org ([2001:4830:134:3::10]:54315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvb-0001oX-3n
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZva-0003DJ-1s
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvZ-0003Ca-Rg
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:19 -0300
Message-Id: <20180625222524.382-8-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/12] i386: define the AMD 'amd-ssbd' CPUID
 feature bit
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

AMD future CPUs expose _two_ ways to utilize the Intel equivalant
of the Speculative Store Bypass Disable. The first is via
the virtualized VIRT_SPEC CTRL MSR (0xC001_011f) and the second
is via the SPEC_CTRL MSR (0x48). The document titled:
124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf

gives priority of SPEC CTRL MSR over the VIRT SPEC CTRL MSR.

A copy of this document is available at
      https://bugzilla.kernel.org/show_bug.cgi?id=199889

Anyhow, this means that on future AMD CPUs there will be  _two_ ways to
deal with SSBD.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-Id: <20180601153809.15259-2-konrad.wilk@oracle.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d7dfefcde0..7234bebfcb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1009,7 +1009,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "ibpb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, "virt-ssbd", NULL, NULL,
+            "amd-ssbd", "virt-ssbd", NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 0x80000008,
-- 
2.18.0.rc1.1.g3f1ff2140
