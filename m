Received: from eggs.gnu.org ([2001:4830:134:3::10]:58423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8K-0003Sg-Q4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8J-0008Oj-V1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8J-0008ON-Qk
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:03 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:09 +0200
Message-Id: <20180531171253.21012-10-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/53] target/hppa: Include "qemu/log.h" to use
 qemu_log()
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

Since his inception in 61766fe9e2d, this file uses the qemu_log()
API from "qemu/log.h".  Include it to allow further includes
cleanup.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-9-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/hppa/int_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 787f3d6357..561bf6eb60 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
--=20
2.17.0
