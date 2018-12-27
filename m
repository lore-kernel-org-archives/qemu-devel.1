Received: from eggs.gnu.org ([208.118.235.92]:39476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gcLfG-0004SE-Nw
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gcLfC-00049T-Jh
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:35524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gcLfC-0003oN-5s
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:46 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Thu, 27 Dec 2018 10:43:03 +0800
Message-Id: <20181227024304.12182-2-tao3.xu@intel.com>
In-Reply-To: <20181227024304.12182-1-tao3.xu@intel.com>
References: <20181227024304.12182-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 1/2] i386: Update stepping of Cascadelake-Server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, tao3.xu@intel.com, robert.hu@linux.intel.com, mark.kanda@oracle.com

Update the stepping from 5 to 6, in order that
the Cascadelake-Server CPU model can support AVX512VNNI
and MSR based features exposed by ARCH_CAPABILITIES.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 include/hw/i386/pc.h | 4 ++++
 target/i386/cpu.c    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c7c0c944e8..95453968db 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -300,6 +300,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "intel-iommu",\
         .property = "dma-drain",\
         .value    = "off",\
+    },{\
+        .driver   = "Cascadelake-Server" "-" TYPE_X86_CPU,\
+        .property = "stepping",\
+        .value    = "5",\
     },
 
 #define PC_COMPAT_3_0 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 677a3bd5fb..09706ad51a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2466,7 +2466,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .vendor = CPUID_VENDOR_INTEL,
         .family = 6,
         .model = 85,
-        .stepping = 5,
+        .stepping = 6,
         .features[FEAT_1_EDX] =
             CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
             CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-- 
2.17.1
