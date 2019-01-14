Received: from eggs.gnu.org ([209.51.188.92]:51251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk7-0002z5-N2
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk4-0006QR-J6
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:39 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipk4-0006NZ-7K
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:36 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:45 +0100
Message-Id: <20190114000326.29847-25-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/65] slirp: remove unused HAVE_SYS_WAIT_H
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
index 400f585cec..1f47848271 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -40,10 +40,6 @@ typedef char *caddr_t;
 # include <sys/select.h>
 #endif
=20
-#ifdef HAVE_SYS_WAIT_H
-# include <sys/wait.h>
-#endif
-
 #ifdef HAVE_SYS_FILIO_H
 # include <sys/filio.h>
 #endif
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index e95284071a..9becb98e11 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -32,9 +32,6 @@
 #define DECLARE_IOVEC
 #endif
=20
-/* Define if you have a POSIX.1 sys/wait.h */
-#undef HAVE_SYS_WAIT_H
-
 /* Define if you have sys/select.h */
 #undef HAVE_SYS_SELECT_H
 #ifndef _WIN32
--=20
2.20.1
