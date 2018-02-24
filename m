Received: from eggs.gnu.org ([2001:4830:134:3::10]:51815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1epPbx-000290-IW
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1epPbu-0000UV-G6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:53 -0500
Received: from mail-bl2nam02on0055.outbound.protection.outlook.com
	([104.47.38.55]:35904
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1epPbu-0000U4-1z
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:50 -0500
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 23 Feb 2018 21:30:21 -0500
Message-Id: <1519439425-27883-2-git-send-email-babu.moger@amd.com>
In-Reply-To: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/5] target/i386: Fix a minor typo found
 while reviwing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pixo@polepetko.eu, Gary.Hook@amd.com, babu.moger@amd.com

Changed KVM_CPUID_FLAG_SIGNIFCANT_INDEX to KVM_CPUID_FLAG_SIGNIFICANT_INDEX

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 linux-headers/asm-x86/kvm.h | 2 +-
 target/i386/kvm.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index f3a9604..6aec661 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -220,7 +220,7 @@ struct kvm_cpuid_entry2 {
 	__u32 padding[3];
 };
 
-#define KVM_CPUID_FLAG_SIGNIFCANT_INDEX		(1 << 0)
+#define KVM_CPUID_FLAG_SIGNIFICANT_INDEX	(1 << 0)
 #define KVM_CPUID_FLAG_STATEFUL_FUNC		(1 << 1)
 #define KVM_CPUID_FLAG_STATE_READ_NEXT		(1 << 2)
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ad4b159..85856b6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -844,7 +844,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
                     break;
                 }
                 c->function = i;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->flags = KVM_CPUID_FLAG_SIGNIFICANT_INDEX;
                 c->index = j;
                 cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
 
-- 
1.8.3.1
