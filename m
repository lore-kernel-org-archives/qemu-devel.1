Received: from eggs.gnu.org ([2001:4830:134:3::10]:59338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuSg-0001cP-1n
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuSb-0002Ay-Ch
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuSb-000262-3U
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:39:57 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:17 +0400
Message-Id: <20181114123643.24091-16-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 15/41] slirp: remove NO_UNIX_SOCKETS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/slirp.h        | 3 ---
 slirp/slirp_config.h | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 7c0bcd9e1c..424151b99b 100644
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
2.19.1.708.g4ede3d42df
