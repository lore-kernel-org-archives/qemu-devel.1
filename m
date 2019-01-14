Received: from eggs.gnu.org ([209.51.188.92]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk6-0002y0-GF
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk3-0006O0-A0
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:38 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipk2-0006KN-U1
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:35 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:35 +0100
Message-Id: <20190114000326.29847-15-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/65] slirp: remove unused M_TRAILINGSPACE
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
2.20.1
