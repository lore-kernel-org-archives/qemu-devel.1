Received: from eggs.gnu.org ([2001:4830:134:3::10]:60599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aT-00071k-AB
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aS-0003dc-Lj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:53 -0400
Received: from m12-15.163.com ([220.181.12.15]:51598)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aR-0003ax-RU
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:52 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:11 -0700
Message-Id: <20180912160118.21158-2-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
References: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 1/8] fw_cfg_mem: add read memory region callback
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
 hw/nvram/fw_cfg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index d79a568f54..6de7809f1a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -434,6 +434,11 @@ static bool fw_cfg_data_mem_valid(void *opaque, hwaddr addr,
     return addr == 0;
 }
 
+static uint64_t fw_cfg_ctl_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
 static void fw_cfg_ctl_mem_write(void *opaque, hwaddr addr,
                                  uint64_t value, unsigned size)
 {
@@ -468,6 +473,7 @@ static bool fw_cfg_comb_valid(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps fw_cfg_ctl_mem_ops = {
+    .read = fw_cfg_ctl_mem_read,
     .write = fw_cfg_ctl_mem_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid.accepts = fw_cfg_ctl_mem_valid,
-- 
2.17.1
