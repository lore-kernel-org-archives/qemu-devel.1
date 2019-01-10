Received: from eggs.gnu.org ([209.51.188.92]:55154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW3E-0008SQ-JL
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW0b-00066B-FF
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghW0Z-000651-OG
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5056C04C278
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:48:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 10 Jan 2019 09:47:52 +0100
Message-Id: <20190110084752.30510-9-kraxel@redhat.com>
In-Reply-To: <20190110084752.30510-1-kraxel@redhat.com>
References: <20190110084752.30510-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/8] spice: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Frediano Ziglio <fziglio@redhat.com>

From: Frediano Ziglio <fziglio@redhat.com>

The definitions in the header are not  used.
Also this fixes porting SPICE to Windows where the header is not
available.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190107184404.31993-1-fziglio@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index fc850b3f50..a40fb2c00d 100644
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
2.9.3
