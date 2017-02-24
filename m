Received: from eggs.gnu.org ([2001:4830:134:3::10]:35081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmN-0003rz-6K
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmM-0004qo-5N
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmL-0004Og-Um
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:38 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:28 +0000
Message-Id: <1487957728-8354-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 9/9] Tidy up #include lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>

Tidy up unnecessary #includes that risu.h provides.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 risu.h         | 1 +
 risu_aarch64.c | 5 -----
 risu_m68k.c    | 5 -----
 risu_ppc64le.c | 5 -----
 4 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/risu.h b/risu.h
index 90e4f23..883bcf7 100644
--- a/risu.h
+++ b/risu.h
@@ -15,6 +15,7 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <ucontext.h>
+#include <stdio.h>
 
 /* GCC computed include to pull in the correct risu_reginfo_*.h for
  * the architecture.
diff --git a/risu_aarch64.c b/risu_aarch64.c
index cdd23d8..9c6809d 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -10,12 +10,7 @@
  *     based on Peter Maydell's risu_arm.c
  *****************************************************************************/
 
-#include <stdio.h>
-#include <ucontext.h>
-#include <string.h>
-
 #include "risu.h"
-#include "risu_reginfo_aarch64.h"
 
 void advance_pc(void *vuc)
 {
diff --git a/risu_m68k.c b/risu_m68k.c
index 851487b..f84ac7a 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -6,12 +6,7 @@
  * http://www.eclipse.org/legal/epl-v10.html
  ******************************************************************************/
 
-#include <stdio.h>
-#include <ucontext.h>
-#include <string.h>
-
 #include "risu.h"
-#include "risu_reginfo_m68k.h"
 
 void advance_pc(void *vuc)
 {
diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index c15d78e..b575078 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -11,12 +11,7 @@
  *     based on Peter Maydell's risu_arm.c
  *****************************************************************************/
 
-#include <stdio.h>
-#include <ucontext.h>
-#include <string.h>
-
 #include "risu.h"
-#include "risu_reginfo_ppc64le.h"
 
 void advance_pc(void *vuc)
 {
-- 
2.7.4
