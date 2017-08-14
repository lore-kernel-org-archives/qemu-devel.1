Received: from eggs.gnu.org ([2001:4830:134:3::10]:36189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dhIPk-0002db-B2
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dhIPf-0001TR-GN
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:40:28 -0400
Received: from mail-co1nam03on0062.outbound.protection.outlook.com
	([104.47.40.62]:34951
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1dhIPf-0001S7-40
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:40:23 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 14 Aug 2017 11:40:02 -0500
Message-Id: <20170814164002.23982-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] target-i386/cpu: Add new EPYC CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>

Add a new base CPU model called 'EPYC' to model processors from AMD EPYC
family (which includes EPYC 76xx,75xx,74xx, 73xx and 72xx).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---

Changes since v1:
 * fix typo EYPC -> EPYC to reflect the correct branding name

 target/i386/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ddc45ab..20de5fd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1522,6 +1522,50 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x8000001A,
         .model_id = "AMD Opteron 63xx class CPU",
     },
+    {
+        .name = "EPYC",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 23,
+        .model = 1,
+        .stepping = 2,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_MOVBE | CPUID_EXT_POPCNT |
+            CPUID_EXT_SSE42 | CPUID_EXT_SSE41 | CPUID_EXT_CX16 |
+            CPUID_EXT_FMA | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_SHA_NI,
+        /* Missing: XSAVES (not supported by some Linux versions,
+         * including v4.1 to v4.12).
+         * KVM doesn't yet expose any XSAVES state save component.
+         */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .xlevel = 0x8000001F,
+        .model_id = "AMD EPYC Processor",
+    },
 };
 
 typedef struct PropValue {
-- 
2.9.4
