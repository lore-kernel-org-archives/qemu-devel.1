Received: from eggs.gnu.org ([2001:4830:134:3::10]:45106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBHG6-00005a-FI
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBHG3-0007jK-Rg
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:02:42 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBHG3-0007iz-K7
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:02:39 -0400
Received: by mail-wr0-x243.google.com with SMTP id c14-v6so12589390wrd.4
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 03:02:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 25 Apr 2018 11:02:18 +0100
Message-Id: <20180425100218.24785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] linux-user: set minimum uname for RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

As support for RISC-V was only merged into the mainline kernel at 4.15
it is unlikely that glibc will be happy with a reported kernel version
of 3.8.0. Indeed when I testing binaries created by the current Debian
Sid compiler the tests failed with:

  FATAL: kernel too old

Bump the version to the minimum a RISC-V glibc would expect:

  https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/riscv/configure.ac

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - minor tweak to wording to make clearer and add link to glibc config
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
