Received: from eggs.gnu.org ([2001:4830:134:3::10]:53465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZU-0004Jy-JK
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZQ-0003Me-Lv
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfZQ-0003M6-Fi
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:08 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:53 +0200
Message-Id: <20170928203708.9376-16-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/30] s390x/kvm: drop two debug prints
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Preparation for moving it out of kvm.c.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1aec1e26d4..fbbdca23b2 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1642,7 +1642,6 @@ int kvm_s390_cpu_restart(S390CPU *cpu)
     SigpInfo si = {};
 
     run_on_cpu(CPU(cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
-    DPRINTF("DONE: KVM cpu restart: %p\n", &cpu->env);
     return 0;
 }
 
@@ -1744,7 +1743,6 @@ static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
         run_on_cpu(CPU(dst_cpu), sigp_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
         break;
     default:
-        DPRINTF("KVM: unknown SIGP: 0x%x\n", order);
         set_sigp_status(&si, SIGP_STAT_INVALID_ORDER);
     }
 
-- 
2.13.5
