Received: from eggs.gnu.org ([208.118.235.92]:50356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtml-0006eh-Tt
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtmk-0000Zo-1q
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:43 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:46318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtmj-0000WK-SJ
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:41 -0500
Received: by mail-pl1-x62d.google.com with SMTP id t13so6794664ply.13
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:58:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:10 +1100
Message-Id: <20181225205529.10874-24-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 23/42] configure: Add support for building
 RISC-V host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <52160afacecc5b109dc43a412fa3e74ddd6277fb.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 224d3071ac..79375affc1 100755
--- a/configure
+++ b/configure
@@ -710,6 +710,12 @@ elif check_define __s390__ ; then
   else
     cpu="s390"
   fi
+elif check_define __riscv ; then
+  if check_define _LP64 ; then
+    cpu="riscv64"
+  else
+    cpu="riscv32"
+  fi
 elif check_define __arm__ ; then
   cpu="arm"
 elif check_define __aarch64__ ; then
@@ -722,7 +728,7 @@ ARCH=
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ppc|ppc64|s390|s390x|sparc64|x32)
+  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
     cpu="$cpu"
     supported_cpu="yes"
     eval "cross_cc_${cpu}=\$host_cc"
@@ -6937,6 +6943,8 @@ elif test "$ARCH" = "x86_64" -o "$ARCH" = "x32" ; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" = "ppc64" ; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
+elif test "$ARCH" = "riscv32" -o "$ARCH" = "riscv64" ; then
+  QEMU_INCLUDES="-I\$(SRC_PATH)/tcg/riscv $QEMU_INCLUDES"
 else
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
@@ -7433,7 +7441,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   ppc*)
     disas_config "PPC"
   ;;
-  riscv)
+  riscv*)
     disas_config "RISCV"
   ;;
   s390*)
-- 
2.17.2
