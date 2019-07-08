Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD4C606A7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7232720656
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7232720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQqL-0004Tq-Fe
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 06:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1hkQou-0003u1-6b
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1hkQos-0002PS-MB
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:24:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1hkQos-0002Ox-H0
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:24:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id s184so12166110oie.9
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 03:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZH94yRQagyEtEFCXe5BGPELbKznvxiS9C2fS8RtGieU=;
 b=EvEWSvTJ4E6mhRqLbqjiKlRR1Uc3hM+rKjvtrtfeucNF9eAHl7nf0K/yd7LC5vMv04
 TsFakd7o+ki//ut43zwZLl9k9/RBA4iIS2Z2pc6eFGcATrnEOaFClcjeCT8kCtbQqwAD
 GZlzipAki8shBM911NYJNqynuaMV7DcjEsUUKbiMjl5YV+7QiiM5zD0LMe/fLkofO2dj
 xV5FUg/Qpa3mRwVtG9H+tjyLHa+t9nlUF8w9UET22+My3rBnKs0AMtNiqiTeghZwyz3m
 OiJybCEGwXl1V94lxxCr/o7/uPA3sXnOdPkS0ZLDRFVl8yK6dyTogBnv8fuvQIyAFWJU
 7eMw==
X-Gm-Message-State: APjAAAXDkKaQELHZjx9gxYpmyKJrWwkhhgvS7BBcUifXY4f8JbHyo6Km
 T5D0DmlY+CU+Wbea8lOAdQ7oPaBKEJEHK+y3azM=
X-Google-Smtp-Source: APXvYqwSYKqvIlZpX/kEBMpX3NmwEXdcEPgN/3e1aYMYlW0L0auvkQf9qdI+BIfG8hC8I/lwj/25JbA37h2UxuYXNIw=
X-Received: by 2002:aca:3bc6:: with SMTP id i189mr8740984oia.153.1562581464846; 
 Mon, 08 Jul 2019 03:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <CAMpxmJXOrDLdw6ZPBHxzsDRYiLmhRNCb-s_Z=Gu=Ecg1XA5ONQ@mail.gmail.com>
In-Reply-To: <CAMpxmJXOrDLdw6ZPBHxzsDRYiLmhRNCb-s_Z=Gu=Ecg1XA5ONQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Jul 2019 12:24:13 +0200
Message-ID: <CAMuHMdWdb0dcS8Nvk-Poz2dT7nuHjFhqpsRPZZnSKsc3VffcRA@mail.gmail.com>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.196
Subject: Re: [Qemu-devel] [PATCH RFC] gpio: Add Virtual Aggregator GPIO
 Driver
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 LKML <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-gpio <linux-gpio@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bartosz,

On Mon, Jul 8, 2019 at 11:45 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> pt., 5 lip 2019 o 18:05 Geert Uytterhoeven <geert+renesas@glider.be> napi=
sa=C5=82(a):
> > GPIO controllers are exported to userspace using /dev/gpiochip*
> > character devices.  Access control to these devices is provided by
> > standard UNIX file system permissions, on an all-or-nothing basis:
> > either a GPIO controller is accessible for a user, or it is not.
> > Currently no mechanism exists to control access to individual GPIOs.
> >
> > Hence add a virtual GPIO driver to aggregate existing GPIOs (up to 32),
> > and expose them as a new gpiochip.  This is useful for implementing
> > access control, and assigning a set of GPIOs to a specific user.
> > Furthermore, it would simplify and harden exporting GPIOs to a virtual
> > machine, as the VM can just grab the full virtual GPIO controller, and
> > no longer needs to care about which GPIOs to grab and which not,
> > reducing the attack surface.
> >
> > Virtual GPIO controllers are instantiated by writing to the "new_device=
"
> > attribute file in sysfs:
> >
> >     $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
> >            "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
> >             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
> >
> > Likewise, virtual GPIO controllers can be destroyed after use:
> >
> >     $ echo gpio-virt-agg.<N> \
> >             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> I like the general idea and the interface looks mostly fine. Since
> this is new ABI I think it needs to be documented as well.

Sure.

> I'm having trouble building this module:
>
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   Kernel: arch/arm/boot/Image is ready
>   Building modules, stage 2.
>   MODPOST 235 modules
> ERROR: "gpiod_request" [drivers/gpio/gpio-virt-agg.ko] undefined!
> ERROR: "gpiochip_get_desc" [drivers/gpio/gpio-virt-agg.ko] undefined!
> ERROR: "gpiod_free" [drivers/gpio/gpio-virt-agg.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
> Makefile:1287: recipe for target 'modules' failed
> make: *** [modules] Error 2
> make: *** Waiting for unfinished jobs....
>
> I'm not sure what the problem is.

Oops. As this is an RFC, I didn't bother trying to build this driver as
a module, only builtin.  Apparently the 3 symbols above are not yet
exported using EXPORT_SYMBOL_GPL().

> > --- /dev/null
> > +++ b/drivers/gpio/gpio-virt-agg.c
> > @@ -0,0 +1,390 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// GPIO Virtual Aggregator
> > +//
> > +// Copyright (C) 2019 Glider bvba
> > +
> > +#include <linux/gpio/driver.h>
> > +#include <linux/idr.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "gpiolib.h"
> > +
> > +#define DRV_NAME       "gpio-virt-agg"
> > +#define MAX_GPIOS      32
>
> Do we really need this limit? I see it simplifies the code, but maybe
> we can allocate the relevant arrays dynamically and not limit users?

Sure. That limit can be lifted.

> > +static int gpio_virt_agg_set_config(struct gpio_chip *chip,
> > +                                   unsigned int offset, unsigned long =
config)
> > +{
> > +       struct gpio_virt_agg_priv *priv =3D gpiochip_get_data(chip);
> > +
> > +       chip =3D priv->desc[offset]->gdev->chip;
> > +       if (chip->set_config)
> > +               return chip->set_config(chip, offset, config);
> > +
> > +       // FIXME gpiod_set_transitory() expects success if not implemen=
ted

BTW, do you have a comment about this FIXME?

> > +       return -ENOTSUPP;
> > +}

> > +static int gpio_virt_agg_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       const char *param =3D dev_get_platdata(dev);
> > +       struct gpio_virt_agg_priv *priv;
> > +       const char *label =3D NULL;
> > +       struct gpio_chip *chip;
> > +       struct gpio_desc *desc;
> > +       unsigned int offset;
> > +       int error, i;
>
> This 'i' here is reported as possibly not initialized:
>
> drivers/gpio/gpio-virt-agg.c: In function =E2=80=98gpio_virt_agg_probe=E2=
=80=99:
> drivers/gpio/gpio-virt-agg.c:230:13: warning: =E2=80=98i=E2=80=99 may be =
used
> uninitialized in this function [-Wmaybe-uninitialized]
>   int error, i;
>              ^

Oops, should be preinitialized to zero. WIll fix.

> > +static int gpio_virt_agg_remove(struct platform_device *pdev)
> > +{
> > +       struct gpio_virt_agg_priv *priv =3D platform_get_drvdata(pdev);
> > +       unsigned int i;
> > +
> > +       gpiochip_remove(&priv->chip);
> > +
> > +       for (i =3D 0; i < priv->chip.ngpio; i++)
> > +               gpiod_free(priv->desc[i]);

Perhaps I should use gpiod_put() instead, which is exported to modules?

> > +
> > +       return 0;
> > +}
>
> You shouldn't need this function at all. It's up to users to free descrip=
tors.

This frees the upstream descriptors, not the descriptors used by users
of the virtual gpiochip. Shouldn't they be freed, as they are no longer
in use?

Note that .probe() doesn't use devm_gpiochip_add_data(), as the upstream
descriptors need to be freed after the call to gpiochip_remove().

Thanks!

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

