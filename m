Received: from eggs.gnu.org ([2001:4830:134:3::10]:36383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMcAl-0007X5-V4
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMbwZ-0003uE-QZ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:53:41 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 13 Nov 2018 17:52:36 +0100
Message-Id: <20181113165247.4806-3-sameo@linux.intel.com>
In-Reply-To: <20181113165247.4806-1-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/13] target: arm: Remove unused headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
---
 target/arm/helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3d4e9c5c8a..27d9285e1e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12,13 +12,10 @@
 #include "internals.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
-#include "qemu/host-utils.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
-#include "qemu/bitops.h"
 #include "qemu/crc32c.h"
 #include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
 #include "arm_ldst.h"
 #include <zlib.h> /* For crc32 */
 #include "exec/semihost.h"
-- 
2.19.1
