Received: from eggs.gnu.org ([2001:4830:134:3::10]:49596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlB-0003bg-U2
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlB-0004oC-6R
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:37 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  2 Aug 2017 17:43:52 +0100
Message-Id: <1501692241-23310-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/15] target/arm: Remove incorrect comment
 about MPU_CTRL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Remove the comment that claims that some MPU_CTRL bits are stored
in sctlr_el[1]. This has never been true since MPU_CTRL was added
in commit 29c483a50607 -- the comment is a leftover from
Michael Davidsaver's original implementation, which I modified
not to use sctlr_el[1]; I forgot to delete the comment then.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b39d64a..b64474c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -416,7 +416,7 @@ typedef struct CPUARMState {
         uint32_t dfsr; /* Debug Fault Status Register */
         uint32_t mmfar; /* MemManage Fault Address */
         uint32_t bfar; /* BusFault Address */
-        unsigned mpu_ctrl; /* MPU_CTRL (some bits kept in sctlr_el[1]) */
+        unsigned mpu_ctrl; /* MPU_CTRL */
         int exception;
     } v7m;
 
-- 
2.7.4
