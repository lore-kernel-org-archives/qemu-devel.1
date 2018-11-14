Received: from eggs.gnu.org ([2001:4830:134:3::10]:59772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuUF-0002xP-OG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuUA-0003IJ-9a
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:41:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuTy-00037z-8m
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:41:27 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:25 +0400
Message-Id: <20181114123643.24091-24-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 23/41] slirp: remove unused
 HAVE_INET_ATON
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
 slirp/slirp_config.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 833f25a965..5126711849 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -16,9 +16,3 @@
=20
 /* Define to sizeof(char *) */
 #define SIZEOF_CHAR_P (HOST_LONG_BITS / 8)
-
-/* Define if you have inet_aton */
-#undef HAVE_INET_ATON
-#ifndef _WIN32
-#define HAVE_INET_ATON
-#endif
--=20
2.19.1.708.g4ede3d42df
