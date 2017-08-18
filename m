Received: from eggs.gnu.org ([2001:4830:134:3::10]:49315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhQ-000263-IE
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhP-0007ER-RS
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhP-0007E5-Kz
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:23 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:43 +0200
Message-Id: <20170818114353.13455-9-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 08/18] target/s390x: move gtod_*()
 declarations to s390-virtio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio.h | 2 ++
 target/s390x/cpu.h     | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio.h
index f2377a3..ca97fd6 100644
--- a/hw/s390x/s390-virtio.h
+++ b/hw/s390x/s390-virtio.h
@@ -30,4 +30,6 @@ void s390_create_virtio_net(BusState *bus, const char *name);
 void s390_nmi(NMIState *n, int cpu_index, Error **errp);
 void s390_machine_reset(void);
 void s390_memory_init(ram_addr_t mem_size);
+void gtod_save(QEMUFile *f, void *opaque);
+int gtod_load(QEMUFile *f, void *opaque, int version_id);
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 3ce7ffc..c40d70d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -594,9 +594,6 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
     return cpu->env.cpu_state;
 }
 
-void gtod_save(QEMUFile *f, void *opaque);
-int gtod_load(QEMUFile *f, void *opaque, int version_id);
-
 void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
                     uint64_t param64);
 
-- 
2.9.4
