Received: from eggs.gnu.org ([209.51.188.92]:59405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6v-00055g-1W
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6s-0003X3-GV
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:48 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:25 +0100
Message-Id: <1549305379-51117-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/77] i386: remove the new CPUID 'PCONFIG' from
 Icelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Robert Hoo <robert.hu@linux.intel.com>, qemu-stable@nongnu.org

From: Robert Hoo <robert.hu@linux.intel.com>

PCONFIG is not available to guests; it must be specifically enabled
using the PCONFIG_ENABLE execution control.  Disable it, because
no one can ever use it.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7483dae..4d21ae4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2650,8 +2650,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
             CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
         .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_PCONFIG | CPUID_7_0_EDX_SPEC_CTRL |
-            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
         /* Missing: XSAVES (not supported by some Linux versions,
                 * including v4.1 to v4.12).
                 * KVM doesn't yet expose any XSAVES state save component,
-- 
1.8.3.1
