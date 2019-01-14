Received: from eggs.gnu.org ([209.51.188.92]:35154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7F-0004l6-UD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7E-0001dy-0S
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:57 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB7B-0001SN-Uj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:53:55 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:52:40 +0100
Message-Id: <20190114225306.21569-40-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 39/65] slirp: NULL is defined by stddef.h
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
 slirp/slirp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index d1b6bcefbb..fdf397256b 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -199,10 +199,6 @@ struct Slirp {
     void *opaque;
 };
=20
-#ifndef NULL
-#define NULL (void *)0
-#endif
-
 void if_start(Slirp *);
=20
 int get_dns_addr(struct in_addr *pdns_addr);
--=20
2.20.1
