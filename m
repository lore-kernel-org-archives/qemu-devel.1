Received: from eggs.gnu.org ([2001:4830:134:3::10]:55572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORBK-0003KN-Q2
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dORBI-0002ay-0K
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:11:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 23 Jun 2017 13:11:20 -0300
Message-Id: <20170623161121.8047-2-f4bug@amsat.org>
In-Reply-To: <20170623161121.8047-1-f4bug@amsat.org>
References: <20170623161121.8047-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/2] hw/unimp: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

inlined create_unimplemented_device() calls sysbus_mmio_map_overlap().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/hw/misc/unimp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 3462d85836..52e068ec3e 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -8,6 +8,8 @@
 #ifndef HW_MISC_UNIMP_H
 #define HW_MISC_UNIMP_H
 
+#include "hw/sysbus.h"
+
 #define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
 
 /**
-- 
2.13.1
