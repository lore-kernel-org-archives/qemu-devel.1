Received: from eggs.gnu.org ([2001:4830:134:3::10]:54316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRT-0002RF-Uh
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNgRO-0000eF-Br
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:59 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 16 Nov 2018 15:53:20 +0000
Message-Id: <20181116155325.22428-2-berrange@redhat.com>
In-Reply-To: <20181116155325.22428-1-berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6 for-3.1] nbd: fix whitespace in server
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

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
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 4e8f5ae51b..12e8139f95 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1135,7 +1135,7 @@ static int nbd_negotiate_options(NBDClient *client,=
 uint16_t myflags,
=20
             default:
                 ret =3D nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD, errp,
-                                   "Option 0x%" PRIx32
+                                   "Option 0x%" PRIx32 " "
                                    "not permitted before TLS", option);
                 /* Let the client keep trying, unless they asked to
                  * quit. In this mode, we've already sent an error, so
--=20
2.19.1
