Received: from eggs.gnu.org ([2001:4830:134:3::10]:38123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1l-0003Ca-PJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1j-0005t2-QP
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:27:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo1j-0005sh-KF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:27:55 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:26 -0200
Message-Id: <20170123232738.20796-2-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/13] x86: add AVX512_VPOPCNTDQ features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, He Chen <he.chen@linux.intel.com>

From: He Chen <he.chen@linux.intel.com>

AVX512_VPOPCNTDQ: Vector POPCNT instructions for word and qwords.
variable precision.

Signed-off-by: He Chen <he.chen@linux.intel.com>
Message-Id: <1484272411-28073-1-git-send-email-he.chen@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6c1902b36e..10c5a3538d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -630,6 +630,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_UMIP     (1U << 2)
 #define CPUID_7_0_ECX_PKU      (1U << 3)
 #define CPUID_7_0_ECX_OSPKE    (1U << 4)
+#define CPUID_7_0_ECX_AVX512_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
 #define CPUID_7_0_ECX_LA57     (1U << 16)
 #define CPUID_7_0_ECX_RDPID    (1U << 22)
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aba11ae171..b6c8c5d65b 100644
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
-- 
2.11.0.259.g40922b1
