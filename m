Received: from eggs.gnu.org ([209.51.188.92]:42811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gkciO-0004ig-Cv
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gkciN-0001lQ-EA
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:34:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gkciN-0001i6-6I
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:34:15 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 18 Jan 2019 23:33:55 +0100
Message-Id: <20190118223400.24311-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] add the BiosTablesTest UEFI app,
 build it with the new roms/edk2 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Igor's series

  [Qemu-devel] [PATCH 00/14] tests: acpi: add UEFI (ARM) testing support
  http://mid.mail-archive.com/1547566866-129386-1-git-send-email-imammedo=
@redhat.com

worked with my edk2 (guest firmware) series

  [edk2] [PATCH 0/4] OvmfPkg, ArmVirtPkg: add ACPI Test Support
  http://mid.mail-archive.com/20181125100152.25675-1-lersek@redhat.com

as long as the guest firmware was built with the necessary extra build
flag.

However, in the discussion under Igor's series, we seemed to reconsider
a standalone UEFI application for the QEMU tree to carry. This series
seeks to implement that option.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>

Thanks,
Laszlo

Laszlo Ersek (5):
  roms: add the edk2 project as a git submodule
  roms: build the EfiRom utility from the roms/edk2 submodule
  tests: introduce "uefi-test-tools" with the BiosTablesTest UEFI app
  tests/uefi-test-tools: add build scripts
  tests/data: introduce "uefi-boot-images" with the "bios-tables-test"
    ISOs

 .gitmodules                                                             =
 |   3 +
 Makefile                                                                =
 |   6 +-
 roms/Makefile                                                           =
 |  13 +-
 roms/edk2                                                               =
 |   1 +
 tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2          =
 | Bin 0 -> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2              =
 | Bin 0 -> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2             =
 | Bin 0 -> 12800 bytes
 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2           =
 | Bin 0 -> 13312 bytes
 tests/uefi-test-tools/.gitignore                                        =
 |   3 +
 tests/uefi-test-tools/LICENSE                                           =
 |  25 ++++
 tests/uefi-test-tools/Makefile                                          =
 |  92 +++++++++++++
 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c  =
 | 130 ++++++++++++++++++
 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf=
 |  41 ++++++
 tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h    =
 |  67 +++++++++
 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dec             =
 |  27 ++++
 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc             =
 |  69 ++++++++++
 tests/uefi-test-tools/build.sh                                          =
 | 145 ++++++++++++++++++++
 17 files changed, 614 insertions(+), 8 deletions(-)
 create mode 160000 roms/edk2
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.aarch64.=
iso.qcow2
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.arm.iso.=
qcow2
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.i386.iso=
.qcow2
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.x86_64.i=
so.qcow2
 create mode 100644 tests/uefi-test-tools/.gitignore
 create mode 100644 tests/uefi-test-tools/LICENSE
 create mode 100644 tests/uefi-test-tools/Makefile
 create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest=
/BiosTablesTest.c
 create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest=
/BiosTablesTest.inf
 create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/B=
iosTablesTest.h
 create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsP=
kg.dec
 create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsP=
kg.dsc
 create mode 100755 tests/uefi-test-tools/build.sh

--=20
2.19.1.3.g30247aa5d201
