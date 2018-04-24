Received: from eggs.gnu.org ([2001:4830:134:3::10]:59903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fB0Pr-0005Et-8w
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fB0Pn-00063k-Bw
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:03:39 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fB0Pn-00062j-5r
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:03:35 -0400
Received: by mail-wm0-x242.google.com with SMTP id n10so1760864wmc.1
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 09:03:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 17:03:29 +0100
Message-Id: <20180424160329.8089-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: set minimum uname for RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

As support was merged into the mainline kernel at 4.15 it is unlikely
3.8.0 is the correct value. Indeed when I testing binaries created by
the current Debian SID compiler the tests failed with:

  FATAL: kernel too old

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/riscv/target_syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
index d4e109a27f..ee81d8bc88 100644
--- a/linux-user/riscv/target_syscall.h
+++ b/linux-user/riscv/target_syscall.h
@@ -45,7 +45,7 @@ struct target_pt_regs {
 #else
 #define UNAME_MACHINE "riscv64"
 #endif
-#define UNAME_MINIMUM_RELEASE "3.8.0"
+#define UNAME_MINIMUM_RELEASE "4.15.0"
 
 #define TARGET_MINSIGSTKSZ 2048
 #define TARGET_MLOCKALL_MCL_CURRENT 1
-- 
2.17.0
