Received: from eggs.gnu.org ([2001:4830:134:3::10]:53625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIe-0004Fg-7x
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIa-0006V5-Jg
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZIa-0006TT-Dj
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:12 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FC8585542
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 13:32:12 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-138.ams2.redhat.com
	[10.36.117.138])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0KDVeVa014401
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 08:32:11 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:32 +0100
Message-Id: <20170120133139.31080-29-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/35] KVM: PPC: eliminate unnecessary duplicate
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
