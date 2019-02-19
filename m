Received: from eggs.gnu.org ([209.51.188.92]:49421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydQ-0005AU-D8
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydP-00072i-Ox
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:04 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydP-00071m-Gz
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:03 -0500
Received: by mail-lj1-x243.google.com with SMTP id q128so16334466ljb.11
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:03 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:52 -0800
Message-Id: <20190219061111.10231-5-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 04/23] tests/tcg/xtensa: support configs with
 LITBASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Configurations with LITBASE register may use absolute literals by
default. Pass --no-absolute-literals option to assembler to use
PC-relative literals instead.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index cd21c202876a..b3693809372b 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -18,6 +18,7 @@ CC      = $(CROSS)gcc
 AS      = $(CROSS)gcc -x assembler-with-cpp
 LD      = $(CROSS)ld
 
+ASFLAGS = -Wa,--no-absolute-literals
 vectors_ASFLAGS = -mtext-section-literals
 
 XTENSA_SRC_PATH = $(SRC_PATH)/tests/tcg/xtensa
-- 
2.11.0
