Received: from eggs.gnu.org ([2001:4830:134:3::10]:36158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eXEtY-0001HN-9h
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eXEtT-0002xa-1L
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:25:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eXEtS-0002vk-19
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:25:50 -0500
Date: Fri, 5 Jan 2018 01:25:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180105012239-mutt-send-email-mst@kernel.org>
References: <20171229142922.31701-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171229142922.31701-1-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/16] piix4: cleanup and improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Fri, Dec 29, 2017 at 03:29:06PM +0100, Herv=E9 Poussineau wrote:
> Hi,
>=20
> This patchset is a cleanup of the PIIX4 PCI-ISA bridge. Lots of devices
> are moved from MIPS Malta board (which has a PIIX4) to PIIX4, where dev=
ices
> belong. This lets us reuse PIIX4 in other machines, while not loosing a=
ny
> functionality.
>=20
> Last patch allows adding a new PIIX4 device directly from command line.
> Note that this will work only as long no other ISA bus already exist on=
 the
> machine.
>=20
> Herv=E9

Looks ok superficially

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but really I think I'm marked as maintainer of this file for the sole
reason that it uses pc.h.

Once your patches are applied you can remove pc.h include from mips
and piix, so it's no longer pc related.

Sent a patch to move it to the mips section, pls feel free to include
in the patches.


> Changes v2 -> v3:
> - rebased on master and fixed conflicts
> - added patch 14 (convert reset function to QOM)
> - use TYPE_PIIX4_PCI_DEVICE in Malta board (patch 15, Philippe Mathieu-=
Daud=E9)
>=20
> Changes v1 -> v2:
> - fixed compilation on CentOS 6 (patch 1)
> - automatically create serial/parallel chardevs if not provided (patch =
11)
>=20
> Herv=E9 Poussineau (16):
>   fdc: move object structures to header file
>   serial/parallel: move object structures to header file
>   mc146818rtc: move structure to header file
>   mc146818rtc: always register rtc to rtc list
>   piix4: rename some variables in realize function
>   piix4: add Reset Control Register
>   piix4: add a i8259 interrupt controller as specified in datasheet
>   piix4: add a i8257 dma controller as specified in datasheet
>   piix4: add a i8254 pit controller as specified in datasheet
>   piix4: add a i8042 keyboard/mouse controller as specified in datashee=
t
>   piix4: add a floppy controller, 1 parallel port and 2 serial ports
>   piix4: add a mc146818rtc controller as specified in datasheet
>   piix4: add a speaker as specified in datasheet
>   piix4: convert reset function to QOM
>   piix4: rename PIIX4 object to piix4-isa
>   piix4: we can now instanciate a PIIX4 with -device
>=20
>  hw/block/fdc.c                 | 102 -----------------------
>  hw/char/parallel.c             |  31 +------
>  hw/char/serial-isa.c           |  13 +--
>  hw/isa/piix4.c                 | 183 +++++++++++++++++++++++++++++++++=
+++-----
>  hw/mips/mips_malta.c           |  74 +++++++----------
>  hw/ppc/pnv.c                   |   2 +-
>  hw/timer/mc146818rtc.c         |  43 ++--------
>  include/hw/block/fdc.h         | 103 +++++++++++++++++++++++
>  include/hw/char/isa.h          |  50 +++++++++++
>  include/hw/char/serial.h       |   1 -
>  include/hw/i386/pc.h           |   1 -
>  include/hw/isa/isa.h           |   3 +
>  include/hw/timer/mc146818rtc.h |  29 +++++++
>  13 files changed, 389 insertions(+), 246 deletions(-)
>  create mode 100644 include/hw/char/isa.h
>=20
> --=20
> 2.11.0
