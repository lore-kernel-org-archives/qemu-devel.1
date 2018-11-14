Received: from eggs.gnu.org ([2001:4830:134:3::10]:58603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQT-0008HB-Lj
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQR-0000vR-OW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuQP-0000sH-QL
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:06 +0400
Message-Id: <20181114123643.24091-5-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 04/41] slirp: remove unused
 M_TRAILINGSPACE
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
 slirp/mbuf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/slirp/mbuf.h b/slirp/mbuf.h
index bfdf8c4577..cbf17e136b 100644
--- a/slirp/mbuf.h
+++ b/slirp/mbuf.h
@@ -72,7 +72,6 @@
  * How much free room there is
  */
 #define M_FREEROOM(m) (M_ROOM(m) - (m)->m_len)
-#define M_TRAILINGSPACE M_FREEROOM
=20
 struct mbuf {
 	/* XXX should union some of these! */
--=20
2.19.1.708.g4ede3d42df
