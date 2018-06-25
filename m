Received: from eggs.gnu.org ([2001:4830:134:3::10]:56551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXKjT-0001pG-Jp
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXKjS-0007xx-LV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:12:11 -0400
Message-Id: <1529907124.2296063.1419123552.7105E44C@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
References: <20180612065716.10587-1-clg@kaod.org>
	<20180612065716.10587-3-clg@kaod.org>
Date: Mon, 25 Jun 2018 15:42:04 +0930
In-Reply-To: <20180612065716.10587-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] aspeed/smc: fix HW strapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Tue, 12 Jun 2018, at 16:27, C=C3=A9dric Le Goater wrote:
> Only the flash type is strapped by HW. The 4BYTE mode is set by
> firmware when the flash device is detected.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  hw/ssi/aspeed_smc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index fce126e6ee92..b15370893583 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -639,23 +639,17 @@ static void aspeed_smc_reset(DeviceState *d)
>              aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
>      }
>=20=20
> -    /* HW strapping for AST2500 FMC controllers  */
> +    /* HW strapping flash type for FMC controllers  */
>      if (s->ctrl->segments =3D=3D aspeed_segments_ast2500_fmc) {
>          /* flash type is fixed to SPI for CE0 and CE1 */
>          s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0=
);
>          s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1=
);
> -
> -        /* 4BYTE mode is autodetected for CE0. Let's force it to 1 for
> -         * now */
> -        s->regs[s->r_ce_ctrl] |=3D (1 << (CTRL_EXTENDED0));
>      }
>=20=20
>      /* HW strapping for AST2400 FMC controllers (SCU70). Let's use the
>       * configuration of the palmetto-bmc machine */
>      if (s->ctrl->segments =3D=3D aspeed_segments_fmc) {
>          s->regs[s->r_conf] |=3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0=
);
> -
> -        s->regs[s->r_ce_ctrl] |=3D (1 << (CTRL_EXTENDED0));
>      }
>  }
>=20=20
> --=20
> 2.13.6
>=20
>=20
