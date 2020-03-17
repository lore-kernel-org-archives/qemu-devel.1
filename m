Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FFBC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FB620658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FB620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9qe-0003vq-ME
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jE9nr-0008B5-BQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jE9no-0002AC-85
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:50:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jE9no-00024q-0p
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:50:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id x26so4090836otk.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4RHKUQaqLP0RIgfBpLL5qOEOQG1NeX+nzzByYvELZmw=;
 b=WBlJyjGd4mrhciKcnGhOQ5qvYMXCEhcmgfhZ8Dq1mOSLS13FnVY3SnlL3E3rfpaOUV
 v5hxZ2DuQa2cgnD/QuTf8pLrRUqSyRdwbeYFsr91AOadc9fbT2QRecpk1Nm4iYn9P7Ql
 1iaReXimBIPdbl/RFXWdqOJ6tevRd53JptItCkkeloGXaMo04aXL4nAq4pSxX/2mih9G
 Sa+ObVaGYWHp26dIfqoU4uaDiWsEWKvdURbEcPIalsSyZSq1WokIwEuBSso7iWZqRctj
 uxSos2pLcC9Gh06YSidJQu7B0Bjot8UV4SeXk5UYUCuz5B16OICoESqZ5GR+iZOJ+s7p
 VuHA==
X-Gm-Message-State: ANhLgQ2bK1paYPhoV+jm1aYW6+x8EPHXhp7RSEcAkx2WsHz1/6rj+8OZ
 xL2qaoGMxi3ulXaSUO3a7oEpASeIcPL53HkOKPM=
X-Google-Smtp-Source: ADFU+vvCnj5TM9jDoklN6SW2pOqgA8Yhy1UV90pkEYu70e2sIcYjz1ttaGrq9DI81fCb/fZk6X299+gFRk0K7Dbjlgs=
X-Received: by 2002:a9d:4d02:: with SMTP id n2mr2946810otf.107.1584442226939; 
 Tue, 17 Mar 2020 03:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-4-geert+renesas@glider.be>
 <CACRpkdacAaw4PJp3Oa569JJTHTB4HjP-hPqZLmdFcuxvdvwBHg@mail.gmail.com>
In-Reply-To: <CACRpkdacAaw4PJp3Oa569JJTHTB4HjP-hPqZLmdFcuxvdvwBHg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2020 11:50:15 +0100
Message-ID: <CAMuHMdVnoZ8uki9Ur-E-pDe60U_d=hNs8GTkMoTU3kACwFeY=g@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpio: Add GPIO Aggregator
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Linus,

On Thu, Mar 12, 2020 at 3:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> thanks for your patience and again sorry for procrastination on my part :(
>
> Overall I start to like this driver a lot. It has come a long way.
>
> Some comments below are nitpicky, bear with me if they seem stupid.

Thanks a lot for your comments!

> On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > +#define DRV_NAME       "gpio-aggregator"
> > +#define pr_fmt(fmt)    DRV_NAME ": " fmt
>
> I would just use dev_[info|err] for all messages to get rid of this.

See below.

> > +#include <linux/bitmap.h>
> > +#include <linux/bitops.h>
> > +#include <linux/ctype.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/gpio/machine.h>
> > +#include <linux/idr.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/overflow.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/string.h>
> > +
> > +#include "gpiolib.h"
>
> When this file is includes I prefer if there is a comment next to
> this include saying why we have to touch internals and which
> ones.

I have just discovered gpiod_to_chip(), which removes the need for two
of the three users ;-)

> > +struct gpio_aggregator {
> > +       struct gpiod_lookup_table *lookups;
> > +       struct platform_device *pdev;
>
> What about just storing struct device *dev?
>
> Then callbacks can just
>
> dev_err(aggregator->dev, "myerror\n");

&aggr->pdev.dev or aggr->dev does't make much of a difference.

> > +static char *get_arg(char **args)
> > +{
> > +       char *start = *args, *end;
> > +
> > +       start = skip_spaces(start);
> > +       if (!*start)
> > +               return NULL;
> > +
> > +       if (*start == '"') {
> > +               /* Quoted arg */
> > +               end = strchr(++start, '"');
> > +               if (!end)
> > +                       return ERR_PTR(-EINVAL);
> > +       } else {
> > +               /* Unquoted arg */
> > +               for (end = start; *end && !isspace(*end); end++) ;
> > +       }
> > +
> > +       if (*end)
> > +               *end++ = '\0';
> > +
> > +       *args = end;
> > +       return start;
> > +}
>
> Isn't this function reimplementing strsep()?
> while ((s = strsep(&p, " \""))) {
> or something.
>
> I'm not the best with strings, just asking so I know you tried it
> already.

strsep(&p, " \"") would terminate the token if a space or double quote is
seen.  I.e. it wouldn't handle spaces in quoted arguments.
There's also argv_split(), but that doesn't handle quoted args, and
duplicates all arguments.

Line names assigned by "gpio-lines-names" may contain spaces, so support
for quoted args is mandatory.

> > +static int aggr_parse(struct gpio_aggregator *aggr)
> > +{
> > +       unsigned int first_index, last_index, i, n = 0;
> > +       char *name, *offsets, *first, *last, *next;
> > +       char *args = aggr->args;
> > +       int error;
> > +
> > +       for (name = get_arg(&args), offsets = get_arg(&args); name;
> > +            offsets = get_arg(&args)) {
> > +               if (IS_ERR(name)) {
> > +                       pr_err("Cannot get GPIO specifier: %pe\n", name);
>
> If gpio_aggregrator contained struct device *dev this would be
> dev_err(aggr->dev, "...\n");

aggr_parse() is called before the platform device is created, and before
aggr->pdev is populated.  So there is no device to print yet.

> > +static void gpio_aggregator_free(struct gpio_aggregator *aggr)
> > +{
> > +       platform_device_unregister(aggr->pdev);
>
> Aha maybe store both the pdev and the dev in the struct then?
>
> Or print using &aggr->pdev.dev.

Same for aggr->pdev.dev (or aggr->dev).

> > +       /*
> > +        * If any of the GPIO lines are sleeping, then the entire forwarder
> > +        * will be sleeping.
> > +        * If any of the chips support .set_config(), then the forwarder will
> > +        * support setting configs.
> > +        */
> > +       for (i = 0; i < ngpios; i++) {
> > +               dev_dbg(dev, "gpio %u => gpio-%d (%s)\n", i,
> > +                       desc_to_gpio(descs[i]), descs[i]->label ? : "?");
>
> If this desc->label business is why you need to include
> "gpiolib.h" then I'd prefer if you just add a

It was the third reason to include that file...

> const char *gpiod_get_producer_name(struct gpio_desc *desc);
>
> to gpiolib (add in <linux/gpio/consumer.h> so that gpiolib can
> try to give you something reasonable to print for the label here.
> I ran into that problem before (wanting to print something like this)
> and usually just printed the offset.
>
> But if it is a serious debug issue, let's fix a helper for this.
>
> gpiod_get_producer_name() could return the thing in
> desc->label if that is set or else something along
> "chipname-offset" or "unknown", I'm not very picky
> with that.

I will just remove the printing of the label, as it is no longer useful.
Since I started using gpiod_lookup, the descriptor has already been
requested at this point, which means its label will usually be
"gpio-aggregator.N", i.e. it doesn't provide any help.
The only exception is for a GPIO line which has an associated line name
through "gpio-line-names" in DT.  But just seeing the global GPIO number
should be good enough for debugging.

BTW, one day you may want to have your our printk() format specifier for
GPIOs?  Oh, no "%pg" and "%pG" are already taken; "%pp" is still
available.

> > error = aggr_add_gpio(aggr, name, U16_MAX, &n);
>
> Is the reason why you use e.g. "gpiochip0" as name here that this
> is a simple ABI for userspace?

"name" is not the "gpiochipN" name here, but the line name, cfr. the
U16_MAX value for chip index, and the comment just above:

+                       /* Named GPIO line */

That one is supposed to be stable, right?
Note that this is the most use-centric way to refer to a GPIO.

In the other caller:

+                               error = aggr_add_gpio(aggr, name, i, &n);

"name" is a reference to the gpiochip, i.e. either its label, or the
"gpiochipN" name.

> Such like obtained from /sys/bus/gpio/devices/<chipname>?
>
> I would actually prefer to just add a sysfs attribute
> such as "name" and set it to the value of gpiochip->label.

Makes sense, but that would be a separate, unrelated patch, right?

> These labels are compulsory and supposed to be unique.
>
> Then whatever creates an aggregator can just use
> cat /sys/bus/gpio/devices/gpiochipN/name to send in
> through the sysfs interface to this kernel driver.
>
> This will protect you in the following way:
>
> When a system is booted and populated the N in
> gpiochipN is not stable and this aggregator will be used
> by scripts that assume it is. We already had this dilemma
> with things like network interfaces like eth0/1.
>
> This can be because of things like probe order which
> can be random, or because someone compiled a
> kernel with a new driver for a gpiochip that wasn't
> detected before. This recently happened to Raspberry Pi,
> that added gpio driver for "firmware GPIOs" (IIRC).
>
> The label on the chip is going to be more stable
> I think, so it is better to use that.

OK, so support for "gpiochipN" matching can be dropped, obsoleting
"[PATCH v5 1/5] gpiolib: Add support for gpiochipN-based table lookup".

Note that I added support for that in response to Bartosz' first try
https://lore.kernel.org/linux-gpio/CAMpxmJUF1s1zyXVtoUGfbV7Yk+heua4rNjY=DrX=jr-v8UfNxA@mail.gmail.com/

> This should also rid the need to include "gpiolib.h"
> which makes me nervous.

Consider it done!
Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

