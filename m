Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657C3207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657C3207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4bY-0001jW-L5
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jw4am-0001BU-BX; Thu, 16 Jul 2020 10:10:32 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:42119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jw4ak-0002ec-DB; Thu, 16 Jul 2020 10:10:32 -0400
Received: by mail-oo1-f68.google.com with SMTP id y9so1197850oot.9;
 Thu, 16 Jul 2020 07:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wWt5ahbOxhvdXh73SENCOrj8jOaH1VwJmV03whzLYgE=;
 b=AKdND31/S6iqbAhsfr//eHoEZX2S+i3Ifx5gXIQwnoTnTVWchcEtmcXXRBSIN10dPn
 iSGzLYp+JZI82OZrKSBwx5kkrlkYTISZzZVl1kKfe4keCQkZoMvEdB7/TRhniB3BOEaN
 UR1LjogU1EqgdpU97jIoUQOaJQwGYkYIe8sLcg+UGOB/Uc3E8N+NAW3zaKGQNJJp5Rph
 nf6+wBngKqpqam5mFNBQJfRtZ92Sbr/0uUjOmgWee6g+3jYJcuhtOoxyRMMZFmu2hkWT
 HA4hnAQNPqxWy7ApFW2ygPXJ63TOlQbaEpVReFQ2dtWZ2ciXpv/X98jKiLcooy9e9gRl
 +DDA==
X-Gm-Message-State: AOAM532Jt+VPfEtWdCsC4PLKy0PavfkNz1vEk4gFrQBl2wigK5B8W6VU
 unTAuIWDY6IThK4ZJYJQhEzPAFTuDIXfuRFEZ9o=
X-Google-Smtp-Source: ABdhPJw8wK+W7tpnF6N131Op+T2pjdMUds/9+LliMx2aV95aWg/91xH1jsNMr0L7zwbdga4KDdhVG+97BQ8Vdx4dD+A=
X-Received: by 2002:a4a:5209:: with SMTP id d9mr4371731oob.40.1594908627931;
 Thu, 16 Jul 2020 07:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200423090118.11199-1-geert+renesas@glider.be>
 <20200423090118.11199-5-geert+renesas@glider.be>
 <520d1d07-7530-e133-af6e-a8b4615829b8@amsat.org>
 <e279f622-3af6-5073-dac0-4c452a88c32b@amsat.org>
In-Reply-To: <e279f622-3af6-5073-dac0-4c452a88c32b@amsat.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Jul 2020 16:10:16 +0200
Message-ID: <CAMuHMdU_d-Wd1G37=fUUmmoWgSwyu7M0Rjq1Kw-2H=pbo1CFNg@mail.gmail.com>
Subject: Re: [PATCH QEMU v2 4/5] ARM: PL061: Add gpiodev support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.161.68;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-oo1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:10:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Bartosz Golaszewski <bartekgola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Thu, Apr 23, 2020 at 12:08 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 4/23/20 11:33 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 4/23/20 11:01 AM, Geert Uytterhoeven wrote:
> >> Make the PL061 GPIO controller user-creatable, and allow the user to t=
ie
> >> a newly created instance to a gpiochip on the host.
> >>
> >> To create a new GPIO controller, the QEMU command line must be augment=
ed
> >> with:
> >>
> >>     -device pl061,host=3D<gpiochip>
> >>
> >> with <gpiochip> the name or label of the gpiochip on the host.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> >> --- a/hw/gpio/pl061.c
> >> +++ b/hw/gpio/pl061.c
> >> @@ -12,11 +12,14 @@
> >>  #include "hw/arm/fdt.h"
> >>  #include "hw/gpio/pl061.h"
> >>  #include "hw/irq.h"
> >> +#include "hw/qdev-properties.h"
> >>  #include "hw/sysbus.h"
> >>  #include "migration/vmstate.h"
> >> +#include "qapi/error.h"
> >>  #include "qemu/log.h"
> >>  #include "qemu/module.h"
> >>  #include "sysemu/device_tree.h"
> >> +#include "sysemu/gpiodev.h"
> >>
> >>  //#define DEBUG_PL061 1
> >>
> >> @@ -41,6 +44,9 @@ static const uint8_t pl061_id_luminary[12] =3D
> >>  typedef struct PL061State {
> >>      SysBusDevice parent_obj;
> >>
> >> +#ifdef CONFIG_GPIODEV
> >> +    char *host;
> >> +#endif
> >>      MemoryRegion iomem;
> >>      uint32_t locked;
> >>      uint32_t data;
> >> @@ -370,10 +376,39 @@ static void pl061_init(Object *obj)
> >>      qdev_init_gpio_out(dev, s->out, 8);
> >>
> >> +#ifdef CONFIG_GPIODEV
> >> +static Property pl061_properties[] =3D {
> >> +    DEFINE_PROP_STRING("host", PL061State, host),
> >> +    DEFINE_PROP_END_OF_LIST(),
> >> +};
> >> +
> >> +static void pl061_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    PL061State *s =3D PL061(dev);
> >> +
> >> +    if (!dev->opts) {
> >> +        /* Not created by user */
> >> +        return;
> >> +    }
> >> +
> >> +    if (!s->host) {
> >> +        error_setg(errp, "'host' property is required");
> >> +        return;
> >> +    }
> >> +
> >> +    qemu_gpiodev_add(dev, s->host, 8, errp);
> >> +}
> >> +#endif /* CONFIG_GPIODEV */
> >> +
> >>  static void pl061_class_init(ObjectClass *klass, void *data)
> >>  {
> >>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >>
> >> +#ifdef CONFIG_GPIODEV
> >> +    device_class_set_props(dc, pl061_properties);
> >> +    dc->realize =3D pl061_realize;
> >> +    dc->user_creatable =3D true;
> >> +#endif
> >>      dc->vmsd =3D &vmstate_pl061;
> >>      dc->reset =3D &pl061_reset;
> >>  }
> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index 292d4e7c0cef6097..182de7fb63923b38 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -875,6 +875,15 @@ SRST
> >>  ``-device isa-ipmi-bt,bmc=3Did[,ioport=3Dval][,irq=3Dval]``
> >>      Like the KCS interface, but defines a BT interface. The default p=
ort
> >>      is 0xe4 and the default interrupt is 5.
> >> +
> >> +#ifdef CONFIG_GPIODEV
> >> +``-device pl061,host=3Dgpiochip``
> >> +    Add a PL061 GPIO controller, and map its virtual GPIO lines to a =
GPIO
> >> +    controller on the host.
> >> +
> >> +    ``host=3Dgpiochip``
> >> +        The name or label of the GPIO controller on the host.
> >> +#endif
> >>  ERST
> >>
> >>  DEF("name", HAS_ARG, QEMU_OPTION_name,
> >>
> >
> > Instead of restricting this to the pl061, it would be cleaner you add a
> > GPIO_PLUGGABLE_INTERFACE (or GPIO_BINDABLE_INTERFACE or better name),
> > and have TYPE_PL061 implement it.
>
> IOW your backend should consume devices implementing this generic interfa=
ce.

Thanks for the suggestion! I had a look into implementing this.

Please pardon my QEMU illiteracy, but I fail to see how adding an
interface, and letting frontends like pl061.c implement it, will help:
  - The backend never has to call directly into the frontend: all
    communication is done indirectly, using existing core qemu irq and
    qdev gpio calls.
  - The frontend has to call into the backend once, at initialization
    time, to pass the host=3D parameter, and the number of GPIOs supported
    by the frontend (through qemu_gpiodev_add()).
  - Generalizing host=3D parsing in the backend would be nice, to avoid
    duplicating this in each and every frontend, but AFAIU, an interface
    cannot use device_class_set_props(), as InterfaceClass is not
    derived from DeviceClass.

Note that when adding more features later (input support, and e.g.
pull-up/down support), the frontend will have to call into the backend
to change GPIO line configuration at runtime, but this is from frontend
to backend again, not the other way around.

I do agree that if we ever want to support multiple backends,
implementing that through an interface (for the backend, not for the
frontend) would be needed.

What am I missing?
Thanks again!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

