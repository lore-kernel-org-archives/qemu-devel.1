Received: from eggs.gnu.org ([2001:4830:134:3::10]:38267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96a-0004h6-Mu
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96Y-0003Ai-Hz
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:32 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:42117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96Y-00039L-B2
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:30 -0400
Received: by mail-wr0-x230.google.com with SMTP id p1-v6so10654366wrs.9
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:39 +0200
Message-Id: <20180630061040.6018-47-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 46/47] bsd-user: Use the IEC binary prefix
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
Message-Id: <20180625124238.25339-47-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index da3b833..0d31569 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-version.h"
 #include <machine/trap.h>
 
@@ -795,9 +796,9 @@ int main(int argc, char **argv)
             if (x86_stack_size <= 0)
                 usage();
             if (*r == 'M')
-                x86_stack_size *= 1024 * 1024;
+                x86_stack_size *= MiB;
             else if (*r == 'k' || *r == 'K')
-                x86_stack_size *= 1024;
+                x86_stack_size *= KiB;
         } else if (!strcmp(r, "L")) {
             interp_prefix = argv[optind++];
         } else if (!strcmp(r, "p")) {
-- 
1.8.3.1
