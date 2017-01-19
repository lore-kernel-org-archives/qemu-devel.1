Received: from eggs.gnu.org ([2001:4830:134:3::10]:35843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUJvx-0007Gd-Vx
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUJvu-0005Gp-Nb
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:49 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cUJvu-0005DI-IJ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:46 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so1903128wmi.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 13:07:44 -0800 (PST)
Received: from donizetti.lan (94-39-143-196.adsl-ull.clienti.tiscali.it.
	[94.39.143.196])
	by smtp.gmail.com with ESMTPSA id r6sm917540wmd.4.2017.01.19.13.07.42
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 19 Jan 2017 13:07:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Jan 2017 22:07:41 +0100
Message-Id: <20170119210741.10814-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] KVM: PPC: eliminate unnecessary duplicate
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These are not needed since linux-headers/ provides up-to-date definitions.
The constants are in linux-headers/asm-powerpc/kvm.h.

The sole users, hw/intc/xics_kvm.c and target/ppc/kvm.c, include asm/kvm.h
via sysemu/kvm.h->linux/kvm.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/kvm_ppc.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index bd1d78b..4b43283 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -315,16 +315,4 @@ static inline void kvmppc_icbi_range(PowerPCCPU *cpu, uint8_t *addr, int len)
 
 #endif  /* CONFIG_KVM */
 
-#ifndef KVM_INTERRUPT_SET
-#define KVM_INTERRUPT_SET -1
-#endif
-
-#ifndef KVM_INTERRUPT_UNSET
-#define KVM_INTERRUPT_UNSET -2
-#endif
-
-#ifndef KVM_INTERRUPT_SET_LEVEL
-#define KVM_INTERRUPT_SET_LEVEL -3
-#endif
-
 #endif /* KVM_PPC_H */
-- 
2.9.3
