Received: from eggs.gnu.org ([2001:4830:134:3::10]:33185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTd-0005JF-GM
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTc-0006ie-J5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTc-0006fN-CB
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTQ-00012s-5B
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:06:55 +0100
Message-Id: <1497362826-21125-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/17] hw/arm/exynos: Declare local variables in
 some order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Bring some more readability by declaring local function variables: first
initialized ones and then the rest (with reversed-christmas-tree order).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 0da877f..27a7bf2 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -162,12 +162,12 @@ static uint64_t exynos4210_calc_affinity(int cpu)
 
 Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
 {
-    int i, n;
     Exynos4210State *s = g_new(Exynos4210State, 1);
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
-    DeviceState *dev;
     SysBusDevice *busdev;
     ObjectClass *cpu_oc;
+    DeviceState *dev;
+    int i, n;
 
     cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, "cortex-a9");
     assert(cpu_oc);
-- 
2.7.4
