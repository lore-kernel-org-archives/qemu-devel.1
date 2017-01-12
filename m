Received: from eggs.gnu.org ([2001:4830:134:3::10]:34059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cRZQz-0001VQ-BC
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cRZQy-00065H-ML
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:04:29 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu, 12 Jan 2017 02:04:18 -0500
Message-Id: <1484204658-28058-5-git-send-email-wei@redhat.com>
In-Reply-To: <1484204658-28058-1-git-send-email-wei@redhat.com>
References: <1484204658-28058-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V1 4/4] target-arm: Hook up TCG vPMU with CPU
 pmu option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Remove the checking of kvm_enabled(). With this, .pmu option can also
control vPMU under TCG mode.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f5cb30a..2f87a4b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -692,7 +692,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->id_aa64pfr0 &= ~0xf000;
     }
 
-    if (!cpu->has_pmu || !kvm_enabled()) {
+    if (!cpu->has_pmu) {
         cpu->has_pmu = false;
         unset_feature(env, ARM_FEATURE_PMU);
     }
-- 
1.8.3.1
