Received: from eggs.gnu.org ([2001:4830:134:3::10]:33999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d71ZN-0007JQ-V2
	for qemu-devel@nongnu.org; Sat, 06 May 2017 11:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d71ZN-0002te-5W
	for qemu-devel@nongnu.org; Sat, 06 May 2017 11:24:29 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat,  6 May 2017 17:24:13 +0200
Message-Id: <20170506152414.8704-3-krzk@kernel.org>
In-Reply-To: <20170506152414.8704-1-krzk@kernel.org>
References: <20170506152414.8704-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 2/3] hw/arm/exynos: Declare local variables in
 some order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Bring some more readability by declaring local function variables, first
initialized ones and then the rest (with reversed-christmas-tree order).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/arm/exynos4210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 0da877f8db0a..27a7bf28a5a9 100644
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
2.9.3
