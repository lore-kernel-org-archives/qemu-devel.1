Received: from eggs.gnu.org ([2001:4830:134:3::10]:34919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fPpQV-0005KW-Jk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fPpQR-00034o-FG
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:21:35 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:50005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fPpQR-00033p-8a
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:21:31 -0400
Received: from player796.ha.ovh.net (unknown [10.109.105.19])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 9295217C66
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 15:21:29 +0200 (CEST)
References: <20180604110358.2821-1-peter.maydell@linaro.org>
	<20180604110358.2821-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b9ed93fd-ae57-e8e8-5976-83d180f0edc4@kaod.org>
Date: Mon, 4 Jun 2018 15:21:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180604110358.2821-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/mips/boston: don't make flash
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com

On 06/04/2018 01:03 PM, Peter Maydell wrote:
> Currently we use memory_region_init_rom_nomigrate() to create
> the "boston.flash" memory region, and we don't manually register
> it with vmstate_register_ram(). This currently means that its
> contents are migrated but as a ram block whose name is the empty
> string; in future it may mean they are not migrated at all. Use
> memory_region_init_ram() instead.
>=20
> Note that this is a a cross-version migration compatibility break
> for the "boston" machine.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/mips/boston.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 5302e5c885..1d136529ad 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -471,8 +471,7 @@ static void boston_mach_init(MachineState *machine)
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
> =20
>      flash =3D  g_new(MemoryRegion, 1);
> -    memory_region_init_rom_nomigrate(flash, NULL,
> -                                     "boston.flash", 128 * M_BYTE, &er=
r);
> +    memory_region_init_rom(flash, NULL, "boston.flash", 128 * M_BYTE, =
&err);
>      memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0)=
;
> =20
>      ddr =3D g_new(MemoryRegion, 1);
>=20
