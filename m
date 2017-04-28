Received: from eggs.gnu.org ([2001:4830:134:3::10]:53163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N9-00029V-HI
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N6-0006xt-FX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:51 -0400
Received: from greensocs.com ([193.104.36.180]:60054)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d47N6-0006xk-7l
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:48 -0400
From: fred.konrad@greensocs.com
Date: Fri, 28 Apr 2017 16:59:33 +0200
Message-Id: <1493391576-29401-5-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
References: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH V3 4/7] qdev: add MemoryRegion property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, pbonzini@redhat.com, rth@twiddle.net, peter.maydell@linaro.org, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

We need to pass a pointer to a MemoryRegion for mmio_interface.
So this just adds that.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 include/hw/qdev-properties.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 1d69fa7..57d5331 100644
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
