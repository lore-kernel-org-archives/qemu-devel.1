Received: from eggs.gnu.org ([2001:4830:134:3::10]:60382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuVq-0004bu-Tv
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuVk-0004FS-Uq
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuVk-0004F4-Pw
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:43:12 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:37 +0400
Message-Id: <20181114123643.24091-36-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 35/41] slirp: NULL is defined by glib
 (at least)
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
 slirp/slirp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 4356b2f427..2a61a85995 100644
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
2.19.1.708.g4ede3d42df
