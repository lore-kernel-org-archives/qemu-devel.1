Received: from eggs.gnu.org ([2001:4830:134:3::10]:58789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vta-0002iL-Qq
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vta-0003KU-1x
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:22 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:49 +0200
Message-Id: <20171020115418.2050-18-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 17/46] s390x/kvm: drop two debug prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Preparation for moving it out of kvm.c.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-16-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index bf6740df56..1950291f95 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1679,7 +1679,6 @@ int kvm_s390_cpu_restart(S390CPU *cpu)
     SigpInfo si = {};
 
     run_on_cpu(CPU(cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
-    DPRINTF("DONE: KVM cpu restart: %p\n", &cpu->env);
     return 0;
 }
 
@@ -1781,7 +1780,6 @@ static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
         run_on_cpu(CPU(dst_cpu), sigp_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
         break;
     default:
-        DPRINTF("KVM: unknown SIGP: 0x%x\n", order);
         set_sigp_status(&si, SIGP_STAT_INVALID_ORDER);
     }
 
-- 
2.13.6
