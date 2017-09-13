Received: from eggs.gnu.org ([2001:4830:134:3::10]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ds4GJ-0008W3-8h
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ds4GI-0006aE-EX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:47:15 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 13 Sep 2017 11:46:43 +0200
Message-Id: <1505296004-6798-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1505296004-6798-1-git-send-email-eric.auger@redhat.com>
References: <1505296004-6798-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/3] hw/arm/virt: Set INTx/gsi mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: christoffer.dall@linaro.org, agraf@suse.de, pranavkumar@linaro.org, drjones@redhat.com, wei@redhat.com

From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

Let's provide the GPEX host bridge with the INTx/gsi mapping. This is
needed for INTx/gsi routing.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Feng Kan <fkan@apm.com>

---

v3 -> v4:
- don't use GPEXHost *s anymore
- added Drew's R-b
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
2.5.5
