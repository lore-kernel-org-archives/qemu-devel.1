Received: from eggs.gnu.org ([2001:4830:134:3::10]:59633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuTZ-0002Q0-Nt
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuTV-0002sD-3n
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuTU-0002rD-SO
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:52 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:22 +0400
Message-Id: <20181114123643.24091-21-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 20/41] slirp: remove HAVE_SYS_IOCTL_H
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
 slirp/slirp.h        | 2 +-
 slirp/slirp_config.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index abe87618af..a2e7c50361 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -32,7 +32,7 @@ typedef char *caddr_t;
 #include <sys/socket.h>
 #endif
=20
-#if defined(HAVE_SYS_IOCTL_H)
+#ifndef _WIN32
 # include <sys/ioctl.h>
 #endif
=20
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 68e75f3873..0e78e92d94 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -11,12 +11,6 @@
  * You shouldn't need to touch any of these
  */
=20
-/* Define if you have sys/ioctl.h */
-#undef HAVE_SYS_IOCTL_H
-#ifndef _WIN32
-#define HAVE_SYS_IOCTL_H
-#endif
-
 /* Define if you have sys/filio.h */
 #undef HAVE_SYS_FILIO_H
 #ifdef __APPLE__
--=20
2.19.1.708.g4ede3d42df
