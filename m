Received: from eggs.gnu.org ([2001:4830:134:3::10]:38272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96a-0004hG-PD
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96X-00039B-LC
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:32 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:32909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96X-00037D-Df
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:29 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k7-v6so7156195wrq.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:38 +0200
Message-Id: <20180630061040.6018-46-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 45/47] linux-user: Use the IEC binary prefix
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
Message-Id: <20180625124238.25339-46-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 84e9ec9..52b5a61 100644
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
1.8.3.1
