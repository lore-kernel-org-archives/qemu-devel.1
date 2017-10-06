Received: from eggs.gnu.org ([2001:4830:134:3::10]:59140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRj-0006aA-AI
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRf-0008Mu-LQ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRf-0008MW-FO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:27 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:47 +0200
Message-Id: <20171006095956.27534-25-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 24/33] s390x: introduce and use S390_MAX_CPUS
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

Will be handy in the future.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928134609.16985-6-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 target/s390x/cpu.h         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 679a1a858c..14a0545e6f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -423,7 +423,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
     mc->no_sdcard = 1;
     mc->use_sclp = 1;
-    mc->max_cpus = 248;
+    mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
     mc->get_hotplug_handler = s390_get_hotplug_handler;
     mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ff3cc59c02..7e864c8478 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -60,6 +60,8 @@
 #define PSW_MCHK_MASK 0x0004000000000000
 #define PSW_IO_MASK 0x0200000000000000
 
+#define S390_MAX_CPUS 248
+
 typedef struct PSW {
     uint64_t mask;
     uint64_t addr;
-- 
2.13.6
