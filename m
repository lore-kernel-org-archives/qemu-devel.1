Received: from eggs.gnu.org ([2001:4830:134:3::10]:52334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Ma-0000rl-TS
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MY-0000GY-LK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MY-00005u-4I
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id y1so6137102wmi.3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:39 +0100
Message-Id: <1544628195-37728-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/54] build-sys: don't include windows.h,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

osdep.h will also define the available Windows API version for QEMU.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181122110039.15972-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translate-all.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 639f0b2..8cb8c88 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -16,12 +16,8 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
-#ifdef _WIN32
-#include <windows.h>
-#endif
 #include "qemu/osdep.h"
 
-
 #include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
-- 
1.8.3.1
