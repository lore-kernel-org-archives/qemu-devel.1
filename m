Received: from eggs.gnu.org ([2001:4830:134:3::10]:54555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMl-0005kI-S9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMk-00013v-Gy
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:03 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dLCMk-00013i-9c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:02 -0400
Received: by mail-lf0-x243.google.com with SMTP id x81so956324lfb.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:46:02 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 14 Jun 2017 19:45:50 +0200
Message-Id: <1497462353-3432-5-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 4/7] qdev: add MemoryRegion property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: fred.konrad@greensocs.com, pbonzini@redhat.com, rth@twiddle.net, edgar.iglesias@xilinx.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

We need to pass a pointer to a MemoryRegion for mmio_interface.
So this just adds that.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
---
 include/hw/qdev-properties.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index d206fc9..0e9b492 100644
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
2.7.4
