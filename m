Received: from eggs.gnu.org ([2001:4830:134:3::10]:45206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gaEK7-0005uT-9v
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gaEK3-0008Ns-AY
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:30:15 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 21 Dec 2018 07:30:02 +0100
Message-Id: <20181221063002.7570-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] i386: remove the 'INTEL_PT' CPUID bit from
 named CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>, qemu-stable@nongnu.org

From: Robert Hoo <robert.hu@linux.intel.com>

Processor tracing is not yet implemented for KVM and it will be an
opt in feature requiring a special module parameter.
Disable it, because it is wrong to enable it by default and
it is impossible that no one has ever used it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dae46f0319..9c54c41e7a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2493,8 +2493,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
-            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
-            CPUID_7_0_EBX_INTEL_PT,
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
         .features[FEAT_7_0_ECX] =
             CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
             CPUID_7_0_ECX_AVX512VNNI,
@@ -2546,7 +2545,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
-            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_INTEL_PT,
+            CPUID_7_0_EBX_SMAP,
         .features[FEAT_7_0_ECX] =
             CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
             CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
@@ -2604,8 +2603,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
-            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
-            CPUID_7_0_EBX_INTEL_PT,
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
         .features[FEAT_7_0_ECX] =
             CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
             CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
-- 
2.20.1
