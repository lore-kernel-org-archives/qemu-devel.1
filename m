Received: from eggs.gnu.org ([2001:4830:134:3::10]:58331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8F-0003P4-I5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8D-0008Ie-PB
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8D-0008IT-KT
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:12:57 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:02 +0200
Message-Id: <20180531171253.21012-3-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/53] vfio: Include "exec/address-spaces.h"
 directly in the source file
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

No declaration of "hw/vfio/vfio-common.h" directly requires to include
the "exec/address-spaces.h" header.  To simplify dependencies and
ease the upcoming cleanup of "exec/address-spaces.h", directly include
it in the source file where the declaration are used.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-2-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/ccw.c                 | 1 +
 hw/vfio/platform.c            | 1 +
 include/hw/vfio/vfio-common.h | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e67392c5f9..76e4e8c652 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -22,6 +22,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/ccw-device.h"
+#include "exec/address-spaces.h"
 #include "qemu/error-report.h"
=20
 #define TYPE_VFIO_CCW "vfio-ccw"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 5c921c27ba..57c4a0ee2b 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -24,6 +24,7 @@
 #include "qemu/range.h"
 #include "sysemu/sysemu.h"
 #include "exec/memory.h"
+#include "exec/address-spaces.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
 #include "trace.h"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index d9360148e6..8264a65fa5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -22,7 +22,6 @@
 #define HW_VFIO_VFIO_COMMON_H
=20
 #include "qemu-common.h"
-#include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "qemu/queue.h"
 #include "qemu/notify.h"
--=20
2.17.0
