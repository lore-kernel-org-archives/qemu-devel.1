Received: from eggs.gnu.org ([2001:4830:134:3::10]:58530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8T-0003ZO-9E
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8S-00006i-8P
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8S-00006R-3Z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:12 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:18 +0200
Message-Id: <20180531171253.21012-19-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/53] hw/misc/mips_itu: Cleanup includes
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-17-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/mips_itu.c         | 5 +----
 include/hw/misc/mips_itu.h | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index c84a48bbb7..ccc4c7d98a 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -18,13 +18,10 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu/log.h"
 #include "exec/exec-all.h"
-#include "hw/hw.h"
-#include "hw/sysbus.h"
-#include "sysemu/sysemu.h"
 #include "hw/misc/mips_itu.h"
=20
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index b3a4532036..030eb4ac62 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -20,6 +20,8 @@
 #ifndef MIPS_ITU_H
 #define MIPS_ITU_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_MIPS_ITU "mips-itu"
 #define MIPS_ITU(obj) OBJECT_CHECK(MIPSITUState, (obj), TYPE_MIPS_ITU)
=20
--=20
2.17.0
