Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA739C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC9A206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC9A206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUQtX-0007Ja-6x
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 02:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iUQs4-000607-QW
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iUQs2-0004cD-Ie
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:45:52 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:47859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iUQs2-0004ZN-Cf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:45:50 -0500
Received: from player776.ha.ovh.net (unknown [10.108.54.52])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id D11F9711DB
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:45:48 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player776.ha.ovh.net (Postfix) with ESMTPSA id 56029BF536AB;
 Tue, 12 Nov 2019 07:45:43 +0000 (UTC)
Subject: Re: [PATCH 2/4] aspeed/scu: Fix W1C behavior
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>
References: <20191112064058.13275-1-joel@jms.id.au>
 <20191112064058.13275-3-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c873360c-68fb-fc89-902d-459c7f557636@kaod.org>
Date: Tue, 12 Nov 2019 08:45:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112064058.13275-3-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7146086708984253248
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddvkedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.233
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/2019 07:40, Joel Stanley wrote:
> This models the clock write one to clear registers, and fixes up some
> incorrect behavior in all of the write to clear registers.
>=20
> There was also a typo in one of the register definitions.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/misc/aspeed_scu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 717509bc5460..aac4645f8c3c 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -98,7 +98,7 @@
>  #define AST2600_CLK_STOP_CTRL     TO_REG(0x80)
>  #define AST2600_CLK_STOP_CTRL_CLR TO_REG(0x84)
>  #define AST2600_CLK_STOP_CTRL2     TO_REG(0x90)
> -#define AST2600_CLK_STOP_CTR2L_CLR TO_REG(0x94)
> +#define AST2600_CLK_STOP_CTRL2_CLR TO_REG(0x94)
>  #define AST2600_SDRAM_HANDSHAKE   TO_REG(0x100)
>  #define AST2600_HPLL_PARAM        TO_REG(0x200)
>  #define AST2600_HPLL_EXT          TO_REG(0x204)
> @@ -532,11 +532,12 @@ static uint64_t aspeed_ast2600_scu_read(void *opa=
que, hwaddr offset,
>      return s->regs[reg];
>  }
> =20
> -static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint=
64_t data,
> +static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint=
64_t data64,
>                                       unsigned size)
>  {
>      AspeedSCUState *s =3D ASPEED_SCU(opaque);
>      int reg =3D TO_REG(offset);
> +    uint32_t data =3D data64;
> =20
>      if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -563,15 +564,19 @@ static void aspeed_ast2600_scu_write(void *opaque=
, hwaddr offset, uint64_t data,
>          /* fall through */
>      case AST2600_SYS_RST_CTRL:
>      case AST2600_SYS_RST_CTRL2:
> +    case AST2600_CLK_STOP_CTRL:
> +    case AST2600_CLK_STOP_CTRL2:
>          /* W1S (Write 1 to set) registers */
>          s->regs[reg] |=3D data;
>          return;
>      case AST2600_SYS_RST_CTRL_CLR:
>      case AST2600_SYS_RST_CTRL2_CLR:
> +    case AST2600_CLK_STOP_CTRL_CLR:
> +    case AST2600_CLK_STOP_CTRL2_CLR:
>      case AST2600_HW_STRAP1_CLR:
>      case AST2600_HW_STRAP2_CLR:
>          /* W1C (Write 1 to clear) registers */
> -        s->regs[reg] &=3D ~data;
> +        s->regs[reg - 1] &=3D ~data;
>          return;
> =20
>      case AST2600_RNG_DATA:
>=20


