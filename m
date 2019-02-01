Received: from eggs.gnu.org ([209.51.188.92]:55930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gphEo-0004Gj-5o
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gphEk-0004ro-9r
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:24:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gphEi-0004md-4u
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:24:38 -0500
Date: Fri, 1 Feb 2019 17:24:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190201172251-mutt-send-email-mst@kernel.org>
References: <20190124203959.30875-1-lersek@redhat.com>
	<d4db23b5-8b6d-999f-d127-466a8acf040c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d4db23b5-8b6d-999f-d127-466a8acf040c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] add the BiosTablesTest UEFI app,
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
Cc: qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Thu, Jan 31, 2019 at 03:23:50PM +0100, Laszlo Ersek wrote:
> On 01/24/19 21:39, Laszlo Ersek wrote:
> > Previous version (v1):
> > http://mid.mail-archive.com/20190118223400.24311-1-lersek@redhat.com
> >=20
> > Updates in v2 have been noted on each patch in the series.
>=20
> ping

Oh sorry I noticed Philippe reported some failures with this patchset.
Can you guys pls get to the bottom of it? I don't want
everyone to suffer.

> >=20
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> >=20
> > Thanks
> > Laszlo
> >=20
> > Laszlo Ersek (5):
> >   roms: add the edk2 project as a git submodule
> >   roms: build the EfiRom utility from the roms/edk2 submodule
> >   tests: introduce "uefi-test-tools" with the BiosTablesTest UEFI app
> >   tests/uefi-test-tools: add build scripts
> >   tests/data: introduce "uefi-boot-images" with the "bios-tables-test=
"
> >     ISOs
> >=20
> >  .gitmodules                                                         =
     |   3 +
> >  Makefile                                                            =
     |   6 +-
> >  roms/Makefile                                                       =
     |  13 +-
> >  roms/edk2                                                           =
     |   1 +
> >  tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2      =
     | Bin 0 -> 11776 bytes
> >  tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2          =
     | Bin 0 -> 11776 bytes
> >  tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2         =
     | Bin 0 -> 12800 bytes
> >  tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2       =
     | Bin 0 -> 13312 bytes
> >  tests/uefi-test-tools/.gitignore                                    =
     |   3 +
> >  tests/uefi-test-tools/LICENSE                                       =
     |  25 ++++
> >  tests/uefi-test-tools/Makefile                                      =
     |  97 +++++++++++++
> >  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest=
.c   | 130 ++++++++++++++++++
> >  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest=
.inf |  41 ++++++
> >  tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h=
     |  67 +++++++++
> >  tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dec         =
     |  27 ++++
> >  tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc         =
     |  69 ++++++++++
> >  tests/uefi-test-tools/build.sh                                      =
     | 145 ++++++++++++++++++++
> >  17 files changed, 619 insertions(+), 8 deletions(-)
> >  create mode 160000 roms/edk2
> >  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.aarc=
h64.iso.qcow2
> >  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.arm.=
iso.qcow2
> >  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.i386=
.iso.qcow2
> >  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.x86_=
64.iso.qcow2
> >  create mode 100644 tests/uefi-test-tools/.gitignore
> >  create mode 100644 tests/uefi-test-tools/LICENSE
> >  create mode 100644 tests/uefi-test-tools/Makefile
> >  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/BiosTables=
Test/BiosTablesTest.c
> >  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/BiosTables=
Test/BiosTablesTest.inf
> >  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/Include/Gu=
id/BiosTablesTest.h
> >  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestTo=
olsPkg.dec
> >  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestTo=
olsPkg.dsc
> >  create mode 100755 tests/uefi-test-tools/build.sh
> >=20
