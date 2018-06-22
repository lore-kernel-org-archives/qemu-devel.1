Received: from eggs.gnu.org ([2001:4830:134:3::10]:38427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnM-00064W-Rt
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnH-00064F-Ri
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:12 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnH-00063n-KK
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:07 -0400
Received: by mail-wr0-x242.google.com with SMTP id e18-v6so6870829wrs.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:44 +0100
Message-Id: <20180622141205.16306-2-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 01/22] risu_reginfo_aarch64: include
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
