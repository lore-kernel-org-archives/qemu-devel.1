Received: from eggs.gnu.org ([2001:4830:134:3::10]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07ae-00078y-IX
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07ac-0003k4-OL
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:04 -0400
Received: from m12-15.163.com ([220.181.12.15]:53165)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07ab-0003ej-5I
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:02 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:16 -0700
Message-Id: <20180912160118.21158-7-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
References: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 6/8] hw: pvrdma: add read memory region callback
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
 hw/rdma/vmw/pvrdma_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index ca5fa8d981..a6211d416d 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -455,6 +455,11 @@ static const MemoryRegionOps regs_ops = {
     },
 };
 
+static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
 static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 {
     PVRDMADev *dev = opaque;
@@ -496,6 +501,7 @@ static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps uar_ops = {
+    .read = uar_read,
     .write = uar_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
-- 
2.17.1
