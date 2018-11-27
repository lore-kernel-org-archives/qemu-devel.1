Received: from eggs.gnu.org ([2001:4830:134:3::10]:37235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkcN-0006SU-Qo
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=862abf4e0=Alistair.Francis@wdc.com>)
	id 1gRkcK-0005ND-LT
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:10:03 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 27 Nov 2018 21:09:56 +0000
Message-ID: <5382fea4f91a7b73adb2d4e5e7318c30bd7d83ce.1543352682.git.alistair.francis@wdc.com>
References: <cover.1543352682.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1543352682.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v2 22/24] configure: Add support for building
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
index 0a3c6a72c3..fb52954368 100755
--- a/configure
+++ b/configure
@@ -709,6 +709,12 @@ elif check_define __s390__ ; then
   else
     cpu=3D"s390"
   fi
+elif check_define __riscv ; then
+  if check_define _LP64 ; then
+    cpu=3D"riscv64"
+  elif check_define _ILP32 ; then
+    cpu=3D"riscv32"
+  fi
 elif check_define __arm__ ; then
   cpu=3D"arm"
 elif check_define __aarch64__ ; then
@@ -721,7 +727,7 @@ ARCH=3D
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ppc|ppc64|s390|s390x|sparc64|x32)
+  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
     cpu=3D"$cpu"
     supported_cpu=3D"yes"
     eval "cross_cc_${cpu}=3D\$host_cc"
@@ -6900,6 +6906,8 @@ elif test "$ARCH" =3D "x86_64" -o "$ARCH" =3D "x32" ;=
 then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/i386 $QEMU_INCLUDES"
 elif test "$ARCH" =3D "ppc64" ; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/ppc $QEMU_INCLUDES"
+elif test "$ARCH" =3D "riscv32" -o "$ARCH" =3D "riscv64" ; then
+  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/tcg/riscv $QEMU_INCLUDES"
 else
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
@@ -7397,7 +7405,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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
