Received: from eggs.gnu.org ([2001:4830:134:3::10]:56601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFo-0002UF-Hw
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFn-0002Ro-F2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFn-0002RP-AE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:59 -0400
Date: Thu, 3 May 2018 22:50:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-20-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 19/67] xtensa: relative include for parent
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Max Filippov <jcmvbkbc@gmail.com>

When pulling in headers that are in the parent directory of the C file
(as opposed to one in include/), we should use its relative path, with
".." as a directory. Path without a directory works more or less by
accident.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/xtensa/core-dc232b/xtensa-modules.inc.c            | 4 ++--
 target/xtensa/core-dc233c/xtensa-modules.inc.c            | 4 ++--
 target/xtensa/core-de212/xtensa-modules.inc.c             | 4 ++--
 target/xtensa/core-fsf/xtensa-modules.inc.c               | 4 ++--
 target/xtensa/core-sample_controller/xtensa-modules.inc.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/xtensa/core-dc232b/xtensa-modules.inc.c b/target/xtensa/core-dc232b/xtensa-modules.inc.c
index d322c3f..ab46f70 100644
--- a/target/xtensa/core-dc232b/xtensa-modules.inc.c
+++ b/target/xtensa/core-dc232b/xtensa-modules.inc.c
@@ -19,8 +19,8 @@
    02110-1301, USA.  */
 
 #include "qemu/osdep.h"
-#include "xtensa-isa.h"
-#include "xtensa-isa-internal.h"
+#include "../xtensa-isa.h"
+#include "../xtensa-isa-internal.h"
 
 

 /* Sysregs.  */
diff --git a/target/xtensa/core-dc233c/xtensa-modules.inc.c b/target/xtensa/core-dc233c/xtensa-modules.inc.c
index 7c20f82..a7ea8cf 100644
--- a/target/xtensa/core-dc233c/xtensa-modules.inc.c
+++ b/target/xtensa/core-dc233c/xtensa-modules.inc.c
@@ -22,8 +22,8 @@
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
 #include "qemu/osdep.h"
-#include "xtensa-isa.h"
-#include "xtensa-isa-internal.h"
+#include "../xtensa-isa.h"
+#include "../xtensa-isa-internal.h"
 
 

 /* Sysregs.  */
diff --git a/target/xtensa/core-de212/xtensa-modules.inc.c b/target/xtensa/core-de212/xtensa-modules.inc.c
index ef7674d..ef34b85 100644
--- a/target/xtensa/core-de212/xtensa-modules.inc.c
+++ b/target/xtensa/core-de212/xtensa-modules.inc.c
@@ -22,8 +22,8 @@
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
 #include "qemu/osdep.h"
-#include "xtensa-isa.h"
-#include "xtensa-isa-internal.h"
+#include "../xtensa-isa.h"
+#include "../xtensa-isa-internal.h"
 
 

 /* Sysregs.  */
diff --git a/target/xtensa/core-fsf/xtensa-modules.inc.c b/target/xtensa/core-fsf/xtensa-modules.inc.c
index f7de2de..13a36a5 100644
--- a/target/xtensa/core-fsf/xtensa-modules.inc.c
+++ b/target/xtensa/core-fsf/xtensa-modules.inc.c
@@ -19,8 +19,8 @@
    02110-1301, USA.  */
 
 #include "qemu/osdep.h"
-#include "xtensa-isa.h"
-#include "xtensa-isa-internal.h"
+#include "../xtensa-isa.h"
+#include "../xtensa-isa-internal.h"
 
 

 /* Sysregs.  */
diff --git a/target/xtensa/core-sample_controller/xtensa-modules.inc.c b/target/xtensa/core-sample_controller/xtensa-modules.inc.c
index fba41b9..51285b4 100644
--- a/target/xtensa/core-sample_controller/xtensa-modules.inc.c
+++ b/target/xtensa/core-sample_controller/xtensa-modules.inc.c
@@ -22,8 +22,8 @@
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
 #include "qemu/osdep.h"
-#include "xtensa-isa.h"
-#include "xtensa-isa-internal.h"
+#include "../xtensa-isa.h"
+#include "../xtensa-isa-internal.h"
 
 

 /* Sysregs.  */
-- 
MST
