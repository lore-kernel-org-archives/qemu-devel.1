Received: from eggs.gnu.org ([2001:4830:134:3::10]:35948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eHA9J-0007aN-7z
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eHA9E-0003tq-OG
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:07:45 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 15:07:31 +0000
Message-Id: <1511276851-17680-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] accel/tcg/cpu-exec-common.c: Remove
 unnecessary include of memory-internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

The cpu-exec-common.c file includes memory-internal.h, but it doesn't
actually use anything from that header. Remove the unnecessary include.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/cpu-exec-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 5b4ae54..dac5aac 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "sysemu/cpus.h"
 #include "exec/exec-all.h"
-#include "exec/memory-internal.h"
 
 bool tcg_allowed;
 
-- 
2.7.4
