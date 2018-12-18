Received: from eggs.gnu.org ([2001:4830:134:3::10]:40218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-00081w-So
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQF-0004H3-Tf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:10 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQE-0004Bw-Hd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:07 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:52 +0100
Message-Id: <20181218230442.27887-15-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/64] slirp: remove unused M_TRAILINGSPACE
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
2.19.2
