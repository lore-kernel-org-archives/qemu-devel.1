Received: from eggs.gnu.org ([2001:4830:134:3::10]:38210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96V-0004bc-LF
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96U-000327-P7
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:27 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:55238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96U-000301-He
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:26 -0400
Received: by mail-wm0-x235.google.com with SMTP id i139-v6so4086173wmf.4
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:35 +0200
Message-Id: <20180630061040.6018-43-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/47] monitor: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-43-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 0988eb4..61b727a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <dirent.h>
 #include "cpu.h"
 #include "hw/hw.h"
@@ -3288,7 +3289,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                         monitor_printf(mon, "enter a positive value\n");
                         goto fail;
                     }
-                    val <<= 20;
+                    val *= MiB;
                 }
                 qdict_put_int(qdict, key, val);
             }
-- 
1.8.3.1
