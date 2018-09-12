Received: from eggs.gnu.org ([2001:4830:134:3::10]:60615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aU-00072g-Hr
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aT-0003e3-PD
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:54 -0400
Received: from m12-15.163.com ([220.181.12.15]:52050)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aS-0003cd-Vy
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:53 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:13 -0700
Message-Id: <20180912160118.21158-4-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
References: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 3/8] hw: hyperv_testdev: add read callback
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
 hw/misc/hyperv_testdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index bf6bbfa8cf..7549f470b1 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -105,7 +105,12 @@ static void hv_synic_test_dev_control(HypervTestDev *dev, uint32_t ctl,
     }
 }
 
-static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
+static uint64_t hv_test_dev_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void hv_test_dev_write(void *opaque, hwaddr addr, uint64_t data,
                                 uint32_t len)
 {
     HypervTestDev *dev = HYPERV_TEST_DEV(opaque);
@@ -127,7 +132,8 @@ static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
 }
 
 static const MemoryRegionOps synic_test_sint_ops = {
-    .write = hv_test_dev_control,
+    .read = hv_test_dev_read,
+    .write = hv_test_dev_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
-- 
2.17.1
