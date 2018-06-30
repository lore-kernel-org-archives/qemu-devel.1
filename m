Received: from eggs.gnu.org ([2001:4830:134:3::10]:37720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95u-0003yM-2X
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95s-0001fm-N1
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:49 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95s-0001eo-Ef
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:48 -0400
Received: by mail-wr0-x241.google.com with SMTP id b8-v6so10640013wro.6
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:09:58 +0200
Message-Id: <20180630061040.6018-6-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/47] x86/cpu: Use definitions from
 "qemu/units.h"
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180625124238.25339-4-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d57f310..bdbd446 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qemu/bitops.h"
 
@@ -65,9 +66,6 @@ struct CPUID2CacheDescriptorInfo {
     int associativity;
 };
 
-#define KiB 1024
-#define MiB (1024 * 1024)
-
 /*
  * Known CPUID 2 cache descriptors.
  * From Intel SDM Volume 2A, CPUID instruction
-- 
1.8.3.1
