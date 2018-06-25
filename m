Received: from eggs.gnu.org ([2001:4830:134:3::10]:55365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQs4-000303-6B
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQrx-0008SK-Pt
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:45:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:37 -0300
Message-Id: <20180625124238.25339-46-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 45/46] linux-user: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 84e9ec9335..52b5a618fe 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
@@ -274,9 +275,9 @@ static void handle_arg_stack_size(const char *arg)
     }
 
     if (*p == 'M') {
-        guest_stack_size *= 1024 * 1024;
+        guest_stack_size *= MiB;
     } else if (*p == 'k' || *p == 'K') {
-        guest_stack_size *= 1024;
+        guest_stack_size *= KiB;
     }
 }
 
-- 
2.18.0
