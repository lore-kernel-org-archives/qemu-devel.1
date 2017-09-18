Received: from eggs.gnu.org ([2001:4830:134:3::10]:37695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUM-0007Nl-MW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUL-00088U-UO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUL-00087J-Nj
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:37 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:00 +0200
Message-Id: <20170918160012.4317-16-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 15/27] s390x/kvm: drop two debug prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Preparation for moving it out of kvm.c.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 01c4125d21..d759edf1c8 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1640,7 +1640,6 @@ int kvm_s390_cpu_restart(S390CPU *cpu)
     SigpInfo si = {};
 
     run_on_cpu(CPU(cpu), sigp_restart, RUN_ON_CPU_HOST_PTR(&si));
-    DPRINTF("DONE: KVM cpu restart: %p\n", &cpu->env);
     return 0;
 }
 
@@ -1742,7 +1741,6 @@ static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
         run_on_cpu(CPU(dst_cpu), sigp_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
         break;
     default:
-        DPRINTF("KVM: unknown SIGP: 0x%x\n", order);
         set_sigp_status(&si, SIGP_STAT_INVALID_ORDER);
     }
 
-- 
2.13.5
