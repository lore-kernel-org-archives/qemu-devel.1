Received: from eggs.gnu.org ([2001:4830:134:3::10]:33918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgiL-00022U-Uq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgiK-0004B3-Rf
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:29:44 -0300
Message-Id: <20171215033015.738-13-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 12/43] misc: remove headers implicitly
 included
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Ben Warren <ben@skyportsystems.com>

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/audio/fmopl.h             | 1 -
 bsd-user/main.c              | 1 -
 chardev/wctablet.c           | 4 ----
 hw/scsi/vhost-user-scsi.c    | 1 -
 linux-user/main.c            | 1 -
 net/colo-compare.c           | 1 -
 tests/test-aio-multithread.c | 1 -
 tests/test-clone-visitor.c   | 1 -
 tests/vmgenid-test.c         | 3 ---
 9 files changed, 14 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index f4065f425c..e7e578a48e 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -1,7 +1,6 @@
 #ifndef FMOPL_H
 #define FMOPL_H
 
-#include <stdint.h>
 
 typedef void (*OPL_TIMERHANDLER)(void *param, int channel, double interval_Sec);
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index f1b244b59b..efef5ff8c5 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -32,7 +32,6 @@
 #include "qemu/envlist.h"
 #include "exec/log.h"
 #include "trace/control.h"
-#include "glib-compat.h"
 
 int singlestep;
 unsigned long mmap_min_addr;
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 6c13c2c58a..969d014574 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -25,10 +25,6 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
-#include <stdlib.h>
-#include <string.h>
-#include <sys/time.h>
-#include <time.h>
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index f7561e23fa..9389ed48e0 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qemu/typedefs.h"
 #include "qom/object.h"
 #include "hw/fw-path-provider.h"
 #include "hw/qdev-core.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index 6286661bd3..2fd2a143ed 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -35,7 +35,6 @@
 #include "elf.h"
 #include "exec/log.h"
 #include "trace/control.h"
-#include "glib-compat.h"
 
 char *exec_path;
 
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 1ce195f877..0ebdec936c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -23,7 +23,6 @@
 #include "qom/object_interfaces.h"
 #include "qemu/iov.h"
 #include "qom/object.h"
-#include "qemu/typedefs.h"
 #include "net/queue.h"
 #include "chardev/char-fe.h"
 #include "qemu/sockets.h"
diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index d396185972..c8bec81520 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include <glib.h>
 #include "block/aio.h"
 #include "qapi/error.h"
 #include "qemu/coroutine.h"
diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
index 96982163e4..ac6afc562e 100644
--- a/tests/test-clone-visitor.c
+++ b/tests/test-clone-visitor.c
@@ -8,7 +8,6 @@
  */
 
 #include "qemu/osdep.h"
-#include <glib.h>
 
 #include "qemu-common.h"
 #include "qapi/clone-visitor.h"
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 5a86b40775..68ff954578 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -8,9 +8,6 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include <glib.h>
-#include <string.h>
-#include <unistd.h>
 #include "qemu/osdep.h"
 #include "qemu/bitmap.h"
 #include "qemu/uuid.h"
-- 
2.15.1
