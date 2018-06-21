Received: from eggs.gnu.org ([2001:4830:134:3::10]:33581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtbS-0004Lk-44
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtbN-0008IM-SB
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:01:58 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVtbN-0008Hp-LD
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:01:53 -0400
Received: by mail-wm0-x232.google.com with SMTP id r125-v6so3787043wmg.2
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 00:01:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:26 +0100
Message-Id: <20180621062605.941-19-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 18/57] tests/tcg/i386: fix test-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

We don't include anything from qemu itself for the build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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
2.17.1
