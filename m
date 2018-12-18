Received: from eggs.gnu.org ([2001:4830:134:3::10]:40654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR8-0000KT-Gf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR7-0004zO-FD
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:02 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR7-0004Ce-3l
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:01 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:00 +0100
Message-Id: <20181218230442.27887-23-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/64] slirp: remove unused HAVE_SYS_STROPTS_H
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
 slirp/slirp.h        | 5 -----
 slirp/slirp_config.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index fba77d0c3d..400f585cec 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -54,11 +54,6 @@ typedef char *caddr_t;
 #define remque slirp_remque
 #define quehead slirp_quehead
=20
-#ifdef HAVE_SYS_STROPTS_H
-#include <sys/stropts.h>
-#endif
-
-
 #include "debug.h"
=20
 #include "qemu/queue.h"
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 4417b05d1c..47811e36dc 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -47,9 +47,6 @@
 #define HAVE_ARPA_INET_H
 #endif
=20
-/* Define if you have sys/stropts.h */
-#undef HAVE_SYS_STROPTS_H
-
 /* Define to sizeof(char *) */
 #define SIZEOF_CHAR_P (HOST_LONG_BITS / 8)
=20
--=20
2.19.2
