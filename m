Received: from eggs.gnu.org ([2001:4830:134:3::10]:39471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVI85-0008NY-4X
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVI81-0000qa-59
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:56:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 12 Jul 2017 16:38:00 +0300
Message-Id: <8f7b1bd6ceec07bf64a70d1a46c45cb45658af2d.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/13] hw/misc: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

inlined create_unimplemented_device() calls sysbus_mmio_map_overlap().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
=20
+#include "hw/sysbus.h"
+
 #define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
=20
 /**
--=20
2.11.0
