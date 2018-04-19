Received: from eggs.gnu.org ([2001:4830:134:3::10]:51218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f97Ak-0005UG-Sv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f97Ah-000688-Rt
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:52:14 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:53259
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1f97Ah-00066z-Lz
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:52:11 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu, 19 Apr 2018 12:51:43 +0200
Message-Id: <1524135103-30477-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH] riscv: requires libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, frederic.konrad@adacore.com

When compiling on a machine without libfdt installed the configure script
should try to get libfdt from the git or should die because otherwise
CONFIG_LIBFDT is not set and the build process end in an error in the link
phase.. eg:

hw/riscv/virt.o: In function `riscv_virt_board_init':
qemu/src/hw/riscv/virt.c:317: undefined reference to `qemu_fdt_setprop_cell'
qemu/src/hw/riscv/virt.c:319: undefined reference to `qemu_fdt_setprop_cell'
qemu/src/hw/riscv/virt.c:345: undefined reference to `qemu_fdt_dumpdtb'
collect2: error: ld returned 1 exit status
make[1]: *** [qemu-system-riscv64] Error 1
make: *** [subdir-riscv64-softmmu] Error 2

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 0a19b03..1587f08 100755
--- a/configure
+++ b/configure
@@ -3732,7 +3732,7 @@ fi
 fdt_required=no
 for target in $target_list; do
   case $target in
-    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
+    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv64-softmmu)
       fdt_required=yes
     ;;
   esac
-- 
1.8.3.1
