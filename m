Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1587EC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 08:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9052089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 08:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9052089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heF45-0006xm-FB
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 04:38:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1heEzJ-0004Ba-JK
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1heErH-0003RS-AT
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:25:20 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:47291)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1heErH-0003P5-4y
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:25:19 -0400
Received: from player750.ha.ovh.net (unknown [10.109.146.106])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 031DD10DCDD
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 10:25:12 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id 573FA7309928;
 Fri, 21 Jun 2019 08:25:06 +0000 (UTC)
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20190621065242.32535-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6aec047c-81bd-e179-6fad-4bee896ea7a2@kaod.org>
Date: Fri, 21 Jun 2019 10:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621065242.32535-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10693515840636816192
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtdeigddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.34.219
Subject: Re: [Qemu-devel] [PATCH v2] aspeed: Link SCU to the watchdog
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

On 21/06/2019 08:52, Joel Stanley wrote:
> The ast2500 uses the watchdog to reset the SDRAM controller. This
> operation is usually performed by u-boot's memory training procedure,
> and it is enabled by setting a bit in the SCU and then causing the
> watchdog to expire. Therefore, we need the watchdog to be able to
> access the SCU's register space.
>=20
> This causes the watchdog to not perform a system reset when the bit is
> set. In the future it could perform a reset of the SDMC model.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

I was keeping this patch in my tree (hence the Sob) hoping that
someone could find the time to study the reset question. But this=20
patch is useful as it is and I think we should merge it.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
> v2: rebase on upstream, rework commit message
> ---
>  hw/arm/aspeed_soc.c              |  2 ++
>  hw/watchdog/wdt_aspeed.c         | 20 ++++++++++++++++++++
>  include/hw/watchdog/wdt_aspeed.h |  1 +
>  3 files changed, 23 insertions(+)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index a2ea8c748449..ddd5dfacd7d6 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -155,6 +155,8 @@ static void aspeed_soc_init(Object *obj)
>                                sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
>          qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
>                                      sc->info->silicon_rev);
> +        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
> +                                       OBJECT(&s->scu), &error_abort);
>      }
> =20
>      sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 4a8409f0daf5..57fe24ae6b1f 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -44,6 +44,9 @@
> =20
>  #define WDT_RESTART_MAGIC               0x4755
> =20
> +#define SCU_RESET_CONTROL1              (0x04 / 4)
> +#define    SCU_RESET_SDRAM              BIT(0)
> +
>  static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
>  {
>      return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
> @@ -222,6 +225,13 @@ static void aspeed_wdt_timer_expired(void *dev)
>  {
>      AspeedWDTState *s =3D ASPEED_WDT(dev);
> =20
> +    /* Do not reset on SDRAM controller reset */
> +    if (s->scu->regs[SCU_RESET_CONTROL1] & SCU_RESET_SDRAM) {
> +        timer_del(s->timer);
> +        s->regs[WDT_CTRL] =3D 0;
> +        return;
> +    }
> +
>      qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
>      watchdog_perform_action();
>      timer_del(s->timer);
> @@ -233,6 +243,16 @@ static void aspeed_wdt_realize(DeviceState *dev, E=
rror **errp)
>  {
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      AspeedWDTState *s =3D ASPEED_WDT(dev);
> +    Error *err =3D NULL;
> +    Object *obj;
> +
> +    obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
> +    if (!obj) {
> +        error_propagate(errp, err);
> +        error_prepend(errp, "required link 'scu' not found: ");
> +        return;
> +    }
> +    s->scu =3D ASPEED_SCU(obj);
> =20
>      if (!is_supported_silicon_rev(s->silicon_rev)) {
>          error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
> diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt=
_aspeed.h
> index 88d8be4f78d6..daef0c0e230b 100644
> --- a/include/hw/watchdog/wdt_aspeed.h
> +++ b/include/hw/watchdog/wdt_aspeed.h
> @@ -27,6 +27,7 @@ typedef struct AspeedWDTState {
>      MemoryRegion iomem;
>      uint32_t regs[ASPEED_WDT_REGS_MAX];
> =20
> +    AspeedSCUState *scu;
>      uint32_t pclk_freq;
>      uint32_t silicon_rev;
>      uint32_t ext_pulse_width_mask;
>=20


