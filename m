Received: from eggs.gnu.org ([2001:4830:134:3::10]:40536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR3-0000E7-4d
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR0-0004v8-Pw
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:56 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQy-0004Cp-KU
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:54 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:03 +0100
Message-Id: <20181218230442.27887-26-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/64] slirp: remove unused HAVE_SYS_SELECT_H
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
index 1f47848271..7606de962f 100644
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
2.19.2
