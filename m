Received: from eggs.gnu.org ([2001:4830:134:3::10]:48407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZc9l-0003wq-Vo
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1gZc9i-0005kH-HG
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:45:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:35098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1gZc9i-0005eo-4e
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 08:44:58 -0500
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed, 19 Dec 2018 21:44:40 +0800
Message-Id: <1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH 1/2] i386: remove the new CPUID 'PCONFIG' from
 Icelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com
Cc: qemu-devel@nongnu.org, robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 677a3bd..b6113d0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2613,8 +2613,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
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
