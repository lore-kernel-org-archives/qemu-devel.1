Received: from eggs.gnu.org ([2001:4830:134:3::10]:49357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C57-0000q4-JO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C54-0001wu-2b
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:29 +0300
Message-Id: <2de123a1ecbc3d364a808a5c2de1301a2c43338c.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/14] linux-user: remove duplicate break in
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

likely introduced in 3532fa7402cda16f7b95261b0339c58630051f0b

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..3ef4d1c568 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3131,7 +3131,6 @@ set_timeout:
         case TARGET_SO_RCVLOWAT:
 		optname =3D SO_RCVLOWAT;
 		break;
-            break;
         default:
             goto unimplemented;
         }
--=20
2.11.0
