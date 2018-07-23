Received: from eggs.gnu.org ([2001:4830:134:3::10]:41691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJJ-0002Us-Km
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJI-0004BP-KF
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:01 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:51 -0500
Message-Id: <20180723201748.25573-43-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 42/99] i386: define the 'ssbd' CPUID feature
 bit (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

New microcode introduces the "Speculative Store Bypass Disable"
CPUID feature bit. This needs to be exposed to guest OS to allow
them to protect against CVE-2018-3639.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-Id: <20180521215424.13520-2-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit d19d1f965904a533998739698020ff4ee8a103da)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a20fe26573..2f5263e22f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -510,7 +510,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "ssbd",
         },
         .cpuid_eax = 7,
         .cpuid_needs_ecx = true, .cpuid_ecx = 0,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1b219fafc4..970ab96e54 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -684,6 +684,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
+#define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
 #define KVM_HINTS_DEDICATED (1U << 0)
 
-- 
2.17.1
