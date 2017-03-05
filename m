Received: from eggs.gnu.org ([2001:4830:134:3::10]:51695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cke20-000680-TJ
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cke20-0007TH-5L
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:49:32 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  5 Mar 2017 23:48:57 +0200
Message-Id: <20170305214857.9510-3-krzk@kernel.org>
In-Reply-To: <20170305214857.9510-1-krzk@kernel.org>
References: <20170305214857.9510-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 3/3] hw/misc/exynos4210_pmu: Reorder local
 variables for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Short declaration of 'i' was in the middle of declarations with
assignments.  Make it a little bit more readable.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/misc/exynos4210_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index cbdfa0614600..60d1545c0baa 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -401,8 +401,8 @@ static uint64_t exynos4210_pmu_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
     const Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
-    unsigned i;
     const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
+    unsigned i;
 
     for (i = 0; i < PMU_NUM_OF_REGISTERS; i++) {
         if (reg_p->offset == offset) {
@@ -420,8 +420,8 @@ static void exynos4210_pmu_write(void *opaque, hwaddr offset,
                                  uint64_t val, unsigned size)
 {
     Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
-    unsigned i;
     const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
+    unsigned i;
 
     for (i = 0; i < PMU_NUM_OF_REGISTERS; i++) {
         if (reg_p->offset == offset) {
-- 
2.9.3
