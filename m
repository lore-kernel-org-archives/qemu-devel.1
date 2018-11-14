Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuT2-0001zr-8X
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuSt-0002PS-QC
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuSt-0002Od-Jp
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:15 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:18 +0400
Message-Id: <20181114123643.24091-17-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 16/41] slirp: remove unused
 HAVE_SYS_STROPTS_H
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
 slirp/slirp.h        | 5 -----
 slirp/slirp_config.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 424151b99b..92abb2d78d 100644
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
2.19.1.708.g4ede3d42df
