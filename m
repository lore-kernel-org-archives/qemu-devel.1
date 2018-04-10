Received: from eggs.gnu.org ([2001:4830:134:3::10]:49806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5zC8-0004xj-10
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5zC6-0001Gh-TC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:44 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5zC6-0001Fd-Me
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:42 -0400
Received: by mail-wm0-x242.google.com with SMTP id r131so25460259wmb.2
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:44:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:11 +0100
Message-Id: <20180410193919.28026-17-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 16/24] tests/tcg/i386: fix test-i386-fprem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Remove dependencies on QEMU's source tree and build directly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/test-i386-fprem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/i386/test-i386-fprem.c b/tests/tcg/i386/test-i386-fprem.c
index 1a71623204..771dc07433 100644
--- a/tests/tcg/i386/test-i386-fprem.c
+++ b/tests/tcg/i386/test-i386-fprem.c
@@ -23,7 +23,10 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "qemu/osdep.h"
+#include <stdio.h>
+#include <stdint.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /*
  * Inspired by <ieee754.h>'s union ieee854_long_double, but with single
@@ -39,7 +42,7 @@ union float80u {
         unsigned int exponent:15;
         unsigned int negative:1;
         unsigned int empty:16;
-    } QEMU_PACKED ieee;
+    } __attribute__((packed)) ieee;
 
     /* This is for NaNs in the IEEE 854 double-extended-precision format.  */
     struct {
@@ -49,7 +52,7 @@ union float80u {
         unsigned int exponent:15;
         unsigned int negative:1;
         unsigned int empty:16;
-    } QEMU_PACKED ieee_nan;
+    } __attribute__((packed)) ieee_nan;
 };
 
 #define IEEE854_LONG_DOUBLE_BIAS 0x3fff
-- 
2.16.2
