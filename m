Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0009C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D9020748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D9020748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLi2r-00018D-LD
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 02:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jLi1D-00080c-K0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jLi1C-0006G7-Cw
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:31 -0400
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:56183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jLi1C-0006F1-6g
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:30 -0400
Received: from player690.ha.ovh.net (unknown [10.108.35.232])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8C9FE1BA636
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 08:47:28 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 850AA110F0479;
 Tue,  7 Apr 2020 06:47:16 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 v2 28/54] hw/arm/aspeed: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-29-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f2b449ec-9254-4f71-eb6f-9d97e6c05ab0@kaod.org>
Date: Tue, 7 Apr 2020 08:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406174743.16956-29-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 2449958197395753904
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeggdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.158.110
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 7:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Patch created mechanically by running:
>=20
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
>     --keep-comments --smpl-spacing --in-place --dir hw
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

The 'return' are correct this time.=20

Thanks,

C.=20


> ---
>  hw/arm/aspeed_ast2600.c | 36 ++++++++++++++++++++++++++++++------
>  hw/arm/aspeed_soc.c     | 12 ++++++++++--
>  2 files changed, 40 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index c8e0171824..d810df928c 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -277,7 +277,11 @@ static void aspeed_soc_ast2600_realize(DeviceState=
 *dev, Error **errp)
>          if (s->num_cpus > 1) {
>              object_property_set_int(OBJECT(&s->cpu[i]),
>                                      ASPEED_A7MPCORE_ADDR,
> -                                    "reset-cbar", &error_abort);
> +                                    "reset-cbar", &err);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>          }
>          /*
>           * TODO: the secondary CPUs are started and a boot helper
> @@ -293,10 +297,18 @@ static void aspeed_soc_ast2600_realize(DeviceStat=
e *dev, Error **errp)
> =20
>      /* A7MPCORE */
>      object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-cp=
u",
> -                            &error_abort);
> +                            &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> =20
>      object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
> -                             &error_abort);
> +                             &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE_A=
DDR);
> =20
>      for (i =3D 0; i < s->num_cpus; i++) {
> @@ -343,7 +355,11 @@ static void aspeed_soc_ast2600_realize(DeviceState=
 *dev, Error **errp)
> =20
>      /* Timer */
>      object_property_set_link(OBJECT(&s->timerctrl),
> -                             OBJECT(&s->scu), "scu", &error_abort);
> +                             OBJECT(&s->scu), "scu", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", =
&err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -459,7 +475,11 @@ static void aspeed_soc_ast2600_realize(DeviceState=
 *dev, Error **errp)
>          AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);
> =20
>          object_property_set_link(OBJECT(&s->wdt[i]),
> -                                 OBJECT(&s->scu), "scu", &error_abort)=
;
> +                                 OBJECT(&s->scu), "scu", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",=
 &err);
>          if (err) {
>              error_propagate(errp, err);
> @@ -490,7 +510,11 @@ static void aspeed_soc_ast2600_realize(DeviceState=
 *dev, Error **errp)
>                             aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
> =20
>          object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac=
100[i]),
> -                                 "nic", &error_abort);
> +                                 "nic", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
>                                   &err);
>          if (err) {
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index aa6d739ad0..5f90215187 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -301,7 +301,11 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
> =20
>      /* Timer */
>      object_property_set_link(OBJECT(&s->timerctrl),
> -                             OBJECT(&s->scu), "scu", &error_abort);
> +                             OBJECT(&s->scu), "scu", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", =
&err);
>      if (err) {
>          error_propagate(errp, err);
> @@ -398,7 +402,11 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
>          AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);
> =20
>          object_property_set_link(OBJECT(&s->wdt[i]),
> -                                 OBJECT(&s->scu), "scu", &error_abort)=
;
> +                                 OBJECT(&s->scu), "scu", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",=
 &err);
>          if (err) {
>              error_propagate(errp, err);
>=20


