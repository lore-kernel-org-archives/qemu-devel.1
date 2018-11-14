Received: from eggs.gnu.org ([2001:4830:134:3::10]:59672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuTb-0002RH-3C
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuTZ-0002v8-Vv
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuTZ-0002u8-OG
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:40:57 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:23 +0400
Message-Id: <20181114123643.24091-22-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 21/41] slirp: remove HAVE_SYS_FILIO_H
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
index a2e7c50361..1a336b2cf1 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -36,7 +36,7 @@ typedef char *caddr_t;
 # include <sys/ioctl.h>
 #endif
=20
-#ifdef HAVE_SYS_FILIO_H
+#ifdef __APPLE__
 # include <sys/filio.h>
 #endif
=20
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index 0e78e92d94..f1ee927c15 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -11,12 +11,6 @@
  * You shouldn't need to touch any of these
  */
=20
-/* Define if you have sys/filio.h */
-#undef HAVE_SYS_FILIO_H
-#ifdef __APPLE__
-#define HAVE_SYS_FILIO_H
-#endif
-
 /* Define if the machine is big endian */
 //#undef HOST_WORDS_BIGENDIAN
=20
--=20
2.19.1.708.g4ede3d42df
