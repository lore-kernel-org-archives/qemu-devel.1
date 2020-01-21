Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E732FC33CB6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 07:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3C122522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 07:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3C122522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itntu-0002F5-E0
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 02:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1itnsm-0000qn-77
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1itnsi-0000Wo-O2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:23:28 -0500
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:40461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1itnsi-0000Vq-I3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:23:24 -0500
Received: from player687.ha.ovh.net (unknown [10.109.143.175])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 0AA068D3EC
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:23:23 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 57004E651A03;
 Tue, 21 Jan 2020 07:23:16 +0000 (UTC)
Subject: Re: [PATCH 2/2] aspeed/scu: Implement chip ID register
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20200121013302.43839-1-joel@jms.id.au>
 <20200121013302.43839-3-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <44b83ff5-7552-fda2-cee5-b9a7a8f0ded6@kaod.org>
Date: Tue, 21 Jan 2020 08:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121013302.43839-3-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12027425757774318400
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudejgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.51.53
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 2:33 AM, Joel Stanley wrote:
> This returns a fixed but non-zero value for the chip id.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/misc/aspeed_scu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 7108cad8c6a7..19d1780a40da 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -77,6 +77,8 @@
>  #define CPU2_BASE_SEG4       TO_REG(0x110)
>  #define CPU2_BASE_SEG5       TO_REG(0x114)
>  #define CPU2_CACHE_CTRL      TO_REG(0x118)
> +#define CHIP_ID0             TO_REG(0x150)
> +#define CHIP_ID1             TO_REG(0x154)
>  #define UART_HPLL_CLK        TO_REG(0x160)
>  #define PCIE_CTRL            TO_REG(0x180)
>  #define BMC_MMIO_CTRL        TO_REG(0x184)
> @@ -115,6 +117,8 @@
>  #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
>  #define AST2600_RNG_CTRL          TO_REG(0x524)
>  #define AST2600_RNG_DATA          TO_REG(0x540)
> +#define AST2600_CHIP_ID0          TO_REG(0x5B0)
> +#define AST2600_CHIP_ID1          TO_REG(0x5B4)
> =20
>  #define AST2600_CLK TO_REG(0x40)
> =20
> @@ -182,6 +186,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_=
NR_REGS] =3D {
>       [CPU2_BASE_SEG1]  =3D 0x80000000U,
>       [CPU2_BASE_SEG4]  =3D 0x1E600000U,
>       [CPU2_BASE_SEG5]  =3D 0xC0000000U,
> +     [CHIP_ID0]        =3D 0x1234ABCDU,
> +     [CHIP_ID1]        =3D 0x88884444U,
>       [UART_HPLL_CLK]   =3D 0x00001903U,
>       [PCIE_CTRL]       =3D 0x0000007BU,
>       [BMC_DEV_ID]      =3D 0x00002402U
> @@ -307,6 +313,8 @@ static void aspeed_ast2500_scu_write(void *opaque, =
hwaddr offset,
>      case RNG_DATA:
>      case FREE_CNTR4:
>      case FREE_CNTR4_EXT:
> +    case CHIP_ID0:
> +    case CHIP_ID1:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Write to read-only offset 0x%" HWADDR_PRIx =
"\n",
>                        __func__, offset);
> @@ -620,6 +628,8 @@ static void aspeed_ast2600_scu_write(void *opaque, =
hwaddr offset,
>      case AST2600_RNG_DATA:
>      case AST2600_SILICON_REV:
>      case AST2600_SILICON_REV2:
> +    case AST2600_CHIP_ID0:
> +    case AST2600_CHIP_ID1:
>          /* Add read only registers here */
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Write to read-only offset 0x%" HWADDR_PRIx =
"\n",
> @@ -648,6 +658,9 @@ static const uint32_t ast2600_a0_resets[ASPEED_AST2=
600_SCU_NR_REGS] =3D {
>      [AST2600_CLK_STOP_CTRL2]    =3D 0xFFF0FFF0,
>      [AST2600_SDRAM_HANDSHAKE]   =3D 0x00000040,  /* SoC completed DRAM=
 init */
>      [AST2600_HPLL_PARAM]        =3D 0x1000405F,
> +    [AST2600_CHIP_ID0]          =3D 0x1234ABCD,
> +    [AST2600_CHIP_ID1]          =3D 0x88884444,
> +
>  };
> =20
>  static void aspeed_ast2600_scu_reset(DeviceState *dev)
>=20


