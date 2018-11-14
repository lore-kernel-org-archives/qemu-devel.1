Received: from eggs.gnu.org ([2001:4830:134:3::10]:60029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuUj-0003JA-A7
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuUe-0003hR-9F
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuUc-0003g2-BY
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:02 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:29 +0400
Message-Id: <20181114123643.24091-28-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 27/41] slirp: remove unused global
 slirp_instance
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
 slirp/slirp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index c328aac88a..4356b2f427 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -199,8 +199,6 @@ struct Slirp {
     void *opaque;
 };
=20
-extern Slirp *slirp_instance;
-
 #ifndef NULL
 #define NULL (void *)0
 #endif
--=20
2.19.1.708.g4ede3d42df
