Received: from eggs.gnu.org ([2001:4830:134:3::10]:45862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzes-0000L7-3I
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzem-0004R7-Vy
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzem-0004Qg-Ky
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:20 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:09:43 -0200
Message-Id: <20180118021000.27203-3-ehabkost@redhat.com>
In-Reply-To: <20180118021000.27203-1-ehabkost@redhat.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/19] memfd: remove needless include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20171023141815.17709-3-marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 util/memfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/util/memfd.c b/util/memfd.c
index 3a82505f8d..dce61f9d21 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -27,8 +27,6 @@
=20
 #include "qemu/osdep.h"
=20
-#include <glib/gprintf.h>
-
 #include "qemu/memfd.h"
=20
 #if defined CONFIG_LINUX && !defined CONFIG_MEMFD
--=20
2.14.3
