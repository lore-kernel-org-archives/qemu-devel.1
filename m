Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD729C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 07:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18FD21734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 07:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18FD21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itntu-0002FH-ES
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 02:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1itnsl-0000qm-9j
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1itnsh-0000W2-Mj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:23:27 -0500
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:44909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1itnsh-0000Ug-H4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 02:23:23 -0500
Received: from player746.ha.ovh.net (unknown [10.109.146.53])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 06E3823BE7D
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:23:20 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id AC47BE84629E;
 Tue, 21 Jan 2020 07:23:15 +0000 (UTC)
Subject: Re: [PATCH 1/2] aspeed/scu: Create separate write callbacks
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20200121013302.43839-1-joel@jms.id.au>
 <20200121013302.43839-2-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c432eaaf-7b7d-90e6-1c3a-1bfdf764f7bf@kaod.org>
Date: Tue, 21 Jan 2020 08:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121013302.43839-2-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12026862808659233600
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudejgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejgeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.44.175
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
> This splits the common write callback into separate ast2400 and ast2500
> implementations. This makes it clearer when implementing differing
> behaviour.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/misc/aspeed_scu.c | 80 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 57 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index f62fa25e3474..7108cad8c6a7 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -232,8 +232,47 @@ static uint64_t aspeed_scu_read(void *opaque, hwad=
dr offset, unsigned size)
>      return s->regs[reg];
>  }
> =20
> -static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t dat=
a,
> -                             unsigned size)
> +static void aspeed_ast2400_scu_write(void *opaque, hwaddr offset,
> +                                     uint64_t data, unsigned size)
> +{
> +    AspeedSCUState *s =3D ASPEED_SCU(opaque);
> +    int reg =3D TO_REG(offset);
> +
> +    if (reg >=3D ASPEED_SCU_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_P=
RIx "\n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    if (reg > PROT_KEY && reg < CPU2_BASE_SEG1 &&
> +            !s->regs[PROT_KEY]) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func_=
_);
> +    }
> +
> +    trace_aspeed_scu_write(offset, size, data);
> +
> +    switch (reg) {
> +    case PROT_KEY:
> +        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
> +        return;
> +    case SILICON_REV:
> +    case FREQ_CNTR_EVAL:
> +    case VGA_SCRATCH1 ... VGA_SCRATCH8:
> +    case RNG_DATA:
> +    case FREE_CNTR4:
> +    case FREE_CNTR4_EXT:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Write to read-only offset 0x%" HWADDR_PRIx =
"\n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    s->regs[reg] =3D data;
> +}
> +
> +static void aspeed_ast2500_scu_write(void *opaque, hwaddr offset,
> +                                     uint64_t data, unsigned size)
>  {
>      AspeedSCUState *s =3D ASPEED_SCU(opaque);
>      int reg =3D TO_REG(offset);
> @@ -257,25 +296,11 @@ static void aspeed_scu_write(void *opaque, hwaddr=
 offset, uint64_t data,
>      case PROT_KEY:
>          s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
>          return;
> -    case CLK_SEL:
> -        s->regs[reg] =3D data;
> -        break;
>      case HW_STRAP1:
> -        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
> -            s->regs[HW_STRAP1] |=3D data;
> -            return;
> -        }
> -        /* Jump to assignment below */
> -        break;
> +        s->regs[HW_STRAP1] |=3D data;
> +        return;
>      case SILICON_REV:
> -        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
> -            s->regs[HW_STRAP1] &=3D ~data;
> -        } else {
> -            qemu_log_mask(LOG_GUEST_ERROR,
> -                          "%s: Write to read-only offset 0x%" HWADDR_P=
RIx "\n",
> -                          __func__, offset);
> -        }
> -        /* Avoid assignment below, we've handled everything */
> +        s->regs[HW_STRAP1] &=3D ~data;
>          return;
>      case FREQ_CNTR_EVAL:
>      case VGA_SCRATCH1 ... VGA_SCRATCH8:
> @@ -291,9 +316,18 @@ static void aspeed_scu_write(void *opaque, hwaddr =
offset, uint64_t data,
>      s->regs[reg] =3D data;
>  }
> =20
> -static const MemoryRegionOps aspeed_scu_ops =3D {
> +static const MemoryRegionOps aspeed_ast2400_scu_ops =3D {
> +    .read =3D aspeed_scu_read,
> +    .write =3D aspeed_ast2400_scu_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +    .valid.unaligned =3D false,
> +};
> +
> +static const MemoryRegionOps aspeed_ast2500_scu_ops =3D {
>      .read =3D aspeed_scu_read,
> -    .write =3D aspeed_scu_write,
> +    .write =3D aspeed_ast2500_scu_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid.min_access_size =3D 4,
>      .valid.max_access_size =3D 4,
> @@ -469,7 +503,7 @@ static void aspeed_2400_scu_class_init(ObjectClass =
*klass, void *data)
>      asc->calc_hpll =3D aspeed_2400_scu_calc_hpll;
>      asc->apb_divider =3D 2;
>      asc->nr_regs =3D ASPEED_SCU_NR_REGS;
> -    asc->ops =3D &aspeed_scu_ops;
> +    asc->ops =3D &aspeed_ast2400_scu_ops;
>  }
> =20
>  static const TypeInfo aspeed_2400_scu_info =3D {
> @@ -489,7 +523,7 @@ static void aspeed_2500_scu_class_init(ObjectClass =
*klass, void *data)
>      asc->calc_hpll =3D aspeed_2500_scu_calc_hpll;
>      asc->apb_divider =3D 4;
>      asc->nr_regs =3D ASPEED_SCU_NR_REGS;
> -    asc->ops =3D &aspeed_scu_ops;
> +    asc->ops =3D &aspeed_ast2500_scu_ops;
>  }
> =20
>  static const TypeInfo aspeed_2500_scu_info =3D {
>=20


