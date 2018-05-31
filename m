Received: from eggs.gnu.org ([2001:4830:134:3::10]:58541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8T-0003a4-W4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8T-00007Q-51
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8T-00006u-0P
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:13 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:19 +0200
Message-Id: <20180531171253.21012-20-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/53] hw/misc/sga: Use the correct ISA include
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

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The SGA BIOS loader is an ISA device, it does not require the PCI header.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-18-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/sga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/sga.c b/hw/misc/sga.c
index 97fd63f176..4a22a52a60 100644
--- a/hw/misc/sga.c
+++ b/hw/misc/sga.c
@@ -25,7 +25,7 @@
  *
  */
 #include "qemu/osdep.h"
-#include "hw/pci/pci.h"
+#include "hw/isa/isa.h"
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
=20
--=20
2.17.0
