Received: from eggs.gnu.org ([2001:4830:134:3::10]:34613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDK0-00047W-3N
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJz-0007Xt-97
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1epDJz-0007XL-3X
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:31 -0500
From: marcandre.lureau@redhat.com
Date: Fri, 23 Feb 2018 14:23:10 +0100
Message-Id: <20180223132311.26555-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180223132311.26555-1-marcandre.lureau@redhat.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/7] ovmf: link with Tcg2ConfigDxe module
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

The module allows to tweak and interact with the TPM. Note that many
actions are broken due to implementation of qemu TPM (providing it's
own ACPI table), and the lack of PPI implementation.

CC: Laszlo Ersek <lersek@redhat.com>
CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgX64.dsc | 2 ++
 OvmfPkg/OvmfPkgX64.fdf | 1 +
 2 files changed, 3 insertions(+)

diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index 9bd0709f98..2281bd5ff8 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -669,6 +669,8 @@
       NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.i=
nf
       NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha2=
56.inf
   }
+
+  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
 !endif
=20
 !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
index b8dd7ecae4..985404850f 100644
--- a/OvmfPkg/OvmfPkgX64.fdf
+++ b/OvmfPkg/OvmfPkgX64.fdf
@@ -399,6 +399,7 @@ INF  MdeModulePkg/Universal/Variable/RuntimeDxe/Varia=
bleRuntimeDxe.inf
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
 INF  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
+INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
 !endif
=20
 ########################################################################=
########
--=20
2.16.1.73.g5832b7e9f2
