Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8X-0003dE-4O
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8V-0000Ar-Pq
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8V-0000AC-KP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:15 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:22 +0200
Message-Id: <20180531171253.21012-23-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/53] hw/ide: Remove unused include
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

There is no need to include pci.h in this file.
(Continue f23c81073a cleanup).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-21-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 866c659498..cc9ca28c33 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
--=20
2.17.0
