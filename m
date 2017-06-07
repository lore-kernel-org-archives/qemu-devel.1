Received: from eggs.gnu.org ([2001:4830:134:3::10]:40913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIg1f-0000NV-SM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIg1c-00040D-0z
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIg1b-0003zv-R6
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:49:47 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 22:49:19 +0400
Message-Id: <20170607184921.28407-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170607184921.28407-1-marcandre.lureau@redhat.com>
References: <20170607184921.28407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] char: fix alias devices regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Fix regression from commit 4d43a603c71, where the serial and parallel
headers got removed from char.c, which broke the alias table.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 7aa0210765..f38fac5c6b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -34,6 +34,8 @@
 #include "qemu/help_option.h"
=20
 #include "chardev/char-mux.h"
+#include "chardev/char-parallel.h" /* for HAVE_CHARDEV_PARPORT */
+#include "chardev/char-serial.h" /* for HAVE_CHARDEV_SERIAL */
=20
 /***********************************************************/
 /* character device */
--=20
2.13.0.91.g00982b8dd
