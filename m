Received: from eggs.gnu.org ([2001:4830:134:3::10]:42976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1euHmD-0002MF-UB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1euHmC-0006Mn-Si
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1euHmC-0006M8-NG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:36 -0500
From: marcandre.lureau@redhat.com
Date: Fri,  9 Mar 2018 14:09:14 +0100
Message-Id: <20180309130918.734-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180309130918.734-1-marcandre.lureau@redhat.com>
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/7] OvmfPkg: simplify SecurityStubDxe.inf
 inclusion
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

SecurityStubDxe.inf should be included unconditionally.

Cc: Laszlo Ersek <lersek@redhat.com>
Contributed-under: TianoCore Contribution Agreement 1.1
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 OvmfPkg/OvmfPkgIa32.dsc    | 6 ++----
 OvmfPkg/OvmfPkgIa32X64.dsc | 6 ++----
 OvmfPkg/OvmfPkgX64.dsc     | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
index fbe0f790e431..5bd3f4f977df 100644
--- a/OvmfPkg/OvmfPkgIa32.dsc
+++ b/OvmfPkg/OvmfPkgIa32.dsc
@@ -611,14 +611,12 @@ [Components]
=20
   MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
=20
-!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
   MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
     <LibraryClasses>
+!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
       NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerificat=
ionLib.inf
-	}
-!else
-  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
 !endif
+  }
=20
   MdeModulePkg/Universal/EbcDxe/EbcDxe.inf
   PcAtChipsetPkg/8259InterruptControllerDxe/8259.inf
diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
index fb10e0b0f2e4..7dded86c4940 100644
--- a/OvmfPkg/OvmfPkgIa32X64.dsc
+++ b/OvmfPkg/OvmfPkgIa32X64.dsc
@@ -620,14 +620,12 @@ [Components.X64]
=20
   MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
=20
-!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
   MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
     <LibraryClasses>
+!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
       NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerificat=
ionLib.inf
-	}
-!else
-  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
 !endif
+  }
=20
   MdeModulePkg/Universal/EbcDxe/EbcDxe.inf
   PcAtChipsetPkg/8259InterruptControllerDxe/8259.inf
diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index a31551f5ae24..a8e89276c0b2 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -618,14 +618,12 @@ [Components]
=20
   MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
=20
-!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
   MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
     <LibraryClasses>
+!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
       NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerificat=
ionLib.inf
-	}
-!else
-  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
 !endif
+  }
=20
   MdeModulePkg/Universal/EbcDxe/EbcDxe.inf
   PcAtChipsetPkg/8259InterruptControllerDxe/8259.inf
--=20
2.16.2.346.g9779355e34
