Received: from eggs.gnu.org ([2001:4830:134:3::10]:40572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR5-0000Gg-5F
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR3-0004wN-0K
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:58 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR0-0004Jt-ST
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:55 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:05 +0100
Message-Id: <20181218230442.27887-28-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/64] slirp: remove HAVE_SYS_FILIO_H
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
 slirp/slirp.h        | 2 +-
 slirp/slirp_config.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 226bced429..4bbbba046e 100644
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
2.19.2
