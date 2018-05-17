Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fJKBe-00016Y-Po
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fJKBd-0006qa-BK
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:47:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fJKBd-0006qF-4Z
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:47:21 -0400
From: marcandre.lureau@redhat.com
Date: Thu, 17 May 2018 16:47:10 +0200
Message-Id: <20180517144713.18647-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180517144713.18647-1-marcandre.lureau@redhat.com>
References: <20180517144713.18647-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] OvmfPkg: add
 Tcg2PhysicalPresenceLibNull when !TPM2_ENABLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This NULL library will let us call
Tcg2PhysicalPresenceLibProcessRequest() unconditionally from
BdsPlatform when building without TPM2_ENABLE.

Contributed-under: TianoCore Contribution Agreement 1.1
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgIa32.dsc                                                 =
                                                                         =
               |  2 ++
 OvmfPkg/OvmfPkgIa32X64.dsc                                              =
                                                                         =
               |  2 ++
 OvmfPkg/OvmfPkgX64.dsc                                                  =
                                                                         =
               |  2 ++
 OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresenceLib.i=
nf                                                                       =
               | 34 ++++++++++++++++++++
 EdkCompatibilityPkg/Foundation/Library/EdkIIGlueLib/Library/BaseLib/Ia32=
/CpuSleep.c =3D> OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2Physi=
calPresenceLib.c | 19 ++++++-----
 5 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
index 2d6c4c4615b6..6c361b73cd55 100644
--- a/OvmfPkg/OvmfPkgIa32.dsc
+++ b/OvmfPkg/OvmfPkgIa32.dsc
@@ -208,6 +208,8 @@ [LibraryClasses]
   Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
   Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceLib=
/DxeTcg2PhysicalPresenceLib.inf
   Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendorLi=
bNull.inf
+!else
+  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/Dx=
eTcg2PhysicalPresenceLib.inf
 !endif
=20
 [LibraryClasses.common]
diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
index 43158c5f0627..62a6075a671d 100644
--- a/OvmfPkg/OvmfPkgIa32X64.dsc
+++ b/OvmfPkg/OvmfPkgIa32X64.dsc
@@ -213,6 +213,8 @@ [LibraryClasses]
   Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
   Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceLib=
/DxeTcg2PhysicalPresenceLib.inf
   Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendorLi=
bNull.inf
+!else
+  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/Dx=
eTcg2PhysicalPresenceLib.inf
 !endif
=20
 [LibraryClasses.common]
diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index d1fdf7c307c2..cbab1aa328c6 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -213,6 +213,8 @@ [LibraryClasses]
   Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
   Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceLib=
/DxeTcg2PhysicalPresenceLib.inf
   Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendorLi=
bNull.inf
+!else
+  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/Dx=
eTcg2PhysicalPresenceLib.inf
 !endif
=20
 [LibraryClasses.common]
diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalP=
resenceLib.inf b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2Physi=
calPresenceLib.inf
new file mode 100644
index 000000000000..aff7baecfbe7
--- /dev/null
+++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresence=
Lib.inf
@@ -0,0 +1,34 @@
+## @file
+#  NULL Tcg2PhysicalPresenceLib library instance
+#
+#  In SecurityPkg, this library will check and execute TPM 1.2 request
+#  from OS or BIOS. The request may ask for user confirmation before
+#  execution. This Library will also lock TPM physical presence at
+#  last.
+#
+# Copyright (C) 2018, Red Hat, Inc.
+# Copyright (c) 2009 - 2015, Intel Corporation. All rights reserved.<BR>
+# This program and the accompanying materials
+# are licensed and made available under the terms and conditions of the =
BSD License
+# which accompanies this distribution. The full text of the license may =
be found at
+# http://opensource.org/licenses/bsd-license.php
+# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
+# WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR I=
MPLIED.
+#
+##
+
+[Defines]
+  INF_VERSION                    =3D 0x00010005
+  BASE_NAME                      =3D DxeTcg2PhysicalPresenceLibNull
+  FILE_GUID                      =3D 2A6BA243-DC22-42D8-9C3D-AE3728DC7AF=
A
+  MODULE_TYPE                    =3D DXE_DRIVER
+  VERSION_STRING                 =3D 1.0
+  LIBRARY_CLASS                  =3D Tcg2PhysicalPresenceLib|DXE_DRIVER =
DXE_RUNTIME_DRIVER DXE_SAL_DRIVER UEFI_APPLICATION UEFI_DRIVER
+
+[Sources]
+  DxeTcg2PhysicalPresenceLib.c
+
+[Packages]
+  MdePkg/MdePkg.dec
+  MdeModulePkg/MdeModulePkg.dec
+  SecurityPkg/SecurityPkg.dec
diff --git a/EdkCompatibilityPkg/Foundation/Library/EdkIIGlueLib/Library/=
BaseLib/Ia32/CpuSleep.c b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/Dxe=
Tcg2PhysicalPresenceLib.c
similarity index 55%
copy from EdkCompatibilityPkg/Foundation/Library/EdkIIGlueLib/Library/Bas=
eLib/Ia32/CpuSleep.c
copy to OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresen=
ceLib.c
index 3d94bd6d6fb6..340a442f223a 100644
--- a/EdkCompatibilityPkg/Foundation/Library/EdkIIGlueLib/Library/BaseLib=
/Ia32/CpuSleep.c
+++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresence=
Lib.c
@@ -1,7 +1,8 @@
-/**
-  CpuSleep function.
+/** @file
+  NULL Tcg2PhysicalPresenceLib library instance
=20
-  Copyright (c) 2006 - 2007, Intel Corporation. All rights reserved.<BR>
+  Copyright (c) 2018, Red Hat, Inc.
+  Copyright (c) 2013 - 2016, Intel Corporation. All rights reserved.<BR>
   This program and the accompanying materials
   are licensed and made available under the terms and conditions of the =
BSD License
   which accompanies this distribution.  The full text of the license may=
 be found at
@@ -12,16 +13,14 @@
=20
 **/
=20
-#include "BaseLibInternals.h"
+#include "PiDxe.h"
+#include <Library/Tcg2PhysicalPresenceLib.h>
=20
 VOID
 EFIAPI
-CpuSleep (
-  VOID
+Tcg2PhysicalPresenceLibProcessRequest (
+  IN      TPM2B_AUTH                     *PlatformAuth  OPTIONAL
   )
 {
-  _asm {
-    hlt
-  }
+  return;
 }
-
--=20
2.17.0.253.g3dd125b46d
