Received: from eggs.gnu.org ([2001:4830:134:3::10]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4k-00068H-MF
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4j-0002pz-VB
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:54 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs4j-0002pb-P9
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:53 -0500
Received: by mail-pf0-x243.google.com with SMTP id 19so2047604pfo.3
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:10:53 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:10:14 -0800
Message-Id: <1484514617-11726-5-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 4/7] target/xtensa: tests: run tests with icount
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

Timer tests expect certain determinism in CCOUNT updates and timer
interrupts firing. Run QEMU with -icount to get deterministic results.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index 7f9f2d9..2882c43 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -5,7 +5,7 @@ CROSS=xtensa-$(CORE)-elf-
 
 ifndef XT
 SIM = ../../../xtensa-softmmu/qemu-system-xtensa
-SIMFLAGS = -M sim -cpu $(CORE) -nographic -semihosting $(EXTFLAGS) -kernel
+SIMFLAGS = -M sim -cpu $(CORE) -nographic -semihosting -icount 7 $(EXTFLAGS) -kernel
 SIMDEBUG = -s -S
 else
 SIM = xt-run
-- 
2.1.4
