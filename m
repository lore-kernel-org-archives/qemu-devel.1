Received: from eggs.gnu.org ([2001:4830:134:3::10]:51837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bernat@luffy.cx>) id 1eYeO1-0004XR-Vn
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bernat@luffy.cx>) id 1eYeNx-00034W-T5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:51:14 -0500
Received: from bart.luffy.cx ([78.47.78.131]:47427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bernat@luffy.cx>) id 1eYeNx-00030q-Cm
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:51:09 -0500
From: Vincent Bernat <vincent@bernat.im>
Date: Mon,  8 Jan 2018 21:50:52 +0100
Message-Id: <20180108205052.24385-1-vincent@bernat.im>
Subject: [Qemu-devel] [PATCH] target-i386: add pcid to both Sandy Bridge and
 Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Vincent Bernat <vincent@bernat.im>

PCID has been introduced in Sandy Bridge and, currently, KVM doesn't
object exposing it to VM as long as it is present on the host. Update
CPU model for both Sandy Bridge and Ivy Bridge accordingly.

Signed-off-by: Vincent Bernat <vincent@bernat.im>
---
 target/i386/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3818d7283158..bb2b4bd1b4fe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1109,7 +1109,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
             CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
             CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3,
+            CPUID_EXT_SSE3 | CPUID_EXT_PCID,
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
             CPUID_EXT2_SYSCALL,
@@ -1140,7 +1140,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
             CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
             CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
-            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND |
+            CPUID_EXT_PCID,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_ERMS,
-- 
2.15.1
