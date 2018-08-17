Received: from eggs.gnu.org ([2001:4830:134:3::10]:48291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTef-00056i-PQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTed-00066O-2c
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqTea-000645-Ai
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 16 Aug 2018 22:33:54 -0300
Message-Id: <20180817013400.13353-3-ehabkost@redhat.com>
In-Reply-To: <20180817013400.13353-1-ehabkost@redhat.com>
References: <20180817013400.13353-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] i386: Add new MSR indices for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>

From: Robert Hoo <robert.hu@linux.intel.com>

IA32_PRED_CMD MSR gives software a way to issue commands that affect the state
of indirect branch predictors. Enumerated by CPUID.(EAX=7H,ECX=0):EDX[26].
IA32_ARCH_CAPABILITIES MSR enumerates architectural features of RDCL_NO and
IBRS_ALL. Enumerated by CPUID.(EAX=07H, ECX=0):EDX[29].

https://software.intel.com/sites/default/files/managed/c5/63/336996-Speculative-Execution-Side-Channel-Mitigations.pdf

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1530781798-183214-2-git-send-email-robert.hu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c18863ec7a..b5c6686fe2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -354,6 +354,8 @@ typedef enum X86Seg {
 #define MSR_TSC_ADJUST                  0x0000003b
 #define MSR_IA32_SPEC_CTRL              0x48
 #define MSR_VIRT_SSBD                   0xc001011f
+#define MSR_IA32_PRED_CMD               0x49
+#define MSR_IA32_ARCH_CAPABILITIES      0x10a
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
-- 
2.18.0.rc1.1.g3f1ff2140
