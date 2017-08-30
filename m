Received: from eggs.gnu.org ([2001:4830:134:3::10]:57553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Gw-0003WT-9a
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Gv-0005oB-Iy
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6Gv-0005nk-C4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:38 +0200
Message-Id: <20170830165252.13421-31-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 30/44] target/s390x: move gtod_*() declarations
 to s390-virtio.h
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

The functions are not used in target/s390x/ so a header in hw/s390x/
is a better place.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-9-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio.h | 2 ++
 target/s390x/cpu.h     | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio.h
index f2377a3e0e..ca97fd6814 100644
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
index 3ce7ffc126..c40d70dd70 100644
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
2.13.5
