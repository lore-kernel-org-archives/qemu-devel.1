Received: from eggs.gnu.org ([2001:4830:134:3::10]:46469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhOS-0003Y5-AY
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhOO-0002kZ-CX
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:20:32 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 19 Dec 2018 19:20:19 +0000
Message-ID: <52160afacecc5b109dc43a412fa3e74ddd6277fb.1545246859.git.alistair.francis@wdc.com>
References: <cover.1545246859.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1545246859.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 23/23] configure: Add support for building
 RISC-V host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 224d3071ac..79375affc1 100755
--- a/configure
+++ b/configure
@@ -710,6 +710,12 @@ elif check_define __s390__ ; then
   else
     cpu=3D"s390"
   fi
+elif check_define __riscv ; then
+  if check_define _LP64 ; then
+    cpu=3D"riscv64"
+  else
+    cpu=3D"riscv32"
+  fi
 elif check_define __arm__ ; then
   cpu=3D"arm"
 elif check_define __aarch64__ ; then
@@ -722,7 +728,7 @@ ARCH=3D
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ppc|ppc64|s390|s390x|sparc64|x32)
+  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
     cpu=3D"$cpu"
     supported_cpu=3D"yes"
     eval "cross_cc_${cpu}=3D\$host_cc"
@@ -6937,6 +6943,8 @@ elif test "$ARCH" =3D "x86_64" -o "$ARCH" =3D "x32" ;=
 then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" =3D "ppc64" ; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
+elif test "$ARCH" =3D "riscv32" -o "$ARCH" =3D "riscv64" ; then
+  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/riscv $QEMU_INCLUDES"
 else
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
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
--=20
2.19.1
