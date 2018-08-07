Received: from eggs.gnu.org ([2001:4830:134:3::10]:58936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmz0G-0002e9-LS
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmz0D-00069J-UC
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:14:12 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:36369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fmz0D-00067X-Mt
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:14:09 -0400
Received: from player773.ha.ovh.net (unknown [10.109.146.211])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id CD3B71C333C
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 12:14:07 +0200 (CEST)
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-4-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <20662f46-f6ca-1c05-e2c5-b7c80692b77d@kaod.org>
Date: Tue, 7 Aug 2018 12:13:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180807075757.7242-4-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] aspeed_sdmc: Set 'cache initial
 sequence' always true
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/07/2018 09:57 AM, Joel Stanley wrote:
> The SDRAM training routine sets the 'Enable cache initial' bit, and the=
n
> waits for the 'cache initial sequence' to be done.
>=20
> Have it always return done, as there is no other side effects that the
> model needs to implement. This allows the upstream u-boot training to
> proceed on the ast2500-evb board.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/misc/aspeed_sdmc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 24fd4aee2d82..9ece545c4ffa 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -226,6 +226,7 @@ static void aspeed_sdmc_realize(DeviceState *dev, E=
rror **errp)
>          s->ram_bits =3D ast2500_rambits(s);
>          s->fixed_conf =3D ASPEED_SDMC_HW_VERSION(1) |
>              ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
> +            ASPEED_SDMC_CACHE_INITIAL_DONE |
>              ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
>          break;
>      default:
>=20
