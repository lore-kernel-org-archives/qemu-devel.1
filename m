Received: from eggs.gnu.org ([2001:4830:134:3::10]:45479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJyr-0003bB-P4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJyo-0000H6-Fb
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJyo-0000Gu-9q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:58:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:14 +0200
Message-Id: <20170919145636.9389-17-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 16/38] s390x: move subsystem_reset() to
 s390-virtio-ccw.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Implemented in s390-virtio-ccw.c, so move it to the right header.
We can also drop the extern. Fix up one include.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-7-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/hw/s390x/s390-virtio-ccw.h | 2 ++
 target/s390x/cpu.h                 | 1 -
 target/s390x/diag.c                | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 41a9d2862b..a9a90c2022 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -56,4 +56,6 @@ bool gs_allowed(void);
  */
 bool css_migration_enabled(void);
 
+void subsystem_reset(void);
+
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7073fa59e9..372f7d8885 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -721,7 +721,6 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
-extern void subsystem_reset(void);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index e6b5e6de37..82a623948d 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -20,6 +20,7 @@
 #include "hw/watchdog/wdt_diag288.h"
 #include "sysemu/cpus.h"
 #include "hw/s390x/ipl.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 static int modified_clear_reset(S390CPU *cpu)
 {
-- 
2.13.5
