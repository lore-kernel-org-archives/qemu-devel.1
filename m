Received: from eggs.gnu.org ([2001:4830:134:3::10]:60697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07ab-000774-Te
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aX-0003gj-Rg
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:01 -0400
Received: from m12-15.163.com ([220.181.12.15]:53337)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aX-0003el-49
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:57 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:17 -0700
Message-Id: <20180912160118.21158-8-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
References: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 7/8] hw: sun4c: add read memory region callback
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
 hw/sparc64/sun4u.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d16843b30e..74c55a82f4 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -212,6 +212,11 @@ typedef struct PowerDevice {
     MemoryRegion power_mmio;
 } PowerDevice;
 
+static uint64_t power_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
 /* Power */
 static void power_mem_write(void *opaque, hwaddr addr,
                             uint64_t val, unsigned size)
@@ -223,6 +228,7 @@ static void power_mem_write(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps power_mem_ops = {
+    .read = power_mem_read,
     .write = power_mem_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
-- 
2.17.1
