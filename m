Received: from eggs.gnu.org ([2001:4830:134:3::10]:53024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkgb-0000im-TQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkgb-000897-06
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cnkga-0007v8-Pv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkgR-0002EU-VV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:32:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 11:32:05 +0000
Message-Id: <1489491125-23648-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1489491125-23648-1-git-send-email-peter.maydell@linaro.org>
References: <1489491125-23648-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 2/2] target/arm/arm-powerctl: Fix psci info
 return values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

The power state spec section 5.1.5 AFFINITY_INFO defines the
affinity info return values as

  0 ON
  1 OFF
  2 ON_PENDING

I grepped QEMU for power_state to ensure that no assumptions
of OFF=0 were being made.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20170303123232.4967-1-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 25ceaab..a8aabce 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -536,8 +536,8 @@ typedef void ARMELChangeHook(ARMCPU *cpu, void *opaque);
 /* These values map onto the return values for
  * QEMU_PSCI_0_2_FN_AFFINITY_INFO */
 typedef enum ARMPSCIState {
-    PSCI_OFF = 0,
-    PSCI_ON = 1,
+    PSCI_ON = 0,
+    PSCI_OFF = 1,
     PSCI_ON_PENDING = 2
 } ARMPSCIState;
 
-- 
2.7.4
