Received: from eggs.gnu.org ([2001:4830:134:3::10]:51326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnkx-0008VW-Ky
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnkw-0002WB-Kz
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:43 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:19 -0600
Message-Id: <20181119175427.2298497-5-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/12] nbd: fix whitespace in server error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

A space was missing after the option number was printed:

  Option 0x8not permitted before TLS

becomes

  Option 0x8 not permitted before TLS

This fixes

  commit 3668328303429f3bc93ab3365c66331600b06a2d
  Author: Eric Blake <eblake@redhat.com>
  Date:   Fri Oct 14 13:33:09 2016 -0500

    nbd: Send message along with server NBD_REP_ERR errors

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20181116155325.22428-2-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: move lone space to next line]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 4e8f5ae51b0..056cfa5ad47 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1136,7 +1136,7 @@ static int nbd_negotiate_options(NBDClient *client,=
 uint16_t myflags,
             default:
                 ret =3D nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD, errp,
                                    "Option 0x%" PRIx32
-                                   "not permitted before TLS", option);
+                                   " not permitted before TLS", option);
                 /* Let the client keep trying, unless they asked to
                  * quit. In this mode, we've already sent an error, so
                  * we can't ack the abort.  */
--=20
2.17.2
