Received: from eggs.gnu.org ([2001:4830:134:3::10]:50301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jn-0002Zs-UZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jk-0004yG-Cf
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:07 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5Jk-0004wn-6Y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:04 -0400
Received: by mail-wm0-x241.google.com with SMTP id p11-v6so5195700wmc.4
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:56:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:55:40 +0100
Message-Id: <20180613125601.14371-2-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 01/22] risu_reginfo_aarch64: include
 signal.h for FPSIMD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Building with the Bionic Beaver cross compilers fails which probably
means we were getting this as a side effect before. Include the
correct header to get at these bits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu_reginfo_aarch64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index e3fadde..3bb4339 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <ucontext.h>
 #include <string.h>
+#include <signal.h> /* for FPSIMD_MAGIC */
 
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
-- 
2.17.1
