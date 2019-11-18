Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8B8C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CE92230E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CE92230E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWmyg-0004Gd-LE
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 14:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWmxz-0003mA-2e
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWmxx-00083D-FN
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:45:42 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:59081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWmxx-000827-6c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:45:41 -0500
Received: from player735.ha.ovh.net (unknown [10.108.42.23])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id BEE1011C6F6
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 20:45:38 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id CCC5FC2EF546;
 Mon, 18 Nov 2019 19:45:31 +0000 (UTC)
Date: Mon, 18 Nov 2019 20:45:29 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 1/2] aspeed: change the "scu" property definition
Message-ID: <20191118204529.69fce2d2@bahia.lan>
In-Reply-To: <20191118161712.6712-2-clg@kaod.org>
References: <20191118161712.6712-1-clg@kaod.org>
 <20191118161712.6712-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17645666293978274187
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegiedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.44
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
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 17:17:11 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The Aspeed Watchdog and Timer models have a link pointing to the SCU
> controller model of the machine.
>=20
> Change the "scu" property definition so that it explicitly sets the
> pointer. The property isn't optional : not being able to set the link
> is a bug and QEMU should rather abort than exit in this case.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/arm/aspeed_ast2600.c  |  8 ++++----
>  hw/arm/aspeed_soc.c      |  8 ++++----
>  hw/timer/aspeed_timer.c  | 17 +++++++++--------
>  hw/watchdog/wdt_aspeed.c | 17 ++++++++---------
>  4 files changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 0881eb25983e..810fd7de0c06 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -146,8 +146,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
>      snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
>      sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
>                            sizeof(s->timerctrl), typename);
> -    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
> -                                   OBJECT(&s->scu), &error_abort);
> =20
>      snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
>      sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
> @@ -177,8 +175,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
>          snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
>          sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
>                                sizeof(s->wdt[i]), typename);
> -        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
> -                                       OBJECT(&s->scu), &error_abort);
>      }
> =20
>      for (i =3D 0; i < sc->macs_num; i++) {
> @@ -323,6 +319,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>                         aspeed_soc_get_irq(s, ASPEED_RTC));
> =20
>      /* Timer */
> +    object_property_set_link(OBJECT(&s->timerctrl),
> +                             OBJECT(&s->scu), "scu", &error_abort);
>      object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &e=
rr);
>      if (err) {
>          error_propagate(errp, err);
> @@ -415,6 +413,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>      for (i =3D 0; i < sc->wdts_num; i++) {
>          AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);
> =20
> +        object_property_set_link(OBJECT(&s->wdt[i]),
> +                                 OBJECT(&s->scu), "scu", &error_abort);
>          object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &=
err);
>          if (err) {
>              error_propagate(errp, err);
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index b01c97744196..a6237e594017 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -163,8 +163,6 @@ static void aspeed_soc_init(Object *obj)
>      snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
>      sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
>                            sizeof(s->timerctrl), typename);
> -    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
> -                                   OBJECT(&s->scu), &error_abort);
> =20
>      snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
>      sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
> @@ -194,8 +192,6 @@ static void aspeed_soc_init(Object *obj)
>          snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
>          sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
>                                sizeof(s->wdt[i]), typename);
> -        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
> -                                       OBJECT(&s->scu), &error_abort);
>      }
> =20
>      for (i =3D 0; i < sc->macs_num; i++) {
> @@ -291,6 +287,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
>                         aspeed_soc_get_irq(s, ASPEED_RTC));
> =20
>      /* Timer */
> +    object_property_set_link(OBJECT(&s->timerctrl),
> +                             OBJECT(&s->scu), "scu", &error_abort);
>      object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &e=
rr);
>      if (err) {
>          error_propagate(errp, err);
> @@ -376,6 +374,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
>      for (i =3D 0; i < sc->wdts_num; i++) {
>          AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);
> =20
> +        object_property_set_link(OBJECT(&s->wdt[i]),
> +                                 OBJECT(&s->scu), "scu", &error_abort);
>          object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &=
err);
>          if (err) {
>              error_propagate(errp, err);
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index bcce2192a92a..a8c38cc1189b 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -19,6 +19,7 @@
>  #include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "hw/qdev-properties.h"
>  #include "trace.h"
> =20
>  #define TIMER_NR_REGS 4
> @@ -603,15 +604,8 @@ static void aspeed_timer_realize(DeviceState *dev, E=
rror **errp)
>      int i;
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      AspeedTimerCtrlState *s =3D ASPEED_TIMER(dev);
> -    Object *obj;
> -    Error *err =3D NULL;
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
> -    if (!obj) {
> -        error_propagate_prepend(errp, err, "required link 'scu' not foun=
d: ");
> -        return;
> -    }
> -    s->scu =3D ASPEED_SCU(obj);
> +    assert(s->scu);
> =20
>      for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
>          aspeed_init_one_timer(s, i);
> @@ -677,6 +671,12 @@ static const VMStateDescription vmstate_aspeed_timer=
_state =3D {
>      }
>  };
> =20
> +static Property aspeed_timer_properties[] =3D {
> +    DEFINE_PROP_LINK("scu", AspeedTimerCtrlState, scu, TYPE_ASPEED_SCU,
> +                     AspeedSCUState *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void timer_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -685,6 +685,7 @@ static void timer_class_init(ObjectClass *klass, void=
 *data)
>      dc->reset =3D aspeed_timer_reset;
>      dc->desc =3D "ASPEED Timer";
>      dc->vmsd =3D &vmstate_aspeed_timer_state;
> +    dc->props =3D aspeed_timer_properties;
>  }
> =20
>  static const TypeInfo aspeed_timer_info =3D {
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 122aa8daaadf..f50dab922e0f 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -241,16 +241,8 @@ static void aspeed_wdt_realize(DeviceState *dev, Err=
or **errp)
>  {
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      AspeedWDTState *s =3D ASPEED_WDT(dev);
> -    Error *err =3D NULL;
> -    Object *obj;
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
> -    if (!obj) {
> -        error_propagate(errp, err);
> -        error_prepend(errp, "required link 'scu' not found: ");
> -        return;
> -    }
> -    s->scu =3D ASPEED_SCU(obj);
> +    assert(s->scu);
> =20
>      s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, aspeed_wdt_timer_expir=
ed, dev);
> =20
> @@ -264,6 +256,12 @@ static void aspeed_wdt_realize(DeviceState *dev, Err=
or **errp)
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
> =20
> +static Property aspeed_wdt_properties[] =3D {
> +    DEFINE_PROP_LINK("scu", AspeedWDTState, scu, TYPE_ASPEED_SCU,
> +                     AspeedSCUState *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -273,6 +271,7 @@ static void aspeed_wdt_class_init(ObjectClass *klass,=
 void *data)
>      dc->reset =3D aspeed_wdt_reset;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      dc->vmsd =3D &vmstate_aspeed_wdt;
> +    dc->props =3D aspeed_wdt_properties;
>  }
> =20
>  static const TypeInfo aspeed_wdt_info =3D {


