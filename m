Received: from eggs.gnu.org ([2001:4830:134:3::10]:49457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceoyC-0000qs-Ir
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceoyA-0001na-Cc
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:17:32 -0500
Received: from greensocs.com ([193.104.36.180]:53807)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1ceoyA-0001n9-54
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:17:30 -0500
From: fred.konrad@greensocs.com
Date: Fri, 17 Feb 2017 21:17:11 +0100
Message-Id: <1487362633-25018-6-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1487362633-25018-1-git-send-email-fred.konrad@greensocs.com>
References: <1487362633-25018-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V2 5/7] qdev: add MemoryRegion property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

We need to pass a pointer to a MemoryRegion for mmio_interface.
So this just adds that.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 include/hw/qdev-properties.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7ac3153..babb258 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -171,6 +171,8 @@ extern PropertyInfo qdev_prop_arraylen;
     DEFINE_PROP_DEFAULT(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
+#define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
 
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
-- 
1.8.3.1
