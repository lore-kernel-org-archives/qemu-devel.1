Received: from eggs.gnu.org ([2001:4830:134:3::10]:36383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSP5-000524-Eo
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSP4-0008SP-OF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:55 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSP4-000747-FB
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:54 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOB-0007L6-Ar
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:59 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:33 +0000
Message-Id: <20181213145445.17935-26-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/37] hw/arm: versal: Reduce number of
 virtio-mmio instances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Reduce number of virtio-mmio instances. This is in preparation
for correcting the interrupt setup for Versal.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181129163655.20370-3-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 41b8d801c89..2ed6ee9934d 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -342,7 +342,7 @@ static void *versal_virt_get_dtb(const struct arm_boot_info *binfo,
     return board->fdt;
 }
 
-#define NUM_VIRTIO_TRANSPORT 32
+#define NUM_VIRTIO_TRANSPORT 8
 static void create_virtio_regions(VersalVirt *s)
 {
     int virtio_mmio_size = 0x200;
-- 
2.19.2
