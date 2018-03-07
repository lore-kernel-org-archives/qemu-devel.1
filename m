Received: from eggs.gnu.org ([2001:4830:134:3::10]:40742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbSD-0005gS-IB
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS8-0001D7-Nh
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1etbS8-0001Cn-JQ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:04 -0500
From: marcandre.lureau@redhat.com
Date: Wed,  7 Mar 2018 16:57:46 +0100
Message-Id: <20180307155746.18526-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-1-marcandre.lureau@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 8/8] ovmf: add DxeTpm2MeasureBootLib
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

The library registers a security management handler, to measure images
that are not measure in PEI phase.

This seems to work for example with the qemu PXE rom:

Loading driver at 0x0003E6C2000 EntryPoint=3D0x0003E6C9076 8086100e.efi

And the following binary_bios_measurements log entry seems to be
added:

PCR: 2	type: EV_EFI_BOOT_SERVICES_DRIVER     	size: 0x4e	digest: 70a22475=
e9f18806d2ed9193b48d80d26779d9a4

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgX64.dsc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index 7753852144fb..9db1712e3623 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -662,6 +662,9 @@ [Components]
     <LibraryClasses>
 !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
       NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerificat=
ionLib.inf
+!endif
+!if $(TPM2_ENABLE) =3D=3D TRUE
+      NULL|SecurityPkg/Library/DxeTpm2MeasureBootLib/DxeTpm2MeasureBootL=
ib.inf
 !endif
   }
=20
--=20
2.16.2.346.g9779355e34
