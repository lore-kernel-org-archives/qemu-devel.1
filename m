Received: from eggs.gnu.org ([2001:4830:134:3::10]:38045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96H-0004MK-Im
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96G-0002Li-J6
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:13 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96G-0002Jk-C9
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:12 -0400
Received: by mail-wm0-x22b.google.com with SMTP id n17-v6so3954756wmh.2
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:21 +0200
Message-Id: <20180630061040.6018-29-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/47] hw/cris: Use the IEC binary prefix
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
Message-Id: <20180625124238.25339-27-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/cris/axis_dev88.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 56ee398..191292e 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -242,7 +243,7 @@ static const MemoryRegionOps gpio_ops = {
     },
 };
 
-#define INTMEM_SIZE (128 * 1024)
+#define INTMEM_SIZE (128 * KiB)
 
 static struct cris_load_info li;
 
-- 
1.8.3.1
