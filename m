Received: from eggs.gnu.org ([2001:4830:134:3::10]:50029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fadkd-0001hG-Nb
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fadkZ-0007Oq-Uq
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:07:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fadkZ-0007OO-JS
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:06:59 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed,  4 Jul 2018 17:06:35 +0800
Message-Id: <1530695199-27601-2-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1530695199-27601-1-git-send-email-robert.hu@linux.intel.com>
References: <1530695199-27601-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 1/5] i386: Add new MSR indices for
 IA32_PRED_CMD and IA32_ARCH_CAPABILITIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

IA32_PRED_CMD MSR gives software a way to issue commands that affect the state
of indirect branch predictors. Enumerated by CPUID.(EAX=7H,ECX=0):EDX[26].
IA32_ARCH_CAPABILITIES MSR enumerates architectural features of RDCL_NO,
IBRS_ALL, RSBA, SSB_NO. Enumerated by CPUID.(EAX=07H, ECX=0):EDX[29].

https://software.intel.com/sites/default/files/managed/c5/63/336996-Speculative-Execution-Side-Channel-Mitigations.pdf

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2c5a0d9..ae97005 100644
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
1.8.3.1
