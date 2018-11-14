Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuUK-000313-Qs
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuUJ-0003PH-1M
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:41:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuUI-0003HI-Lc
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:41:42 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:27 +0400
Message-Id: <20181114123643.24091-26-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 25/41] slirp: replace SIZEOF_CHAR_P
 with glib equivalent
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
2.19.1.708.g4ede3d42df
