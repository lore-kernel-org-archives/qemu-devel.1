Received: from eggs.gnu.org ([2001:4830:134:3::10]:46083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1f0jur-0005uJ-6o
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1f0jum-0008DW-Bd
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:25:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1f0jum-0008DM-70
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:25:08 -0400
Date: Tue, 27 Mar 2018 10:24:53 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180327082453.GA15484@vader>
References: <20180326153441.32641-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180326153441.32641-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Alexander Graf <agraf@suse.de>, Nageswara Sastry <nasastry@in.ibm.com>

On 26/03/2018 - 12:34:36, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> This series intend to fix: https://bugs.launchpad.net/qemu/+bug/1721224
>=20
> Patch #1 is the fix for 2.12, following patches are just refactors for =
2.13.
>=20
> The 8257 only has 4 DMA channels. To have 8 channels, the IBM PC/AT
> implementation uses 2x 8257, the second cascaded onto the first.
> The i8257_dma_init() name is misleading since this function creates two
> 8257 to register a total of 8 channels on the ISA bus.
>=20
> The refactor is to enforce that 2 controllers are used (cascaded) - no
> logical change.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (5):
>   hw/dma/i82374: Avoid double creation of the 82374 controller
>   hw/dma/i8257: Define I8257_CHANNEL_COUNT
>   hw/dma/i8257: Split i8257_dma_init() by master/slave
>   hw/dma/i8257: Rename i8257_dma_init() -> i8257_dma_init_cascaded()
>   hw/dma/i8257: Rename i8257_dma_init(false) -> i8257_dma_init_pc_at()
>=20
>  include/hw/dma/i8257.h  | 23 +++++++++++++++++++++--
>  hw/dma/i82374.c         |  9 ++++++++-
>  hw/dma/i8257.c          | 38 ++++++++++++++++++++++++++++----------
>  hw/i386/pc.c            |  2 +-
>  hw/mips/mips_fulong2e.c |  2 +-
>  hw/mips/mips_jazz.c     |  2 +-
>  hw/mips/mips_malta.c    |  2 +-
>  7 files changed, 61 insertions(+), 17 deletions(-)
>=20
> --=20
> 2.16.3
>=20
>=20
Reviewed-by: Eduardo Otubo <otubo@redhat.com>

--=20
Eduardo Otubo
