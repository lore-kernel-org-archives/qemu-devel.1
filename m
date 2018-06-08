Received: from eggs.gnu.org ([2001:4830:134:3::10]:50616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGls-00039E-IT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlr-0004LH-RJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlr-0004Hv-KS
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlq-0003kT-I8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:08 +0100
Message-Id: <20180608124517.29475-23-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/31] target/arm: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180606152128.449-9-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f75aa6e9ca1..1248d84e6fa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4570,7 +4570,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n)
     case 4: /* unlinked address mismatch (reserved if AArch64) */
     case 5: /* linked address mismatch (reserved if AArch64) */
         qemu_log_mask(LOG_UNIMP,
-                      "arm: address mismatch breakpoint types not implemented");
+                      "arm: address mismatch breakpoint types not implemented\n");
         return;
     case 0: /* unlinked address match */
     case 1: /* linked address match */
@@ -4604,7 +4604,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n)
     case 8: /* unlinked VMID match (reserved if no EL2) */
     case 10: /* unlinked context ID and VMID match (reserved if no EL2) */
         qemu_log_mask(LOG_UNIMP,
-                      "arm: unlinked context breakpoint types not implemented");
+                      "arm: unlinked context breakpoint types not implemented\n");
         return;
     case 9: /* linked VMID match (reserved if no EL2) */
     case 11: /* linked context ID and VMID match (reserved if no EL2) */
-- 
2.17.1
