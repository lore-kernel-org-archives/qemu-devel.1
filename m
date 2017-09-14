Received: from eggs.gnu.org ([2001:4830:134:3::10]:46460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJZ-000854-8p
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJY-0007xy-HX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJY-0007x0-As
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJX-0005th-9k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:51 +0100
Message-Id: <1505411573-27848-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/18] hw/arm/virt: Set INTx/gsi mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

Let's provide the GPEX host bridge with the INTx/gsi mapping. This is
needed for INTx/gsi routing.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Feng Kan <fkan@apm.com>
Message-id: 1505296004-6798-3-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fe96557..cfd834d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1057,6 +1057,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
 
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
 
     pci = PCI_HOST_BRIDGE(dev);
-- 
2.7.4
