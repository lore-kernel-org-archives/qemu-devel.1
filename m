Received: from eggs.gnu.org ([2001:4830:134:3::10]:52828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANY-0004n2-3W
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANT-00068L-Dc
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:40 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ANT-00067y-5j
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:35 -0400
Received: by mail-wr0-x243.google.com with SMTP id o15-v6so14510341wro.11
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:17:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:37 +0100
Message-Id: <20180419135901.30035-20-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 19/43] tests/tcg/i386: fix test-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The test-i386 test case is a little special as it includes assembler
files. Add the additional compile magic to assemble these bits and
link them to the final binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/tcg/i386/test-i386.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index 9599204895..cae6a7773a 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -17,7 +17,6 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #define _GNU_SOURCE
-#include "qemu/compiler.h"
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.17.0
