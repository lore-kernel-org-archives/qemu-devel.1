Received: from eggs.gnu.org ([2001:4830:134:3::10]:59213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuSQ-0001S7-IA
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuSO-00022F-Kl
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:39:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuSJ-0001zK-HN
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:39:39 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:16 +0400
Message-Id: <20181114123643.24091-15-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 14/41] slirp: remove unused
 HAVE_SYS_BITYPES_H
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
 slirp/slirp.h        | 4 ----
 slirp/slirp_config.h | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 1dbe39bc9a..7c0bcd9e1c 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -19,10 +19,6 @@ typedef char *caddr_t;
 # endif
 #endif
=20
-#ifdef HAVE_SYS_BITYPES_H
-# include <sys/bitypes.h>
-#endif
-
 #ifndef _WIN32
 #include <sys/uio.h>
 #endif
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 2605c4222b..a205dc8c28 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -23,9 +23,6 @@
 #define HAVE_SYS_FILIO_H
 #endif
=20
-/* Define if you have sys/bitypes.h */
-#undef HAVE_SYS_BITYPES_H
-
 /* Define if the machine is big endian */
 //#undef HOST_WORDS_BIGENDIAN
=20
--=20
2.19.1.708.g4ede3d42df
