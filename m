Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DF4C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFA120715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="HQyNT+jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFA120715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpnH-0002FJ-1e
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iWpgn-000063-3r
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iWpgl-0004ub-JA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:40:09 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:36941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iWpgi-0004tD-BJ; Mon, 18 Nov 2019 17:40:04 -0500
Received: by mail-qv1-xf43.google.com with SMTP id s18so7315502qvr.4;
 Mon, 18 Nov 2019 14:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sqhRvTdW9tIzYywKH5Qy5cpb0/nS0XorlZQnNo7WIpU=;
 b=HQyNT+jgSbnSw0VF+NM6QDpJWvwOX87mzW09cLdw9uGjWPEkP5P4uN5gXBfylrBu0D
 b4AdWx6J9Kl/QfDLzu1Yl8pMUldcQrIF3PcuGyde9Lkr9C1hDaR5Og4N05ncBojyynGa
 DgoHl6GjCDwUtCwts6vdUCbBR0fTXcxk4Chik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sqhRvTdW9tIzYywKH5Qy5cpb0/nS0XorlZQnNo7WIpU=;
 b=K6HUh0plj+KMEN90FhftC84whyPi+xDKjGrkOiEmyEAB+h7BoCI9H1DdwyoK5fVhjG
 95G6G1tyJv32tKB3CdEDidItrAb/vZMas70UEyYb2Bs2TbZ9n1T4fYC2aOqTDdAu2E06
 P3Exmq5kI2PiLe4GUIwXXoVb7OzBK2ut8kY1R40QPeewrB9VaEDA+YOttO01ccpV03OB
 EWPyVI5fJx4WxAK49iOdQBvl+dVGLEUusvBHx4hH1uE8Ko/1hOcWc/XGvNFrWmI9oH7h
 EVp2sIYKLd30HgGRABEurNpvl300PPBjl4hjm5nrJVcVKAnUtI+dXwiTq6YVIeBgnYIQ
 expg==
X-Gm-Message-State: APjAAAV9iMs5OaR56Jnn2GeTAfn7mvVHe4J64jZKdSE1phgPb9EKLeOO
 m6qNtxMtOPG4iFTlzkF5b03J9ffJkz3oVBrWWRyi53PUAfE=
X-Google-Smtp-Source: APXvYqz+ASRrsobjzO8sWKpqA+7iqkmQV8H9KbPYyHYCoPlVl+aoQXEJ1efXTNPtZQ7eOYKPbDKQ0LDpdNqdesm6Zho=
X-Received: by 2002:a0c:edcc:: with SMTP id i12mr5981585qvr.20.1574116803434; 
 Mon, 18 Nov 2019 14:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20191118161712.6712-1-clg@kaod.org>
 <20191118161712.6712-2-clg@kaod.org>
In-Reply-To: <20191118161712.6712-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Nov 2019 22:39:51 +0000
Message-ID: <CACPK8XfkL5Uk_ruFri_D=Ww2Dx05Mvzza0j3QJh3H8+OmQZMDQ@mail.gmail.com>
Subject: Re: [PATCH for-5.0 1/2] aspeed: change the "scu" property definition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
 qemu-arm <qemu-arm@nongnu.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 16:17, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The Aspeed Watchdog and Timer models have a link pointing to the SCU
> controller model of the machine.
>
> Change the "scu" property definition so that it explicitly sets the
> pointer. The property isn't optional : not being able to set the link
> is a bug and QEMU should rather abort than exit in this case.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/arm/aspeed_ast2600.c  |  8 ++++----
>  hw/arm/aspeed_soc.c      |  8 ++++----
>  hw/timer/aspeed_timer.c  | 17 +++++++++--------
>  hw/watchdog/wdt_aspeed.c | 17 ++++++++---------
>  4 files changed, 25 insertions(+), 25 deletions(-)
>
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
>
>      snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
>      sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
> @@ -177,8 +175,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
>          snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
>          sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
>                                sizeof(s->wdt[i]), typename);
> -        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
> -                                       OBJECT(&s->scu), &error_abort);
>      }
>
>      for (i =3D 0; i < sc->macs_num; i++) {
> @@ -323,6 +319,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>                         aspeed_soc_get_irq(s, ASPEED_RTC));
>
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
>
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
>
>      snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
>      sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
> @@ -194,8 +192,6 @@ static void aspeed_soc_init(Object *obj)
>          snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
>          sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
>                                sizeof(s->wdt[i]), typename);
> -        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
> -                                       OBJECT(&s->scu), &error_abort);
>      }
>
>      for (i =3D 0; i < sc->macs_num; i++) {
> @@ -291,6 +287,8 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
>                         aspeed_soc_get_irq(s, ASPEED_RTC));
>
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
>
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
>
>  #define TIMER_NR_REGS 4
> @@ -603,15 +604,8 @@ static void aspeed_timer_realize(DeviceState *dev, E=
rror **errp)
>      int i;
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      AspeedTimerCtrlState *s =3D ASPEED_TIMER(dev);
> -    Object *obj;
> -    Error *err =3D NULL;
>
> -    obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
> -    if (!obj) {
> -        error_propagate_prepend(errp, err, "required link 'scu' not foun=
d: ");
> -        return;
> -    }
> -    s->scu =3D ASPEED_SCU(obj);
> +    assert(s->scu);
>
>      for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
>          aspeed_init_one_timer(s, i);
> @@ -677,6 +671,12 @@ static const VMStateDescription vmstate_aspeed_timer=
_state =3D {
>      }
>  };
>
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
>
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
>
> -    obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
> -    if (!obj) {
> -        error_propagate(errp, err);
> -        error_prepend(errp, "required link 'scu' not found: ");
> -        return;
> -    }
> -    s->scu =3D ASPEED_SCU(obj);
> +    assert(s->scu);
>
>      s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, aspeed_wdt_timer_expir=
ed, dev);
>
> @@ -264,6 +256,12 @@ static void aspeed_wdt_realize(DeviceState *dev, Err=
or **errp)
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>
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
>
>  static const TypeInfo aspeed_wdt_info =3D {
> --
> 2.21.0
>

