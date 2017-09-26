Received: from eggs.gnu.org ([2001:4830:134:3::10]:43267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwhGd-0000Qr-I1
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwhGa-000679-EP
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:14:43 -0400
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Mon, 25 Sep 2017 21:14:20 -0700
Message-Id: <20170926041420.32673-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: remove duplicate break in syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, qemu-trivial@nongnu.org, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

likely introduced in 3532fa7402cda16f7b95261b0339c58630051f0b

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..3ef4d1c568 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3131,7 +3131,6 @@ set_timeout:
         case TARGET_SO_RCVLOWAT:
 		optname = SO_RCVLOWAT;
 		break;
-            break;
         default:
             goto unimplemented;
         }
-- 
2.14.1
