Received: from eggs.gnu.org ([2001:4830:134:3::10]:40368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQc-0008JH-Hf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQY-0004Zh-T0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:27 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQR-0004Cb-Q4
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:19 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:59 +0100
Message-Id: <20181218230442.27887-22-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/64] slirp: remove NO_UNIX_SOCKETS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

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
2.19.2
