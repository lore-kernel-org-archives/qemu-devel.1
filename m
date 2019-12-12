Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA09C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466E4214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwMxC2Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466E4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPZj-0003Uf-GY
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1ifPXx-0001ci-HY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1ifPXr-00075p-PX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:34:29 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1ifPXr-000721-9t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:34:23 -0500
Received: by mail-lj1-x242.google.com with SMTP id s22so2526438ljs.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M01hRpD11CkkOeauBIVCjuItQ11kCezb4GIbMatT12c=;
 b=jwMxC2KjvVPAJJabNt2EixKGKNXDmT6INs3XC3sgyHNqZBtPmTN4Tm+tz0Ys8mMnlI
 6iXQrpWyX159Jei4YMB2xTsoD/xSMAZVmG2upOB4pQq9PG0NPT5ZVkVMoeHIMv0ALiLq
 ZqRfteFEjzauejojoUL4jnojtYaFCLrtZMLNlqiFNufQeb9yeU6XifAljnjLUYBpIRZ3
 hCe6KvmaOnpA8ZxohByGH/M3WUG0NmNop6Ept8tGjmI9oYU7NethV3yAqH8g+ORjoocp
 eKj+9MPSdmcu1QAjGxi/pYJmZ5pU1BKMgd/Xx5nJs25JpNgA5IejqQ41Bj0K/IkFut/G
 XvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M01hRpD11CkkOeauBIVCjuItQ11kCezb4GIbMatT12c=;
 b=WyPdq6YQ+4GU6huNQ22NyQjANH30lD4AwsErAoTwpz24usPtrenRqA2AOmvTzMF+2g
 /tTrO46lnwbEeYj9koOD25mQ9kIs7U1PT6C3lDO1wUKr/QERfNl0atVb2u2/4fCSW0bo
 lQXxxVZMfmZ3MKysEpNaMFAZdy+ErCvnO8WxJPIdZrnM3HSUddlRwTHRDQmXoAY0kWiz
 oV08ECUarB7M+2ZqYwij0W3TKZRk4Q/hpu9Zsd8uQSOHZ3G3DUsNZo7OXerRdnC27D4z
 TxI7NsMRtUB58PcNg7be142eZhd3iyc7ImnVB37MzFMPOKB4V95JEx0NOTPglR2Q1xi8
 fD9g==
X-Gm-Message-State: APjAAAX0VjYszv9Np9+0E6mB8n0t9eDutNypLW+32g6KfQWpKLKdHZWQ
 yovQEOdmUm9OnXd9NJvLQX8Sz0wtN2G+sKV5etoBsA==
X-Google-Smtp-Source: APXvYqwxi4IxwAztLPEIoaBKmWi+PA6mLW1szFcIPlhkAwR494Ll690WDLTixRbkmknZWP+z6eu4/b3mbO4S/MBcekg=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr6202874ljk.77.1576161261524;
 Thu, 12 Dec 2019 06:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
In-Reply-To: <20191127084253.16356-6-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2019 15:34:09 +0100
Message-ID: <CACRpkdaW7nmpE99FAvBDBTmkTZOTQ5WdM=JbMzBTLk7cbLRXPw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert!

Thanks for this interesting patch!

On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> GPIO controllers are exported to userspace using /dev/gpiochip*
> character devices.  Access control to these devices is provided by
> standard UNIX file system permissions, on an all-or-nothing basis:
> either a GPIO controller is accessible for a user, or it is not.
> Currently no mechanism exists to control access to individual GPIOs.
>
> Hence add a GPIO driver to aggregate existing GPIOs, and expose them as
> a new gpiochip.
>
> This supports the following use cases:
>   1. Aggregating GPIOs using Sysfs
>      This is useful for implementing access control, and assigning a set
>      of GPIOs to a specific user or virtual machine.
>
>   2. GPIO Repeater in Device Tree
>      This supports modelling e.g. GPIO inverters in DT.
>
>   3. Generic GPIO Driver
>      This provides userspace access to a simple GPIO-operated device
>      described in DT, cfr. e.g. spidev for SPI-operated devices.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Overall I like how this is developing!

> +config GPIO_AGGREGATOR
> +       tristate "GPIO Aggregator/Repeater"
> +       help
> +         Say yes here to enable the GPIO Aggregator and repeater, which
> +         provides a way to aggregate and/or repeat existing GPIOs into a new
> +         GPIO device.

Should it say a "new virtual GPIO chip"?

> +         This can serve the following purposes:
> +           1. Assign a collection of GPIOs to a user, or export them to a
> +              virtual machine,

This is ambiguous. What is a "user"? A process calling from
userspace? A device tree node?

I would write "assign a collection of GPIO lines from any lines on
existing physical GPIO chips to form a new virtual GPIO chip"

That should be to the point, right?

> +           2. Support GPIOs that are connected to a physical inverter,

s/to/through/g

> +           3. Provide a generic driver for a GPIO-operated device, to be
> +               controlled from userspace using the GPIO chardev interface.

I don't understand this, it needs to be elaborated. What is meant
by a "GPIO-operated device" in this context? Example?

I consistently use the term "GPIO line" as opposed to "GPIO"
or "GPIO number" etc that are abigous, so please rephrase using
"GPIO lines" rather than just "GPIOs" above.

> +#include "gpiolib.h"

Whenever this is included in a driver I want it to come with a comment
explicitly stating exactly why and which internal symbols the driver
needs to access. Ideally all drivers should just need <linux/gpio/driver.h>...

> +static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *label,
> +                        int hwnum, unsigned int *n)

u16 hwnum for the hardware number but if it is always -1/U16_MAX
then why pass the parameter at all.

Is "label" the right name of this parameter if that is going to actually
be line_name then use that.

> +{
> +       struct gpiod_lookup_table *lookups;
> +
> +       lookups = krealloc(aggr->lookups, struct_size(lookups, table, *n + 2),
> +                          GFP_KERNEL);
> +       if (!lookups)
> +               return -ENOMEM;
> +
> +       lookups->table[*n].chip_label = label;

This is pending the discussion on whether to just use "key" for this
name.

> +       lookups->table[*n].chip_hwnum = hwnum;

If this is always going to be U16_MAX (-1 in the current code)
then it can just be assigned as that here instead of passed as
parameter.

> +static int aggr_parse(struct gpio_aggregator *aggr)
> +{
> +       char *name, *offsets, *first, *last, *next;
> +       unsigned int a, b, i, n = 0;
> +       char *args = aggr->args;
> +       int error;
> +
> +       for (name = get_arg(&args), offsets = get_arg(&args); name;
> +            offsets = get_arg(&args)) {
> +               if (IS_ERR(name)) {
> +                       pr_err("Cannot get GPIO specifier: %ld\n",
> +                              PTR_ERR(name));
> +                       return PTR_ERR(name);
> +               }
> +
> +               if (!isrange(offsets)) {
> +                       /* Named GPIO line */
> +                       error = aggr_add_gpio(aggr, name, -1, &n);

So the third argument woule be U16_MAX here. Or not pass
a parameter at all.

But honestly, when I look at this I don't understand why you
have to avoid so hard to use offsets for the GPIO lines on
your aggregator?

Just put a u16 ngpios in your
struct gpio_aggregator and count it up every time you
add some new offsets here and you have
offset numbers for all your GPIO lines on the aggregator
and you can just drop the patch for lookup up lines by line
names.

Is there something wrong with my reasoning here?

At the pointe later when the lines are counted from the
allocated lookups using gpiod_count() that will just figure
out this number anyways, so it is not like we don't know
it at the end of the day.

So it seems the patch to gpiolib is just to use machine
descriptor tables as a substitute for a simple counter
variable in this local struct to me.

> +static void __exit gpio_aggregator_remove_all(void)
> +{
> +       mutex_lock(&gpio_aggregator_lock);
> +       idr_for_each(&gpio_aggregator_idr, gpio_aggregator_idr_remove, NULL);
> +       idr_destroy(&gpio_aggregator_idr);
> +       mutex_unlock(&gpio_aggregator_lock);
> +}
> +
> +
> +       /*
> +        *  Common GPIO Forwarder
> +        */
> +

Nitpick: lots and weird spacing here.

> +struct gpiochip_fwd {
> +       struct gpio_chip chip;
> +       struct gpio_desc **descs;
> +       union {
> +               struct mutex mlock;     /* protects tmp[] if can_sleep */
> +               spinlock_t slock;       /* protects tmp[] if !can_sleep */
> +       };

That was a very elegant use of union!

> +static int gpio_fwd_get_multiple(struct gpio_chip *chip, unsigned long *mask,
> +                                unsigned long *bits)
> +static void gpio_fwd_set_multiple(struct gpio_chip *chip, unsigned long *mask,
> +                                 unsigned long *bits)

I guess these can both be optimized to use get/set_multiple on
the target chip if the offsets are consecutive?

However that is going to be tricky so I'm not saying you should
implement that. So for now, let's say just add a TODO: comment
about it.

> +static int gpio_fwd_init_valid_mask(struct gpio_chip *chip,
> +                                   unsigned long *valid_mask,
> +                                   unsigned int ngpios)
> +{
> +       struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
> +       unsigned int i;
> +
> +       for (i = 0; i < ngpios; i++) {
> +               if (!gpiochip_line_is_valid(fwd->descs[i]->gdev->chip,
> +                                           gpio_chip_hwgpio(fwd->descs[i])))
> +                       clear_bit(i, valid_mask);
> +       }

This is what uses "gpiolib.h" is it not?

devm_gpiod_get_index() will not succeed if the line
is not valid so I think this can be just dropped, since
what you do before this is exactly devm_gpiod_get_index()
on each line, then you call gpiochip_fwd_create()
with the result.

So I think you can just drop this entire function.
This will not happen.

If it does happen, add a comment above this loop
explaining which circumstances would make lines on
the forwarder invalid.

> +       for (i = 0; i < ngpios; i++) {
> +               dev_dbg(dev, "gpio %u => gpio-%d (%s)\n", i,
> +                       desc_to_gpio(descs[i]), descs[i]->label ? : "?");
> +
> +               if (gpiod_cansleep(descs[i]))
> +                       chip->can_sleep = true;
> +               if (descs[i]->gdev->chip->set_config)
> +                       chip->set_config = gpio_fwd_set_config;
> +               if (descs[i]->gdev->chip->init_valid_mask)
> +                       chip->init_valid_mask = gpio_fwd_init_valid_mask;
> +       }

I do not think you should need to inspect the init_valid_mask()
as explained above.

Add a comment above the loop that if any of the GPIO lines
are sleeping then the entire forwarder will be sleeping
and if any of the chips support .set_config() we will support
setting configs.

However the way that the .gpio_fwd_set_config() is coded
it looks like you can just unconditionally assign it and
only check the cansleep condition in this loop.

> +}
> +
> +
> +       /*
> +        *  Common GPIO Aggregator/Repeater platform device
> +        */
> +

Nitpick: weird and excess spacing again.

> +       for (i = 0; i < n; i++) {
> +               descs[i] = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
> +               if (IS_ERR(descs[i]))
> +                       return PTR_ERR(descs[i]);
> +       }

If this succeeds none of the obtained gpio_desc:s can be
invalid.

Yours,
Linus Walleij

