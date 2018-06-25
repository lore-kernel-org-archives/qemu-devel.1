Received: from eggs.gnu.org ([2001:4830:134:3::10]:55176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQrp-0002lC-S8
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQrp-0008Na-2s
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:45:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:34 -0300
Message-Id: <20180625124238.25339-43-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 42/46] monitor: Use the IEC binary prefix
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 0730a27172..ace14195d6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <dirent.h>
 #include "cpu.h"
 #include "hw/hw.h"
@@ -3286,7 +3287,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                         monitor_printf(mon, "enter a positive value\n");
                         goto fail;
                     }
-                    val <<= 20;
+                    val *= MiB;
                 }
                 qdict_put_int(qdict, key, val);
             }
-- 
2.18.0
