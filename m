Received: from eggs.gnu.org ([2001:4830:134:3::10]:55348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmyfT-0003Qk-BP
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fmyfQ-00072N-3t
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:52:43 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:32816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fmyfP-00070j-SK
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:52:40 -0400
Received: from player739.ha.ovh.net (unknown [10.109.159.152])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id EE0C81D3A68
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 11:52:34 +0200 (CEST)
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-2-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <881a1c50-52af-d6b7-fdc8-5b9cc69ca5a2@kaod.org>
Date: Tue, 7 Aug 2018 11:52:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180807075757.7242-2-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] aspeed_sdmc: Extend number of valid
 registers
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
> The SDMC on the ast2500 has 170 registers.


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  include/hw/misc/aspeed_sdmc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdm=
c.h
> index 551c8afdf4be..682f0f5d56dc 100644
> --- a/include/hw/misc/aspeed_sdmc.h
> +++ b/include/hw/misc/aspeed_sdmc.h
> @@ -14,7 +14,7 @@
>  #define TYPE_ASPEED_SDMC "aspeed.sdmc"
>  #define ASPEED_SDMC(obj) OBJECT_CHECK(AspeedSDMCState, (obj), TYPE_ASP=
EED_SDMC)
> =20
> -#define ASPEED_SDMC_NR_REGS (0x8 >> 2)
> +#define ASPEED_SDMC_NR_REGS (0x174 >> 2)
> =20
>  typedef struct AspeedSDMCState {
>      /*< private >*/
>=20
