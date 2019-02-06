Received: from eggs.gnu.org ([209.51.188.92]:33044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1grKE0-0005NI-Pr
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1grKDz-0007aQ-TG
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1grKDz-0007Xr-KV
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:35 -0500
Date: Wed, 6 Feb 2019 11:14:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190206111419.47fb6a7a@Igors-MacBook-Pro.local>
In-Reply-To: <20190204160325.4914-1-lersek@redhat.com>
References: <20190204160325.4914-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/5] add the BiosTablesTest UEFI app,
 build it with the new roms/edk2 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Mon,  4 Feb 2019 17:03:20 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> Previous version (v2):
> http://mid.mail-archive.com/20190124203959.30875-1-lersek@redhat.com
>=20
> Updates in v3 have been noted on each patch in the series.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>

For series:

 Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>=20
> Thanks
> Laszlo
>=20
> Laszlo Ersek (5):
>   roms: add the edk2 project as a git submodule
>   roms: build the EfiRom utility from the roms/edk2 submodule
>   tests: introduce "uefi-test-tools" with the BiosTablesTest UEFI app
>   tests/uefi-test-tools: add build scripts
>   tests/data: introduce "uefi-boot-images" with the "bios-tables-test"
>     ISOs
>=20
>  .gitmodules                                                             =
 |   3 +
>  Makefile                                                                =
 |   6 +-
>  roms/Makefile                                                           =
 |  13 +-
>  roms/edk2                                                               =
 |   1 +
>  tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2          =
 | Bin 0 -> 11776 bytes
>  tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2              =
 | Bin 0 -> 11776 bytes
>  tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2             =
 | Bin 0 -> 12800 bytes
>  tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2           =
 | Bin 0 -> 13312 bytes
>  tests/uefi-test-tools/.gitignore                                        =
 |   3 +
>  tests/uefi-test-tools/LICENSE                                           =
 |  25 ++++
>  tests/uefi-test-tools/Makefile                                          =
 | 106 ++++++++++++++
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c  =
 | 130 ++++++++++++++++++
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf=
 |  41 ++++++
>  tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h    =
 |  67 +++++++++
>  tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dec             =
 |  27 ++++
>  tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc             =
 |  69 ++++++++++
>  tests/uefi-test-tools/build.sh                                          =
 | 145 ++++++++++++++++++++
>  17 files changed, 628 insertions(+), 8 deletions(-)
>  create mode 160000 roms/edk2
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.aarch64.=
iso.qcow2
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.arm.iso.=
qcow2
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.i386.iso=
.qcow2
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.x86_64.i=
so.qcow2
>  create mode 100644 tests/uefi-test-tools/.gitignore
>  create mode 100644 tests/uefi-test-tools/LICENSE
>  create mode 100644 tests/uefi-test-tools/Makefile
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest=
/BiosTablesTest.c
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest=
/BiosTablesTest.inf
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/B=
iosTablesTest.h
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsP=
kg.dec
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsP=
kg.dsc
>  create mode 100755 tests/uefi-test-tools/build.sh
>=20
