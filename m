Received: from eggs.gnu.org ([2001:4830:134:3::10]:41057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1cRr3q-0004Bv-7t
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1cRr3l-0001Xb-D2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:53:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:22470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <he.chen@linux.intel.com>)
	id 1cRr3l-0001Va-3X
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 20:53:41 -0500
From: He Chen <he.chen@linux.intel.com>
Date: Fri, 13 Jan 2017 09:53:31 +0800
Message-Id: <1484272411-28073-1-git-send-email-he.chen@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2] x86: add AVX512_VPOPCNTDQ features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, He Chen <he.chen@intel.com>

AVX512_VPOPCNTDQ: Vector POPCNT instructions for word and qwords.
variable precision.

Signed-off-by: He Chen <he.chen@linux.intel.com>
---
Changes from v1:
* Rename vpopcntdq to avx512-vpopcntdq.
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b0640f1..1a4b164 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -435,7 +435,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "avx512vbmi", "umip", "pku",
             "ospke", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
             NULL, NULL, "rdpid", NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a04e46b..37b209e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -630,6 +630,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_UMIP     (1U << 2)
 #define CPUID_7_0_ECX_PKU      (1U << 3)
 #define CPUID_7_0_ECX_OSPKE    (1U << 4)
+#define CPUID_7_0_ECX_AVX512_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 
-- 
2.7.4
