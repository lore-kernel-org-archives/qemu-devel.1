Received: from eggs.gnu.org ([2001:4830:134:3::10]:39267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEFz7-0004SW-Fl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEFz6-0003EG-CF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:17:29 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu,  3 May 2018 17:17:16 +0200
Message-Id: <1525360636-18229-4-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1525360636-18229-1-git-send-email-frederic.konrad@adacore.com>
References: <1525360636-18229-1-git-send-email-frederic.konrad@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V2 3/3] riscv: requires libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: mjc@sifive.com, kbastian@mail.uni-paderborn.de, f4bug@amsat.org, peter.maydell@linaro.org, frederic.konrad@adacore.com

When compiling on a machine without libfdt installed the configure script
should try to get libfdt from the git or should die because otherwise
CONFIG_LIBFDT is not set and the build process end in an error in the lin=
k
phase.. eg:

hw/riscv/virt.o: In function `riscv_virt_board_init':
qemu/src/hw/riscv/virt.c:317: undefined reference to `qemu_fdt_setprop_ce=
ll'
qemu/src/hw/riscv/virt.c:319: undefined reference to `qemu_fdt_setprop_ce=
ll'
qemu/src/hw/riscv/virt.c:345: undefined reference to `qemu_fdt_dumpdtb'
collect2: error: ld returned 1 exit status
make[1]: *** [qemu-system-riscv64] Error 1
make: *** [subdir-riscv64-softmmu] Error 2

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

---
V1 -> V2:
  * Requires libfdt for riscv*-softmmu instead of riscv64-softmmu only.
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 1443422..479e9a7 100755
--- a/configure
+++ b/configure
@@ -3761,7 +3761,7 @@ fi
 fdt_required=3Dno
 for target in $target_list; do
   case $target in
-    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips6=
4el-softmmu)
+    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips6=
4el-softmmu|riscv*-softmmu)
       fdt_required=3Dyes
     ;;
   esac
--=20
1.8.3.1
