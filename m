Received: from eggs.gnu.org ([209.51.188.92]:34848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB6m-0004Cx-EN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB6l-0001Kk-C2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:28 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB6l-0001JA-2m
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:27 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:52:22 +0100
Message-Id: <20190114225306.21569-22-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/65] slirp: remove NO_UNIX_SOCKETS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.h        | 3 ---
 slirp/slirp_config.h | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 57955a8965..fba77d0c3d 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -28,9 +28,6 @@ typedef char *caddr_t;
 #include <arpa/inet.h>
 #endif
=20
-#ifndef NO_UNIX_SOCKETS
-#include <sys/un.h>
-#endif
 #ifndef _WIN32
 #include <sys/socket.h>
 #endif
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index a205dc8c28..4417b05d1c 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -58,9 +58,3 @@
 #ifndef _WIN32
 #define HAVE_INET_ATON
 #endif
-
-/* Define if you DON'T have unix-domain sockets */
-#undef NO_UNIX_SOCKETS
-#ifdef _WIN32
-#define NO_UNIX_SOCKETS
-#endif
--=20
2.20.1
