Received: from eggs.gnu.org ([2001:4830:134:3::10]:50704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPmjE-0005aG-7X
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPmj9-0003h9-Gx
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:01:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPmj9-0003g2-BI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:00:55 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 15:00:36 +0400
Message-Id: <20181122110039.15972-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181122110039.15972-1-marcandre.lureau@redhat.com>
References: <20181122110039.15972-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 1/4] build-sys: don't include windows.h,
 osdep.h does it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, samuel.thibault@ens-lyon.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

osdep.h will also define the available Windows API version for QEMU.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 accel/tcg/translate-all.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 639f0b2728..8cb8c8870e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -16,12 +16,8 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifdef _WIN32
-#include <windows.h>
-#endif
 #include "qemu/osdep.h"
=20
-
 #include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
--=20
2.20.0.rc1
