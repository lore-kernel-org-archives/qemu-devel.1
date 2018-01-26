Received: from eggs.gnu.org ([2001:4830:134:3::10]:47761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1efBjD-0004XZ-Cu
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1efBjA-0001Bb-3r
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:07 -0500
Received: from mail-by2nam01on0052.outbound.protection.outlook.com
	([104.47.34.52]:49248
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1efBj9-0001AF-OM
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:03 -0500
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 26 Jan 2018 16:39:43 -0500
Message-Id: <20180126213944.7594-5-babu.moger@amd.com>
In-Reply-To: <20180126213944.7594-1-babu.moger@amd.com>
References: <20180126213944.7594-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/5] target/i386: Enable TOPOEXT feature on AMD
 EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, pixo@polepetko.eu
Cc: mtosatti@redhat.com, babu.moger@amd.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

Enable TOPOEXT feature on EPYC CPU. This is required to support
hyperthreading on VM guests. These are supported via
CPUID_8000_001E extended functions.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 52591a1486..956ed112db 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1557,7 +1557,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
@@ -1572,7 +1573,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
-        .xlevel = 0x8000000A,
+        .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor",
     },
 };
-- 
2.16.0
