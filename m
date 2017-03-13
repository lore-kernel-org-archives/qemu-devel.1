Received: from eggs.gnu.org ([2001:4830:134:3::10]:51612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnUpj-0005mn-4N
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnUpi-0000ix-Dk
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:36:39 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 13 Mar 2017 20:35:57 +0200
Message-Id: <20170313183557.23195-4-krzk@kernel.org>
In-Reply-To: <20170313183557.23195-1-krzk@kernel.org>
References: <20170313183557.23195-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v2 3/3] hw/misc/exynos4210_pmu: Reorder local
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
Cc: eblake@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Krzysztof Kozlowski <krzk@kernel.org>

Short declaration of 'i' was in the middle of declarations with
assignments.  Make it a little bit more readable.  Additionally switch
from "unsigned" to "unsigned int" as this pattern is more widely used.
No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/misc/exynos4210_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index e30dbc7d3d83..63a8ccd35559 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -401,8 +401,8 @@ static uint64_t exynos4210_pmu_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
     Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
-    unsigned i;
     const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
+    unsigned int i;
 
     for (i = 0; i < PMU_NUM_OF_REGISTERS; i++) {
         if (reg_p->offset == offset) {
@@ -420,8 +420,8 @@ static void exynos4210_pmu_write(void *opaque, hwaddr offset,
                                  uint64_t val, unsigned size)
 {
     Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
-    unsigned i;
     const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
+    unsigned int i;
 
     for (i = 0; i < PMU_NUM_OF_REGISTERS; i++) {
         if (reg_p->offset == offset) {
-- 
2.9.3
