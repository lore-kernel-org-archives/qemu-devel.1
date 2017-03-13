Received: from eggs.gnu.org ([2001:4830:134:3::10]:43073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4l-0000pH-2Y
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4j-0002aQ-R1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4j-0002a1-J1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:13 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 873DFC0546E3
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:37 -0500
Message-Id: <20170313195547.21466-21-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/30] trace: Fix parameter types in hw/misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/misc/trace-events | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0cc556c..71c8e3b 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -1,13 +1,13 @@
 # See docs/tracing.txt for syntax documentation.

 # hw/misc/eccmemctl.c
-ecc_mem_writel_mer(uint32_t val) "Write memory enable %08x"
-ecc_mem_writel_mdr(uint32_t val) "Write memory delay %08x"
-ecc_mem_writel_mfsr(uint32_t val) "Write memory fault status %08x"
-ecc_mem_writel_vcr(uint32_t val) "Write slot configuration %08x"
-ecc_mem_writel_dr(uint32_t val) "Write diagnostic %08x"
-ecc_mem_writel_ecr0(uint32_t val) "Write event count 1 %08x"
-ecc_mem_writel_ecr1(uint32_t val) "Write event count 2 %08x"
+ecc_mem_writel_mer(uint64_t val) "Write memory enable %08" PRIx64
+ecc_mem_writel_mdr(uint64_t val) "Write memory delay %08" PRIx64
+ecc_mem_writel_mfsr(uint64_t val) "Write memory fault status %08" PRIx64
+ecc_mem_writel_vcr(uint64_t val) "Write slot configuration %08" PRIx64
+ecc_mem_writel_dr(uint64_t val) "Write diagnostic %08" PRIx64
+ecc_mem_writel_ecr0(uint64_t val) "Write event count 1 %08" PRIx64
+ecc_mem_writel_ecr1(uint64_t val) "Write event count 2 %08" PRIx64
 ecc_mem_readl_mer(uint32_t ret) "Read memory enable %08x"
 ecc_mem_readl_mdr(uint32_t ret) "Read memory delay %08x"
 ecc_mem_readl_mfsr(uint32_t ret) "Read memory fault status %08x"
@@ -17,39 +17,39 @@ ecc_mem_readl_mfar1(uint32_t ret) "Read memory fault address 1 %08x"
 ecc_mem_readl_dr(uint32_t ret) "Read diagnostic %08x"
 ecc_mem_readl_ecr0(uint32_t ret) "Read event count 1 %08x"
 ecc_mem_readl_ecr1(uint32_t ret) "Read event count 2 %08x"
-ecc_diag_mem_writeb(uint64_t addr, uint32_t val) "Write diagnostic %"PRId64" = %02x"
+ecc_diag_mem_writeb(uint64_t addr, uint64_t val) "Write diagnostic %"PRId64" = %02" PRIx64
 ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= %02x"

 # hw/misc/slavio_misc.c
 slavio_misc_update_irq_raise(void) "Raise IRQ"
 slavio_misc_update_irq_lower(void) "Lower IRQ"
 slavio_set_power_fail(int power_failing, uint8_t config) "Power fail: %d, config: %d"
-slavio_cfg_mem_writeb(uint32_t val) "Write config %02x"
+slavio_cfg_mem_writeb(uint64_t val) "Write config %02" PRIx64
 slavio_cfg_mem_readb(uint32_t ret) "Read config %02x"
-slavio_diag_mem_writeb(uint32_t val) "Write diag %02x"
+slavio_diag_mem_writeb(uint64_t val) "Write diag %02" PRIx64
 slavio_diag_mem_readb(uint32_t ret) "Read diag %02x"
-slavio_mdm_mem_writeb(uint32_t val) "Write modem control %02x"
+slavio_mdm_mem_writeb(uint64_t val) "Write modem control %02" PRIx64
 slavio_mdm_mem_readb(uint32_t ret) "Read modem control %02x"
-slavio_aux1_mem_writeb(uint32_t val) "Write aux1 %02x"
+slavio_aux1_mem_writeb(uint64_t val) "Write aux1 %02" PRIx64
 slavio_aux1_mem_readb(uint32_t ret) "Read aux1 %02x"
-slavio_aux2_mem_writeb(uint32_t val) "Write aux2 %02x"
+slavio_aux2_mem_writeb(uint64_t val) "Write aux2 %02" PRIx64
 slavio_aux2_mem_readb(uint32_t ret) "Read aux2 %02x"
-apc_mem_writeb(uint32_t val) "Write power management %02x"
+apc_mem_writeb(uint64_t val) "Write power management %02" PRIx64
 apc_mem_readb(uint32_t ret) "Read power management %02x"
-slavio_sysctrl_mem_writel(uint32_t val) "Write system control %08x"
+slavio_sysctrl_mem_writel(uint64_t val) "Write system control %08" PRIx64
 slavio_sysctrl_mem_readl(uint32_t ret) "Read system control %08x"
-slavio_led_mem_writew(uint32_t val) "Write diagnostic LED %04x"
+slavio_led_mem_writew(uint64_t val) "Write diagnostic LED %04" PRIx64
 slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED %04x"

 # hw/misc/milkymist-hpdmc.c
-milkymist_hpdmc_memory_read(uint32_t addr, uint32_t value) "addr=%08x value=%08x"
-milkymist_hpdmc_memory_write(uint32_t addr, uint32_t value) "addr=%08x value=%08x"
+milkymist_hpdmc_memory_read(hwaddr addr, uint32_t value) "addr=%08" HWADDR_PRIx " value=%08x"
+milkymist_hpdmc_memory_write(hwaddr addr, uint64_t value) "addr=%08" HWADDR_PRIx " value=%08" PRIx64

 # hw/misc/milkymist-pfpu.c
-milkymist_pfpu_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_pfpu_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_pfpu_vectout(uint32_t a, uint32_t b, uint32_t dma_ptr) "a %08x b %08x dma_ptr %08x"
+milkymist_pfpu_memory_read(hwaddr addr, uint32_t value) "addr %08" HWADDR_PRIx " value %08x"
+milkymist_pfpu_memory_write(hwaddr addr, uint64_t value) "addr %08" HWADDR_PRIx " value %08" PRIx64
+milkymist_pfpu_vectout(uint32_t a, uint32_t b, hwaddr dma_ptr) "a %08x b %08x dma_ptr %08" HWADDR_PRIx
 milkymist_pfpu_pulse_irq(void) "Pulse IRQ"

 # hw/misc/aspeed_scu.c
-aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_scu_write(uint64_t offset, unsigned size, uint64_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx64
-- 
2.9.3
