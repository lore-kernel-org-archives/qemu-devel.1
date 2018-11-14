Received: from eggs.gnu.org ([2001:4830:134:3::10]:59627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuTZ-0002Pw-Me
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuTU-0002rX-FT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuTU-0002jl-6h
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:52 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:21 +0400
Message-Id: <20181114123643.24091-20-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 19/41] slirp: remove unused
 HAVE_SYS_SELECT_H
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
 slirp/main.h         | 4 ----
 slirp/slirp.h        | 4 ----
 slirp/slirp_config.h | 6 ------
 3 files changed, 14 deletions(-)

diff --git a/slirp/main.h b/slirp/main.h
index e04677944f..4bc05fb904 100644
--- a/slirp/main.h
+++ b/slirp/main.h
@@ -8,10 +8,6 @@
 #ifndef SLIRP_MAIN_H
 #define SLIRP_MAIN_H
=20
-#ifdef HAVE_SYS_SELECT_H
-#include <sys/select.h>
-#endif
-
 extern u_int curtime;
 extern struct in_addr loopback_addr;
 extern unsigned long loopback_mask;
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 7aa14feeb6..abe87618af 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -36,10 +36,6 @@ typedef char *caddr_t;
 # include <sys/ioctl.h>
 #endif
=20
-#ifdef HAVE_SYS_SELECT_H
-# include <sys/select.h>
-#endif
-
 #ifdef HAVE_SYS_FILIO_H
 # include <sys/filio.h>
 #endif
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 9becb98e11..68e75f3873 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -32,12 +32,6 @@
 #define DECLARE_IOVEC
 #endif
=20
-/* Define if you have sys/select.h */
-#undef HAVE_SYS_SELECT_H
-#ifndef _WIN32
-#define HAVE_SYS_SELECT_H
-#endif
-
 /* Define to sizeof(char *) */
 #define SIZEOF_CHAR_P (HOST_LONG_BITS / 8)
=20
--=20
2.19.1.708.g4ede3d42df
