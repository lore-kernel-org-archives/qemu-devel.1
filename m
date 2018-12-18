Received: from eggs.gnu.org ([2001:4830:134:3::10]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-00081q-SI
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQF-0004Gt-UA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:10 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQE-0004Bx-2E
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:07 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:57 +0100
Message-Id: <20181218230442.27887-20-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/64] slirp: remove HAVE_SYS_SIGNAL_H
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
 slirp/slirp.h        | 3 ---
 slirp/slirp_config.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index f7c087456a..4c3c672ee6 100644
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
2.19.2
