Received: from eggs.gnu.org ([2001:4830:134:3::10]:32881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4q5-0006Ji-6b
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4q2-0006AZ-A4
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:17 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:09:56 +0200
Message-Id: <20180430091037.13878-2-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/42] linux-user: set minimum uname for RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180425100218.24785-1-alex.bennee@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
2.14.3
