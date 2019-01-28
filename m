Received: from eggs.gnu.org ([209.51.188.92]:40846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCjz-0000oc-UE
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCjz-0002ac-5i
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1goCjy-0002Yx-SJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:38:43 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 28 Jan 2019 17:38:33 -0200
Message-Id: <20190128193834.3823-2-ehabkost@redhat.com>
In-Reply-To: <20190128193834.3823-1-ehabkost@redhat.com>
References: <20190128193834.3823-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] i386: Update stepping of Cascadelake-Server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Tao Xu <tao3.xu@intel.com>

From: Tao Xu <tao3.xu@intel.com>

Update the stepping from 5 to 6, in order that
the Cascadelake-Server CPU model can support AVX512VNNI
and MSR based features exposed by ARCH_CAPABILITIES.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20181227024304.12182-2-tao3.xu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c      | 1 +
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 747548b7aa..94ac9dee3d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -122,6 +122,7 @@ GlobalProperty pc_compat_3_1[] = {
     { "Cascadelake-Server" "-" TYPE_X86_CPU,  "mpx", "on" },
     { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
     { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
+    { "Cascadelake-Server" "-" TYPE_X86_CPU, "stepping", "5" },
 };
 const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f5412592d..43df813327 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2503,7 +2503,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .vendor = CPUID_VENDOR_INTEL,
         .family = 6,
         .model = 85,
-        .stepping = 5,
+        .stepping = 6,
         .features[FEAT_1_EDX] =
             CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
             CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-- 
2.18.0.rc1.1.g3f1ff2140
