Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C57-0000q0-HQ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C54-0001xB-3S
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:35 +0300
Message-Id: <52aa5644e8e89ebfc3b1d0abdb7cc502ce9db599.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/14] io: Add missing GCC_FMT_ATTR (fix
 -Werror=suggest-attribute=format)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Stefan Weil <sw@weilnetz.de>

This fixes a compiler warning:

/qemu/io/channel-websock.c:163:5: error:
 function might be possible candidate for =E2=80=98gnu_printf=E2=80=99 fo=
rmat attribute
 [-Werror=3Dsuggest-attribute=3Dformat]

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Acked-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
