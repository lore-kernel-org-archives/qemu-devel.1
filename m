Received: from eggs.gnu.org ([209.51.188.92]:42873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNV2-0000YB-EA
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUx-0005vu-Di
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNUt-0005pb-9H
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:39 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:37 +0100
Message-Id: <20190214201939.494-8-philmd@redhat.com>
In-Reply-To: <20190214201939.494-1-philmd@redhat.com>
References: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 7/9] ccid-card-passthru: Use
 QERR_MISSING_PARAMETER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 6cb8b2d26b..d63aa28584 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -16,6 +16,7 @@
 #include "qemu/sockets.h"
 #include "ccid.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
=20
 #define DPRINTF(card, lvl, fmt, ...)                    \
 do {                                                    \
@@ -339,7 +340,7 @@ static void passthru_realize(CCIDCardState *base, Err=
or **errp)
     PassthruState *card =3D PASSTHRU_CCID_CARD(base);
=20
     if (!qemu_chr_fe_backend_connected(&card->cs)) {
-        error_setg(errp, "missing chardev");
+        error_setg(errp, QERR_MISSING_PARAMETER, "chardev");
         return;
     }
     card->vscard_in_pos =3D 0;
--=20
2.20.1
