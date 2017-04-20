Received: from eggs.gnu.org ([2001:4830:134:3::10]:43851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F95-0008SV-9t
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F93-0008Ae-Gf
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F93-00084S-6R
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8r-0006tQ-EM
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:50 +0100
Message-Id: <1492706470-10921-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/24] hw/misc/exynos4210_pmu: Reorder local
 variables for readability
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

Short declaration of 'i' was in the middle of declarations with
assignments.  Make it a little bit more readable.  Additionally switch
from "unsigned" to "unsigned int" as this pattern is more widely used.
No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20170313184750.429-4-krzk@kernel.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/exynos4210_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index e30dbc7..63a8ccd 100644
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
2.7.4
