Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E61DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28B1206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28B1206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUR3O-0005gK-Pl
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 02:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iUR2b-0005B7-Bm
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iUR2a-00089g-2S
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:56:45 -0500
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:56802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iUR2Z-00087G-Sp
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:56:44 -0500
Received: from player799.ha.ovh.net (unknown [10.108.57.44])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0619213DE10
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:56:41 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 7FFFCBEFD2A3;
 Tue, 12 Nov 2019 07:56:36 +0000 (UTC)
Subject: Re: [PATCH 4/4] watchdog/aspeed: Fix AST2600 frequency behaviour
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>
References: <20191112064058.13275-1-joel@jms.id.au>
 <20191112064058.13275-5-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <87e0a727-bfd5-a485-e986-e26fd4cccfef@kaod.org>
Date: Tue, 12 Nov 2019 08:56:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112064058.13275-5-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7329889868546018112
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddvkedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.39.218
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
> The AST2600 control register sneakily changed the meaning of bit 4
> without anyone noticing. It no longer controls the 1MHz vs APB clock
> select, and instead always runs at 1MHz.
>=20
> The AST2500 was always 1MHz too, but it retained bit 4, making it read
> only. We can model both using the same fixed 1MHz calculation.
>=20
> Fixes: ea29711f467f ("watchdog/aspeed: Fix AST2600 control reg behaviou=
r")

which commit is that ^ ? Did you mean :

Fixes: 6b2b2a703cad ("hw: wdt_aspeed: Add AST2600 support")

> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  hw/watchdog/wdt_aspeed.c         | 21 +++++++++++++++++----
>  include/hw/watchdog/wdt_aspeed.h |  1 +
>  2 files changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 5697ed83325a..f43a3bc88976 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -93,11 +93,11 @@ static uint64_t aspeed_wdt_read(void *opaque, hwadd=
r offset, unsigned size)
> =20
>  }
> =20
> -static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
> +static void aspeed_wdt_reload(AspeedWDTState *s)
>  {
>      uint64_t reload;
> =20
> -    if (pclk) {
> +    if (!(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK)) {
>          reload =3D muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER=
_SECOND,
>                            s->pclk_freq);
>      } else {
> @@ -109,6 +109,16 @@ static void aspeed_wdt_reload(AspeedWDTState *s, b=
ool pclk)
>      }
>  }
> =20
> +static void aspeed_wdt_reload_1mhz(AspeedWDTState *s)
> +{
> +    uint64_t reload =3D s->regs[WDT_RELOAD_VALUE] * 1000ULL;
> +
> +    if (aspeed_wdt_is_enabled(s)) {
> +        timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + re=
load);
> +    }
> +}
> +
> +
>  static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t dat=
a,
>                               unsigned size)
>  {
> @@ -130,13 +140,13 @@ static void aspeed_wdt_write(void *opaque, hwaddr=
 offset, uint64_t data,
>      case WDT_RESTART:
>          if ((data & 0xFFFF) =3D=3D WDT_RESTART_MAGIC) {
>              s->regs[WDT_STATUS] =3D s->regs[WDT_RELOAD_VALUE];
> -            aspeed_wdt_reload(s, !(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_C=
LK));
> +            awc->wdt_reload(s);
>          }
>          break;
>      case WDT_CTRL:
>          if (enable && !aspeed_wdt_is_enabled(s)) {
>              s->regs[WDT_CTRL] =3D data;
> -            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
> +            awc->wdt_reload(s);
>          } else if (!enable && aspeed_wdt_is_enabled(s)) {
>              s->regs[WDT_CTRL] =3D data;
>              timer_del(s->timer);
> @@ -283,6 +293,7 @@ static void aspeed_2400_wdt_class_init(ObjectClass =
*klass, void *data)
>      awc->offset =3D 0x20;
>      awc->ext_pulse_width_mask =3D 0xff;
>      awc->reset_ctrl_reg =3D SCU_RESET_CONTROL1;
> +    awc->wdt_reload =3D aspeed_wdt_reload;
>  }
> =20
>  static const TypeInfo aspeed_2400_wdt_info =3D {
> @@ -317,6 +328,7 @@ static void aspeed_2500_wdt_class_init(ObjectClass =
*klass, void *data)
>      awc->ext_pulse_width_mask =3D 0xfffff;
>      awc->reset_ctrl_reg =3D SCU_RESET_CONTROL1;
>      awc->reset_pulse =3D aspeed_2500_wdt_reset_pulse;
> +    awc->wdt_reload =3D aspeed_wdt_reload_1mhz;
>  }
> =20
>  static const TypeInfo aspeed_2500_wdt_info =3D {
> @@ -336,6 +348,7 @@ static void aspeed_2600_wdt_class_init(ObjectClass =
*klass, void *data)
>      awc->ext_pulse_width_mask =3D 0xfffff; /* TODO */
>      awc->reset_ctrl_reg =3D AST2600_SCU_RESET_CONTROL1;
>      awc->reset_pulse =3D aspeed_2500_wdt_reset_pulse;
> +    awc->wdt_reload =3D aspeed_wdt_reload_1mhz;
>  }
> =20
>  static const TypeInfo aspeed_2600_wdt_info =3D {
> diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt=
_aspeed.h
> index dfedd7662dd1..819c22993a6e 100644
> --- a/include/hw/watchdog/wdt_aspeed.h
> +++ b/include/hw/watchdog/wdt_aspeed.h
> @@ -47,6 +47,7 @@ typedef struct AspeedWDTClass {
>      uint32_t ext_pulse_width_mask;
>      uint32_t reset_ctrl_reg;
>      void (*reset_pulse)(AspeedWDTState *s, uint32_t property);
> +    void (*wdt_reload)(AspeedWDTState *s);
>  }  AspeedWDTClass;
> =20
>  #endif /* WDT_ASPEED_H */
>=20


