Received: from eggs.gnu.org ([209.51.188.92]:52628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCF-0001Qk-0O
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCC-0007T6-5M
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:53 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCB-0007PM-OD
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:11 +0100
Message-Id: <20190127120526.15457-17-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/31] slirp: do not include qemu headers in
 libslirp.h public API header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/libslirp.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 679a25422b..02cbec9f8b 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -1,7 +1,17 @@
 #ifndef LIBSLIRP_H
 #define LIBSLIRP_H
=20
-#include "qemu-common.h"
+#include <glib.h>
+#include <stdint.h>
+#include <stdbool.h>
+
+#ifdef _WIN32
+#include <winsock2.h>
+#include <in6addr.h>
+#else
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#endif
=20
 typedef struct Slirp Slirp;
=20
--=20
2.20.1
