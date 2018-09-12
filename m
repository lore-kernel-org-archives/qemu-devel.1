Received: from eggs.gnu.org ([2001:4830:134:3::10]:60699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07ab-000776-Tq
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aZ-0003i4-35
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:01 -0400
Received: from m12-15.163.com ([220.181.12.15]:53512)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aY-0003fw-Dj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:59 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:18 -0700
Message-Id: <20180912160118.21158-9-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
References: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 8/8] exec: add read callback for notdirty
 memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 exec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/exec.c b/exec.c
index 6826c8337d..3cd5ad2cae 100644
--- a/exec.c
+++ b/exec.c
@@ -2681,6 +2681,11 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
     }
 }
 
+static uint64_t notdirty_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
 /* Called within RCU critical section.  */
 static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
                                uint64_t val, unsigned size)
@@ -2702,6 +2707,7 @@ static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps notdirty_mem_ops = {
+    .read = notdirty_mem_read,
     .write = notdirty_mem_write,
     .valid.accepts = notdirty_mem_accepts,
     .endianness = DEVICE_NATIVE_ENDIAN,
@@ -2965,6 +2971,7 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
     return phys_section_add(map, &section);
 }
 
+
 static void readonly_mem_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
-- 
2.17.1
