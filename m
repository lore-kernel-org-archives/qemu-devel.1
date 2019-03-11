Received: from eggs.gnu.org ([209.51.188.92]:48116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38qx-0007hr-TE
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38qw-0003aY-27
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38qu-0003ZT-Ov
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:37 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:30:50 +0100
Message-Id: <20190311003052.13778-4-philmd@redhat.com>
In-Reply-To: <20190311003052.13778-1-philmd@redhat.com>
References: <20190311003052.13778-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/5] roms/edk2: Pass extra arguments to the
 build script via EDK2_BUILD_OPTIONS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Michal=20Pr=C3=ADvozn=C3=ADk?= <mprivozn@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The current EDK2 options produce a very verbose output.
When building the roms on Continuous Integration systems (such
Travis CI) the system limit is quickly reached.

Add an variable to optionally pass arguments to the edk2-build.sh
script.

Example of use:

  $ EDK2_BUILD_OPTIONS=3D"--quiet --silent" make -C roms efi
  ...

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile.edk2 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index 6c5e9b9eea..70f84b20df 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -44,6 +44,7 @@ submodules:
 ../pc-bios/edk2-aarch64-code.fd: submodules
 	+./edk2-build.sh \
 		aarch64 \
+		$(EDK2_BUILD_OPTIONS) \
 		--arch=3DAARCH64 \
 		--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
 		-D NETWORK_IP6_ENABLE \
@@ -55,6 +56,7 @@ submodules:
 ../pc-bios/edk2-arm-code.fd: submodules
 	+./edk2-build.sh \
 		arm \
+		$(EDK2_BUILD_OPTIONS) \
 		--arch=3DARM \
 		--platform=3DArmVirtPkg/ArmVirtQemu.dsc \
 		-D NETWORK_IP6_ENABLE \
@@ -66,6 +68,7 @@ submodules:
 ../pc-bios/edk2-i386-code.fd: submodules
 	+./edk2-build.sh \
 		i386 \
+		$(EDK2_BUILD_OPTIONS) \
 		--arch=3DIA32 \
 		--platform=3DOvmfPkg/OvmfPkgIa32.dsc \
 		-D NETWORK_IP6_ENABLE \
@@ -78,6 +81,7 @@ submodules:
 ../pc-bios/edk2-i386-secure-code.fd: submodules
 	+./edk2-build.sh \
 		i386 \
+		$(EDK2_BUILD_OPTIONS) \
 		--arch=3DIA32 \
 		--platform=3DOvmfPkg/OvmfPkgIa32.dsc \
 		-D NETWORK_IP6_ENABLE \
@@ -92,6 +96,7 @@ submodules:
 ../pc-bios/edk2-x86_64-code.fd: submodules
 	+./edk2-build.sh \
 		x86_64 \
+		$(EDK2_BUILD_OPTIONS) \
 		--arch=3DX64 \
 		--platform=3DOvmfPkg/OvmfPkgX64.dsc \
 		-D NETWORK_IP6_ENABLE \
@@ -104,6 +109,7 @@ submodules:
 ../pc-bios/edk2-x86_64-secure-code.fd: submodules
 	+./edk2-build.sh \
 		x86_64 \
+		$(EDK2_BUILD_OPTIONS) \
 		--arch=3DIA32 \
 		--arch=3DX64 \
 		--platform=3DOvmfPkg/OvmfPkgIa32X64.dsc \
--=20
2.20.1
