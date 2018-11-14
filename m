Received: from eggs.gnu.org ([2001:4830:134:3::10]:59343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuSg-0001cR-1v
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuSa-0002AJ-PT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuSa-0001t3-I4
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:39:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:15 +0400
Message-Id: <20181114123643.24091-14-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 13/41] slirp: remove HAVE_SYS_SIGNAL_H
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
 slirp/slirp_config.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index e5abf1c594..1dbe39bc9a 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -35,9 +35,6 @@ typedef char *caddr_t;
 #ifndef NO_UNIX_SOCKETS
 #include <sys/un.h>
 #endif
-#ifdef HAVE_SYS_SIGNAL_H
-# include <sys/signal.h>
-#endif
 #ifndef _WIN32
 #include <sys/socket.h>
 #endif
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 3ce64e088e..2605c4222b 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -50,9 +50,6 @@
 #define HAVE_ARPA_INET_H
 #endif
=20
-/* Define if you have sys/signal.h */
-#undef HAVE_SYS_SIGNAL_H
-
 /* Define if you have sys/stropts.h */
 #undef HAVE_SYS_STROPTS_H
=20
--=20
2.19.1.708.g4ede3d42df
