Received: from eggs.gnu.org ([2001:4830:134:3::10]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmzF2-0000XE-Mj
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmzEy-0005KJ-GM
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:29:28 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:34234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fmzEy-0005Jo-7e
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:29:24 -0400
Received: from player799.ha.ovh.net (unknown [10.109.159.159])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id C6167E191E
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 12:29:22 +0200 (CEST)
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-6-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c47d59ac-c6bf-8404-020e-8dcc4c98758b@kaod.org>
Date: Tue, 7 Aug 2018 12:29:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180807075757.7242-6-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] aspeed_sdmc: Handle ECC training
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
> This is required to ensure u-boot SDRAM training completes.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/misc/aspeed_sdmc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 522e01ef8c0d..89de3138aff0 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -27,6 +27,10 @@
>  #define R_STATUS1         (0x60 / 4)
>  #define   PHY_BUSY_STATE      BIT(0)
> =20
> +#define R_ECC_TEST_CTRL   (0x70 / 4)
> +#define   ECC_TEST_FINISHED   BIT(12)
> +#define   ECC_TEST_FAIL       BIT(13)
> +
>  /*
>   * Configuration register Ox4 (for Aspeed AST2400 SOC)
>   *
> @@ -148,6 +152,11 @@ static void aspeed_sdmc_write(void *opaque, hwaddr=
 addr, uint64_t data,
>              /* Will never return 'busy' */
>              data &=3D ~PHY_BUSY_STATE;
>              break;
> +        case R_ECC_TEST_CTRL:
> +            /* Always done, always happy */
> +            data |=3D ECC_TEST_FINISHED;
> +            data &=3D ~ECC_TEST_FAIL;
> +            break;
>          default:
>              break;
>          }
>=20
