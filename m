Received: from eggs.gnu.org ([209.51.188.92]:47157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1ggZyH-0002xL-Mn
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1ggZyH-0004D8-1M
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:49:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1ggZyG-00045t-SA
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:49:56 -0500
From: Frediano Ziglio <fziglio@redhat.com>
Date: Mon,  7 Jan 2019 18:44:04 +0000
Message-Id: <20190107184404.31993-1-fziglio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spice: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, spice-devel@lists.freedesktop.org, Frediano Ziglio <fziglio@redhat.com>

The definitions in the header are not  used.
Also this fixes porting SPICE to Windows where the header is not
available.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 ui/spice-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 525e0929b9..fb87944a24 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include <spice.h>
=20
-#include <netdb.h>
 #include "sysemu/sysemu.h"
=20
 #include "ui/qemu-spice.h"
--=20
2.20.1
