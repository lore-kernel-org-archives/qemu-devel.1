Received: from eggs.gnu.org ([2001:4830:134:3::10]:58398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8J-0003Qi-1k
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8I-0008N9-7q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8I-0008MV-2w
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:02 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:07 +0200
Message-Id: <20180531171253.21012-8-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/53] target/xtensa: Include "qemu/timer.h" to
 use NANOSECONDS_PER_SECOND
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

Since d0ce7e9cfc the dc232b structure uses the NANOSECONDS_PER_SECOND
definition from "qemu/timer.h".  Include it to allow further includes
cleanup.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-7-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/xtensa/core-dc232b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index 7331eeea2f..70f33622ec 100644
--- a/target/xtensa/core-dc232b.c
+++ b/target/xtensa/core-dc232b.c
@@ -30,6 +30,7 @@
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu/host-utils.h"
+#include "qemu/timer.h"
=20
 #include "core-dc232b/core-isa.h"
 #include "overlay_tool.h"
--=20
2.17.0
