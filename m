Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbDD-00017f-ID
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbD9-0001Dj-Ki
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbD9-0001Da-Ec
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:23:15 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:21:08 +0400
Message-Id: <20170131162122.29408-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/41] char: remove unused READ_RETRIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Curiously unused since its introduction in commit 7b0bfdf52d69.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 chardev/char.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 6d0d5e722b..722c98dc33 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -87,7 +87,6 @@
=20
 #include "char-mux.h"
=20
-#define READ_RETRIES 10
 #define TCP_MAX_FDS 16
=20
 /***********************************************************/
--=20
2.11.0.295.gd7dffce1c.dirty
