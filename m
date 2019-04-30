Received: from eggs.gnu.org ([209.51.188.92]:49104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLWac-0007yv-Nr
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLWab-0005og-Oz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:30:46 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hLWaa-0005mQ-BR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:30:45 -0400
Received: by mail-pl1-x642.google.com with SMTP id o5so7039185pls.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:30:43 -0700 (PDT)
From: Boxuan Li <liboxuan@connect.hku.hk>
Date: Wed,  1 May 2019 01:28:42 +0800
Message-Id: <20190430172842.27369-1-liboxuan@connect.hku.hk>
Subject: [Qemu-devel] [PATCH] target/ppc/kvm: Fix trace typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Boxuan Li <liboxuan@connect.hku.hk>, David Gibson <david@gibson.dropbear.id.au>, "open list:PowerPC" <qemu-ppc@nongnu.org>

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
 target/ppc/kvm.c        | 2 +-
 target/ppc/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 02e22e2017..1a9caf8f40 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1721,7 +1721,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             trace_kvm_handle_dcr_write();
             ret = kvmppc_handle_dcr_write(env, run->dcr.dcrn, run->dcr.data);
         } else {
-            trace_kvm_handle_drc_read();
+            trace_kvm_handle_dcr_read();
             ret = kvmppc_handle_dcr_read(env, run->dcr.dcrn, &run->dcr.data);
         }
         break;
diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index 7b3cfe11fd..3dc6740706 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -22,7 +22,7 @@ kvm_failed_put_vpa(void) "Warning: Unable to set VPA information to KVM"
 kvm_failed_get_vpa(void) "Warning: Unable to get VPA information from KVM"
 kvm_injected_interrupt(int irq) "injected interrupt %d"
 kvm_handle_dcr_write(void) "handle dcr write"
-kvm_handle_drc_read(void) "handle dcr read"
+kvm_handle_dcr_read(void) "handle dcr read"
 kvm_handle_halt(void) "handle halt"
 kvm_handle_papr_hcall(void) "handle PAPR hypercall"
 kvm_handle_epr(void) "handle epr"
-- 
2.13.2
