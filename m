Received: from eggs.gnu.org ([2001:4830:134:3::10]:37783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95y-00041h-GK
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95x-0001nd-Il
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:54 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95x-0001mD-BR
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:53 -0400
Received: by mail-wm0-x243.google.com with SMTP id 69-v6so3925485wmf.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:02 +0200
Message-Id: <20180630061040.6018-10-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/47] hw/ivshmem: Use the IEC binary prefix
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

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180625124238.25339-8-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index ee01c5e..6febbab 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -17,6 +17,7 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "hw/hw.h"
@@ -1301,7 +1302,7 @@ static void ivshmem_realize(PCIDevice *dev, Error **errp)
     }
 
     if (s->sizearg == NULL) {
-        s->legacy_size = 4 << 20; /* 4 MB default */
+        s->legacy_size = 4 * MiB; /* 4 MB default */
     } else {
         int ret;
         uint64_t size;
-- 
1.8.3.1
