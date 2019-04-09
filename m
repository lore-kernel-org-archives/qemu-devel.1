Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB69AC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F01F20830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F01F20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50209 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzlJ-0006Uj-QX
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:02:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjP-0005JE-7c
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDzjN-0001AN-G4
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDzjN-00019j-1D
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:00:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58B0C30A3AF6;
	Tue,  9 Apr 2019 23:00:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ACEA61001DC0;
	Tue,  9 Apr 2019 23:00:34 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org,
	imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com,
	mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 01:00:11 +0200
Message-Id: <20190409230022.6462-2-lersek@redhat.com>
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 09 Apr 2019 23:00:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 v4 01/12] roms: lift "edk2-funcs.sh"
 from "tests/uefi-test-tools/build.sh"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409230011.sTay4mAzUTpXDENZ9u9w3crlx7Yzs61WJn1c_K81oj8@z>

Extract the dense logic for architecture and toolchain massaging from
"tests/uefi-test-tools/build.sh", to a set of small functions. We'll reus=
e
these functions for building full platform firmware images.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Igor's T-b
   =20
    v2:
   =20
    - Pick up Phil's R-b and T-b. (I hope that's okay, after the discussi=
on
      about cross-building on Ubuntu and/or with Linaro toolchains!)
   =20
    - drop comma after copyright year, in the new file [Eric]
   =20
    - clarify in the leading comment of "edk2-funcs.sh" that the file
      requires bash [Phil, Eric]
   =20
    - pick up Michal's and Michael's R-b's

 roms/edk2-funcs.sh             | 240 ++++++++++++++++++++
 tests/uefi-test-tools/build.sh |  97 +-------
 2 files changed, 246 insertions(+), 91 deletions(-)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
new file mode 100644
index 000000000000..8930479dcb44
--- /dev/null
+++ b/roms/edk2-funcs.sh
@@ -0,0 +1,240 @@
+# Shell script that defines functions for determining some environmental
+# characteristics for the edk2 "build" utility.
+#
+# This script is meant to be sourced, in a bash environment.
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# This program and the accompanying materials are licensed and made avai=
lable
+# under the terms and conditions of the BSD License that accompanies thi=
s
+# distribution. The full text of the license may be found at
+# <http://opensource.org/licenses/bsd-license.php>.
+#
+# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+
+
+# Verify whether the QEMU system emulation target is supported by the UE=
FI spec
+# and edk2. Print a message to the standard error, and return with nonze=
ro
+# status, if verification fails.
+#
+# Parameters:
+#   $1: QEMU system emulation target
+qemu_edk2_verify_arch()
+{
+  local emulation_target=3D"$1"
+  local program_name=3D$(basename -- "$0")
+
+  case "$emulation_target" in
+    (arm|aarch64|i386|x86_64)
+      ;;
+    (*)
+      printf '%s: unknown/unsupported QEMU system emulation target "%s"\=
n' \
+        "$program_name" "$emulation_target" >&2
+      return 1
+      ;;
+  esac
+}
+
+
+# Translate the QEMU system emulation target to the edk2 architecture
+# identifier. Print the result to the standard output.
+#
+# Parameters:
+#   $1: QEMU system emulation target
+qemu_edk2_get_arch()
+{
+  local emulation_target=3D"$1"
+
+  if ! qemu_edk2_verify_arch "$emulation_target"; then
+    return 1
+  fi
+
+  case "$emulation_target" in
+    (arm)
+      printf 'ARM\n'
+      ;;
+    (aarch64)
+      printf 'AARCH64\n'
+      ;;
+    (i386)
+      printf 'IA32\n'
+      ;;
+    (x86_64)
+      printf 'X64\n'
+      ;;
+  esac
+}
+
+
+# Translate the QEMU system emulation target to the gcc cross-compilatio=
n
+# architecture identifier. Print the result to the standard output.
+#
+# Parameters:
+#   $1: QEMU system emulation target
+qemu_edk2_get_gcc_arch()
+{
+  local emulation_target=3D"$1"
+
+  if ! qemu_edk2_verify_arch "$emulation_target"; then
+    return 1
+  fi
+
+  case "$emulation_target" in
+    (arm|aarch64|x86_64)
+      printf '%s\n' "$emulation_target"
+      ;;
+    (i386)
+      printf 'i686\n'
+      ;;
+  esac
+}
+
+
+# Determine the gcc cross-compiler prefix (if any) for use with the edk2
+# toolchain. Print the result to the standard output.
+#
+# Parameters:
+#   $1: QEMU system emulation target
+qemu_edk2_get_cross_prefix()
+{
+  local emulation_target=3D"$1"
+  local gcc_arch
+  local host_arch
+
+  if ! gcc_arch=3D$(qemu_edk2_get_gcc_arch "$emulation_target"); then
+    return 1
+  fi
+
+  host_arch=3D$(uname -m)
+
+  if [ "$gcc_arch" =3D=3D "$host_arch" ] ||
+     ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] ); =
then
+    # no cross-compiler needed
+    :
+  else
+    printf '%s-linux-gnu-\n' "$gcc_arch"
+  fi
+}
+
+
+# Determine the edk2 toolchain tag for the QEMU system emulation target.=
 Print
+# the result to the standard output. Print a message to the standard err=
or, and
+# return with nonzero status, if the (conditional) gcc version check fai=
ls.
+#
+# Parameters:
+#   $1: QEMU system emulation target
+qemu_edk2_get_toolchain()
+{
+  local emulation_target=3D"$1"
+  local program_name=3D$(basename -- "$0")
+  local cross_prefix
+  local gcc_version
+
+  if ! qemu_edk2_verify_arch "$emulation_target"; then
+    return 1
+  fi
+
+  case "$emulation_target" in
+    (arm|aarch64)
+      printf 'GCC5\n'
+      ;;
+
+    (i386|x86_64)
+      if ! cross_prefix=3D$(qemu_edk2_get_cross_prefix "$emulation_targe=
t"); then
+        return 1
+      fi
+
+      gcc_version=3D$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{pri=
nt $3}')
+      # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more informati=
on on
+      # the mapping below.
+      case "$gcc_version" in
+        ([1-3].*|4.[0-3].*)
+          printf '%s: unsupported gcc version "%s"\n' \
+            "$program_name" "$gcc_version" >&2
+          return 1
+          ;;
+        (4.4.*)
+          printf 'GCC44\n'
+          ;;
+        (4.5.*)
+          printf 'GCC45\n'
+          ;;
+        (4.6.*)
+          printf 'GCC46\n'
+          ;;
+        (4.7.*)
+          printf 'GCC47\n'
+          ;;
+        (4.8.*)
+          printf 'GCC48\n'
+          ;;
+        (4.9.*|6.[0-2].*)
+          printf 'GCC49\n'
+          ;;
+        (*)
+          printf 'GCC5\n'
+          ;;
+      esac
+      ;;
+  esac
+}
+
+
+# Determine the name of the environment variable that exposes the
+# cross-compiler prefix to the edk2 "build" utility. Print the result to=
 the
+# standard output.
+#
+# Parameters:
+#   $1: QEMU system emulation target
+qemu_edk2_get_cross_prefix_var()
+{
+  local emulation_target=3D"$1"
+  local edk2_toolchain
+  local edk2_arch
+
+  if ! edk2_toolchain=3D$(qemu_edk2_get_toolchain "$emulation_target"); =
then
+    return 1
+  fi
+
+  case "$emulation_target" in
+    (arm|aarch64)
+      if ! edk2_arch=3D$(qemu_edk2_get_arch "$emulation_target"); then
+        return 1
+      fi
+      printf '%s_%s_PREFIX\n' "$edk2_toolchain" "$edk2_arch"
+      ;;
+    (i386|x86_64)
+      printf '%s_BIN\n' "$edk2_toolchain"
+      ;;
+  esac
+}
+
+
+# Set and export the environment variable(s) necessary for cross-compila=
tion,
+# whenever needed by the edk2 "build" utility.
+#
+# Parameters:
+#   $1: QEMU system emulation target
+qemu_edk2_set_cross_env()
+{
+  local emulation_target=3D"$1"
+  local cross_prefix
+  local cross_prefix_var
+
+  if ! cross_prefix=3D$(qemu_edk2_get_cross_prefix "$emulation_target");=
 then
+    return 1
+  fi
+
+  if [ -z "$cross_prefix" ]; then
+    # Nothing to do.
+    return 0
+  fi
+
+  if ! cross_prefix_var=3D$(qemu_edk2_get_cross_prefix_var \
+                            "$emulation_target"); then
+    return 1
+  fi
+
+  eval "export $cross_prefix_var=3D\$cross_prefix"
+}
diff --git a/tests/uefi-test-tools/build.sh b/tests/uefi-test-tools/build=
.sh
index 155cb75c4ddb..e2b52c855c39 100755
--- a/tests/uefi-test-tools/build.sh
+++ b/tests/uefi-test-tools/build.sh
@@ -38,97 +38,12 @@ if [ $ret -ne 0 ]; then
   exit $ret
 fi
=20
-# Map the QEMU system emulation target to the following types of archite=
cture
-# identifiers:
-# - edk2,
-# - gcc cross-compilation.
-# Cover only those targets that are supported by the UEFI spec and edk2.
-case "$emulation_target" in
-  (arm)
-    edk2_arch=3DARM
-    gcc_arch=3Darm
-    ;;
-  (aarch64)
-    edk2_arch=3DAARCH64
-    gcc_arch=3Daarch64
-    ;;
-  (i386)
-    edk2_arch=3DIA32
-    gcc_arch=3Di686
-    ;;
-  (x86_64)
-    edk2_arch=3DX64
-    gcc_arch=3Dx86_64
-    ;;
-  (*)
-    printf '%s: unknown/unsupported QEMU system emulation target "%s"\n'=
 \
-      "$program_name" "$emulation_target" >&2
-    exit 1
-    ;;
-esac
-
-# Check if cross-compilation is needed.
-host_arch=3D$(uname -m)
-if [ "$gcc_arch" =3D=3D "$host_arch" ] ||
-   ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] ); th=
en
-  cross_prefix=3D
-else
-  cross_prefix=3D${gcc_arch}-linux-gnu-
-fi
-
-# Expose cross_prefix (which is possibly empty) to the edk2 tools. While=
 at it,
-# determine the suitable edk2 toolchain as well.
-# - For ARM and AARCH64, edk2 only offers the GCC5 toolchain tag, which =
covers
-#   the gcc-5+ releases.
-# - For IA32 and X64, edk2 offers the GCC44 through GCC49 toolchain tags=
, in
-#   addition to GCC5. Unfortunately, the mapping between the toolchain t=
ags and
-#   the actual gcc releases isn't entirely trivial. Run "git-blame" on
-#   "OvmfPkg/build.sh" in edk2 for more information.
-# And, because the above is too simple, we have to assign cross_prefix t=
o an
-# edk2 build variable that is specific to both the toolchain tag and the=
 target
-# architecture.
-case "$edk2_arch" in
-  (ARM)
-    edk2_toolchain=3DGCC5
-    export GCC5_ARM_PREFIX=3D$cross_prefix
-    ;;
-  (AARCH64)
-    edk2_toolchain=3DGCC5
-    export GCC5_AARCH64_PREFIX=3D$cross_prefix
-    ;;
-  (IA32|X64)
-    gcc_version=3D$("${cross_prefix}gcc" -v 2>&1 | tail -1 | awk '{print=
 $3}')
-    case "$gcc_version" in
-      ([1-3].*|4.[0-3].*)
-        printf '%s: unsupported gcc version "%s"\n' \
-          "$program_name" "$gcc_version" >&2
-        exit 1
-        ;;
-      (4.4.*)
-        edk2_toolchain=3DGCC44
-        ;;
-      (4.5.*)
-        edk2_toolchain=3DGCC45
-        ;;
-      (4.6.*)
-        edk2_toolchain=3DGCC46
-        ;;
-      (4.7.*)
-        edk2_toolchain=3DGCC47
-        ;;
-      (4.8.*)
-        edk2_toolchain=3DGCC48
-        ;;
-      (4.9.*|6.[0-2].*)
-        edk2_toolchain=3DGCC49
-        ;;
-      (*)
-        edk2_toolchain=3DGCC5
-        ;;
-    esac
-    eval "export ${edk2_toolchain}_BIN=3D\$cross_prefix"
-    ;;
-esac
+# Fetch some option arguments, and set the cross-compilation environment=
 (if
+# any), for the edk2 "build" utility.
+source "$edk2_dir/../edk2-funcs.sh"
+edk2_arch=3D$(qemu_edk2_get_arch "$emulation_target")
+edk2_toolchain=3D$(qemu_edk2_get_toolchain "$emulation_target")
+qemu_edk2_set_cross_env "$emulation_target"
=20
 # Build the UEFI binary
 mkdir -p log
--=20
2.19.1.3.g30247aa5d201



