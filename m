Received: from eggs.gnu.org ([2001:4830:134:3::10]:56870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fOm8C-0002tx-2N
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fOm88-0003C4-4F
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1fOm87-0003Az-R6
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:16 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Fri,  1 Jun 2018 11:38:09 -0400
Message-Id: <20180601153809.15259-3-konrad.wilk@oracle.com>
In-Reply-To: <20180601153809.15259-1-konrad.wilk@oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
Subject: [Qemu-devel] [PATCH 2/2] i386: Define AMD's no SSB mitigation
 needed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

AMD future CPUs expose a mechanism to tell the guest that the
Speculative Store Bypass Disable is not needed and that the
CPU is all good.

This is exposed via the CPUID 8000_0008.EBX[26] bit.

See 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf

A copy of this document is available at
        https://bugzilla.kernel.org/show_bug.cgi?id=199889

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f91990c..43b1532 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -490,7 +490,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "ibpb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "amd-ssbd", "virt-ssbd", NULL, NULL,
+            "amd-ssbd", "virt-ssbd", "amd-no-ssb", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 0x80000008,
-- 
1.8.3.1
