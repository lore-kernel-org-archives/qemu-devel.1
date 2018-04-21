Received: from eggs.gnu.org ([2001:4830:134:3::10]:53187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9oUP-0001a6-0F
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9oUL-0003Ly-TK
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:07:24 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:35199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f9oUL-0003Ks-Kx
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:07:21 -0400
Received: from player796.ha.ovh.net (unknown [10.109.108.70])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 23B15F040B
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 11:07:20 +0200 (CEST)
References: <20180420124835.7268-1-peter.maydell@linaro.org>
	<20180420124835.7268-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f80b3748-12d4-de8b-1661-e07a7d33b60a@kaod.org>
Date: Sat, 21 Apr 2018 11:07:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180420124835.7268-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/aspeed: don't make 'boot_rom'
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Rob Herring <robh@kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 04/20/2018 02:48 PM, Peter Maydell wrote:
> Currently we use memory_region_init_ram_nomigrate() to create
> the "aspeed.boot_rom" memory region, and we don't manually
> register it with vmstate_register_ram(). This currently
> means that its contents are migrated but as a ram block
> whose name is the empty string; in future it may mean they
> are not migrated at all. Use memory_region_init_ram() instead.
>=20
> Note that this is a cross-version migration compatibility break
> for the "palmetto-bmc", "ast2500-evb" and "romulus-bmc" machines.

Migration does not work for these.=20

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

On palmetto, romulus and ast2500-evb boards=20

Thanks

C.

> ---
>  hw/arm/aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 7088c907bd..aecb3c1e75 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -225,7 +225,7 @@ static void aspeed_board_init(MachineState *machine=
,
>           * SoC and 128MB for the AST2500 SoC, which is twice as big as
>           * needed by the flash modules of the Aspeed machines.
>           */
> -        memory_region_init_rom_nomigrate(boot_rom, OBJECT(bmc), "aspee=
d.boot_rom",
> +        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom=
",
>                                 fl->size, &error_abort);
>          memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR=
,
>                                      boot_rom);
>=20
