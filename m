Received: from eggs.gnu.org ([2001:4830:134:3::10]:40611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR7-0000Ik-8p
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOR4-0004xZ-Tx
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:01 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOR2-0004EY-TX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:57 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:09 +0100
Message-Id: <20181218230442.27887-32-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/64] slirp: replace SIZEOF_CHAR_P with glib
 equivalent
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip.h           | 2 +-
 slirp/slirp_config.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index 83fc9cdfbf..243b6c8b24 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -177,7 +177,7 @@ struct	ip_timestamp {
=20
 #define	IP_MSS		576		/* default maximum segment size */
=20
-#if SIZEOF_CHAR_P =3D=3D 4
+#if GLIB_SIZEOF_VOID_P =3D=3D 4
 struct mbuf_ptr {
 	struct mbuf *mptr;
 	uint32_t dummy;
diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
index b2def6d20c..7147e0de04 100644
--- a/slirp/slirp_config.h
+++ b/slirp/slirp_config.h
@@ -10,6 +10,3 @@
  * Autoconf defined configuration options
  * You shouldn't need to touch any of these
  */
-
-/* Define to sizeof(char *) */
-#define SIZEOF_CHAR_P (HOST_LONG_BITS / 8)
--=20
2.19.2
