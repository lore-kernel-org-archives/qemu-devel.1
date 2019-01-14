Received: from eggs.gnu.org ([209.51.188.92]:51455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkQ-0003D9-Hl
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkP-0006aD-84
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:58 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipkN-0006Na-2y
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:57 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:41 +0100
Message-Id: <20190114000326.29847-21-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/65] slirp: remove unused HAVE_SYS_BITYPES_H
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.h        | 4 ----
 slirp/slirp_config.h | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 4c3c672ee6..57955a8965 100644
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
2.20.1
