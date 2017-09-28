Received: from eggs.gnu.org ([2001:4830:134:3::10]:40840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9U-0006yj-BN
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9T-0002YA-Ip
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxZ9T-0002Xp-9q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:55 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 15:46:09 +0200
Message-Id: <20170928134609.16985-6-david@redhat.com>
In-Reply-To: <20170928134609.16985-1-david@redhat.com>
References: <20170928134609.16985-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/5] s390x: introduce and use S390_MAX_CPUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>

Will be handy in the future.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 target/s390x/cpu.h         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ab234247f6..dfc107b400 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -421,7 +421,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
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
2.13.5
