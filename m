Received: from eggs.gnu.org ([2001:4830:134:3::10]:43836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F95-0008SK-5f
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F93-0008Ai-Hd
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F93-00085i-5d
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8r-0006to-TJ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:51 +0100
Message-Id: <1492706470-10921-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/24] target/arm: Add missing entries to
 excnames[] for log strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Recent changes have added new EXCP_ values to ARM but forgot
to update the excnames[] array which is used to provide
human-readable strings when printing information about the
exception for debug logging. Add the missing entries, and
add a comment to the list of #defines to help avoid the mistake
being repeated in future.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 1491486340-25988-1-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 1 +
 target/arm/internals.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8aabce..e6f05e2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -58,6 +58,7 @@
 #define EXCP_SEMIHOST       16   /* semihosting call */
 #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
 #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
+/* NB: new EXCP_ defines should be added to the excnames[] array too */
 
 #define ARMV7M_EXCP_RESET   1
 #define ARMV7M_EXCP_NMI     2
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f742a41..97ca034 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -70,6 +70,8 @@ static const char * const excnames[] = {
     [EXCP_VIRQ] = "Virtual IRQ",
     [EXCP_VFIQ] = "Virtual FIQ",
     [EXCP_SEMIHOST] = "Semihosting call",
+    [EXCP_NOCP] = "v7M NOCP UsageFault",
+    [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
 };
 
 /* Scale factor for generic timers, ie number of ns per tick.
-- 
2.7.4
