Received: from eggs.gnu.org ([209.51.188.92]:34956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB6z-0004Tq-08
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB6y-0001UF-5W
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:40 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:40404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB6x-0001Ny-V1
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:40 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:52:26 +0100
Message-Id: <20190114225306.21569-26-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/65] slirp: remove unused HAVE_SYS_SELECT_H
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
2.20.1
