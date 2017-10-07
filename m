Received: from eggs.gnu.org ([2001:4830:134:3::10]:48292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1e0qWg-0006Ug-Dl
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 10:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1e0qWd-00008x-BA
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 10:56:26 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Sat,  7 Oct 2017 16:56:09 +0200
Message-Id: <20171007145609.16722-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] io: Add missing GCC_FMT_ATTR (fix
 -Werror=suggest-attribute=format)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P . Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>

This fixes a compiler warning:

/qemu/io/channel-websock.c:163:5: error:
 function might be possible candidate for =E2=80=98gnu_printf=E2=80=99 fo=
rmat attribute
 [-Werror=3Dsuggest-attribute=3Dformat]

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 io/channel-websock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index d1d471f86e..7bf1340958 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -151,9 +151,10 @@ enum {
     QIO_CHANNEL_WEBSOCK_OPCODE_PONG =3D 0xA
 };
=20
-static void qio_channel_websock_handshake_send_res(QIOChannelWebsock *io=
c,
-                                                   const char *resmsg,
-                                                   ...)
+static void GCC_FMT_ATTR(2, 3)
+qio_channel_websock_handshake_send_res(QIOChannelWebsock *ioc,
+                                       const char *resmsg,
+                                       ...)
 {
     va_list vargs;
     char *response;
--=20
2.11.0
