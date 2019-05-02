Received: from eggs.gnu.org ([209.51.188.92]:57205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hM7pL-00063p-1O
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hM7pG-0000OU-EF
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hM7pA-0000CF-MU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:16:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 340553082E60
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 09:16:08 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
References: <20190425104326.12835-1-lersek@redhat.com>
Message-ID: <b08ac193-357f-6032-8083-45b46971500f@redhat.com>
Date: Thu, 2 May 2019 11:16:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190425104326.12835-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] tests/uefi-test-tools: report the
 SMBIOS entry point structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

Hi Igor,

On 04/25/19 12:43, Laszlo Ersek wrote:
> Repo:      https://github.com/lersek/qemu.git
> Branch:    smbios_lp_1821884
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
>=20
> In
>=20
>   [Qemu-devel] [PATCH for 4.1 v2 09/13]
>   tests: acpi: ignore SMBIOS tests when UEFI firmware is used
>=20
> at
>=20
>   http://mid.mail-archive.com/1553605799-168605-10-git-send-email-imamm=
edo@redhat.com
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07037.html
>=20
> Igor had to temporarily exclude SMBIOS unit testing with UEFI guests.
>=20
> Let the BiosTablesTest guest UEFI app report the SMBIOS entry point(s),
> so that SMBIOS unit tests can cover UEFI guests.
>=20
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
>=20
> Thanks
> Laszlo
>=20
> Laszlo Ersek (2):
>   tests/uefi-test-tools: report the SMBIOS entry point structures
>   tests/uefi-boot-images: report the SMBIOS entry point structures
>=20
>  tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h  =
   |  25 +++++++++++++++-----
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.i=
nf |   2 ++
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c=
   |  23 ++++++++++++++----
>  tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2        =
   | Bin 11776 -> 12288 bytes
>  tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2            =
   | Bin 11776 -> 11776 bytes
>  tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2           =
   | Bin 12800 -> 13312 bytes
>  tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2         =
   | Bin 13312 -> 13312 bytes
>  7 files changed, 40 insertions(+), 10 deletions(-)
>=20

can you ACK or test (or both) this series, please?

Thanks
Laszlo
