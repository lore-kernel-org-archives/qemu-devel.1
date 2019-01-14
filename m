Received: from eggs.gnu.org ([209.51.188.92]:51449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkQ-0003D6-By
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipkP-0006aM-A3
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:58 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipkN-0006P0-3P
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:57 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:59 +0100
Message-Id: <20190114000326.29847-39-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/65] slirp: remove unused sbflush()
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
 slirp/sbuf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/slirp/sbuf.h b/slirp/sbuf.h
index a722ecb629..644c201341 100644
--- a/slirp/sbuf.h
+++ b/slirp/sbuf.h
@@ -8,7 +8,6 @@
 #ifndef SBUF_H
 #define SBUF_H
=20
-#define sbflush(sb) sbdrop((sb),(sb)->sb_cc)
 #define sbspace(sb) ((sb)->sb_datalen - (sb)->sb_cc)
=20
 struct sbuf {
--=20
2.20.1
