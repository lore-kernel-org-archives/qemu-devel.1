Received: from eggs.gnu.org ([2001:4830:134:3::10]:38270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96a-0004hE-OU
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96V-00034T-Pp
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:32 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96V-00032e-JO
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:27 -0400
Received: by mail-wm0-x22c.google.com with SMTP id z137-v6so3958931wmc.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:36 +0200
Message-Id: <20180630061040.6018-44-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 43/47] vl: Use the IEC binary prefix definitions
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
Message-Id: <20180625124238.25339-44-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index ef6cfce..93795c1 100644
--- a/vl.c
+++ b/vl.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
@@ -2808,8 +2809,8 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
         if (g_ascii_isdigit(mem_str[strlen(mem_str) - 1])) {
             uint64_t overflow_check = sz;
 
-            sz <<= 20;
-            if ((sz >> 20) != overflow_check) {
+            sz *= MiB;
+            if (sz / MiB != overflow_check) {
                 error_report("too large 'size' option value");
                 exit(EXIT_FAILURE);
             }
-- 
1.8.3.1
