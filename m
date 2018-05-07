Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fFpN1-0008Br-Om
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fFpN0-0006vs-Pb
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:39 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fFpN0-0006uP-K4
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:38 -0400
Received: by mail-pg0-x241.google.com with SMTP id x145-v6so46513pgx.11
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 16:16:38 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue,  8 May 2018 11:14:53 +1200
Message-Id: <1525734893-10299-4-git-send-email-mjc@sifive.com>
In-Reply-To: <1525734893-10299-1-git-send-email-mjc@sifive.com>
References: <1525734893-10299-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/3] riscv: requires libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, KONRAD Frederic <frederic.konrad@adacore.com>

From: KONRAD Frederic <frederic.konrad@adacore.com>

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

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Message-Id: <1525360636-18229-4-git-send-email-frederic.konrad@adacore.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 1443422e83f1..479e9a787e6e 100755
--- a/configure
+++ b/configure
@@ -3761,7 +3761,7 @@ fi
 fdt_required=no
 for target in $target_list; do
   case $target in
-    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
+    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv*-softmmu)
       fdt_required=yes
     ;;
   esac
-- 
2.7.0
