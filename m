Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E105C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE57920663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2lcmjUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE57920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPHz-0006BP-3C
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jCPHI-00059N-ER
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jCPHG-0006IK-SB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:57:40 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:38770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jCPHG-0006Gp-M6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:57:38 -0400
Received: by mail-ua1-x942.google.com with SMTP id y3so2222470uaq.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bxw33SxWFZjkWPj88ZuXOvwLRBj2S+g2ZJwa2FkjrJE=;
 b=m2lcmjUGkYWP7vkV0Vjot/cSZwZUNCcrXd/WLLuloMRr0AWoQY+jqcc/1wuUSM7DDw
 PqWzpdtoqX/gAP4yv2cKjurTp3cckazG7srtdvXHK8g76Tki8cdQXX8xelU3OB3zySg9
 0KsHSFbk9uRX8+aRa4wmtwMYAvXbuXLOv70swGxt1sVRBXSVStkyGrRkeW0hlNtS8bAC
 H/DBHSdfGZmPGLqt093ppxRWjhZFdTFTZEnGt5kqd8UjsiZIQAZuxC20LSQMDmhmwdCA
 N6uxbr+q2W5htsfi5uFGNaAIdqYa9P6ZEEPBx1gbDz0x5QKr21FtszKn/uXbNtDP0Kgm
 zboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bxw33SxWFZjkWPj88ZuXOvwLRBj2S+g2ZJwa2FkjrJE=;
 b=St4H/xEYxAzi0K5P/ay+KvK7u8JRbdq7wnR0U1S3p+X73RPF5jhJGeM9LX2jfLbpHR
 pHbjI167zgYPxUINMewHqRdzig++oQBO1GIzCJn72JIBWSQ48tv0LwICGi1mSkMs00CP
 GCK4Lz6/xd3hGuCwarq52MM0sEN0+dqOOWeJafv7h8+3kRnnBLsktqP+nnhjBAQIqqqq
 SHCbqHo14+w7ru1603ZF7kFnlVq6nX7KyAPHTrm1BRtuv8LkohcO4p14wqRhJXPI7q8J
 QqmY2uzSIL5jvS77aamBOd2SPAgkNQdcsU9U00gHVcsI6OG4bnOcWLY3iL6PvG2gFTOp
 yN5Q==
X-Gm-Message-State: ANhLgQ11RQ0UQEeuMAbdaJb9t7HCRSISVstD96/1Uakn1Qow9xw6Xlav
 qjK8S/a3WmkMw9oYWcuNK8FNi5zRIFaI/oGGAU84/g==
X-Google-Smtp-Source: ADFU+vt8Y3FRACC456zlqNPr2bqDTb34pZ4BOiYmKDy6ILZJ5KXw0GLwuYQXTML4HDWtsFJfrbuTd6Mahqifpd8BpCo=
X-Received: by 2002:ab0:2a55:: with SMTP id p21mr3753572uar.54.1584025057464; 
 Thu, 12 Mar 2020 07:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-4-geert+renesas@glider.be>
In-Reply-To: <20200218151812.7816-4-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Mar 2020 15:57:26 +0100
Message-ID: <CACRpkdacAaw4PJp3Oa569JJTHTB4HjP-hPqZLmdFcuxvdvwBHg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpio: Add GPIO Aggregator
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::942
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
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert,

thanks for your patience and again sorry for procrastination on my part :(

Overall I start to like this driver a lot. It has come a long way.

Some comments below are nitpicky, bear with me if they seem stupid.

On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> +#define DRV_NAME       "gpio-aggregator"
> +#define pr_fmt(fmt)    DRV_NAME ": " fmt

I would just use dev_[info|err] for all messages to get rid of this.

> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/ctype.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/machine.h>
> +#include <linux/idr.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +
> +#include "gpiolib.h"

When this file is includes I prefer if there is a comment next to
this include saying why we have to touch internals and which
ones.

> +struct gpio_aggregator {
> +       struct gpiod_lookup_table *lookups;
> +       struct platform_device *pdev;

What about just storing struct device *dev?

Then callbacks can just

dev_err(aggregator->dev, "myerror\n");

> +static char *get_arg(char **args)
> +{
> +       char *start = *args, *end;
> +
> +       start = skip_spaces(start);
> +       if (!*start)
> +               return NULL;
> +
> +       if (*start == '"') {
> +               /* Quoted arg */
> +               end = strchr(++start, '"');
> +               if (!end)
> +                       return ERR_PTR(-EINVAL);
> +       } else {
> +               /* Unquoted arg */
> +               for (end = start; *end && !isspace(*end); end++) ;
> +       }
> +
> +       if (*end)
> +               *end++ = '\0';
> +
> +       *args = end;
> +       return start;
> +}

Isn't this function reimplementing strsep()?
while ((s = strsep(&p, " \""))) {
or something.

I'm not the best with strings, just asking so I know you tried it
already.

> +static int aggr_parse(struct gpio_aggregator *aggr)
> +{
> +       unsigned int first_index, last_index, i, n = 0;
> +       char *name, *offsets, *first, *last, *next;
> +       char *args = aggr->args;
> +       int error;
> +
> +       for (name = get_arg(&args), offsets = get_arg(&args); name;
> +            offsets = get_arg(&args)) {
> +               if (IS_ERR(name)) {
> +                       pr_err("Cannot get GPIO specifier: %pe\n", name);

If gpio_aggregrator contained struct device *dev this would be
dev_err(aggr->dev, "...\n");

> +static void gpio_aggregator_free(struct gpio_aggregator *aggr)
> +{
> +       platform_device_unregister(aggr->pdev);

Aha maybe store both the pdev and the dev in the struct then?

Or print using &aggr->pdev.dev.

> +       /*
> +        * If any of the GPIO lines are sleeping, then the entire forwarder
> +        * will be sleeping.
> +        * If any of the chips support .set_config(), then the forwarder will
> +        * support setting configs.
> +        */
> +       for (i = 0; i < ngpios; i++) {
> +               dev_dbg(dev, "gpio %u => gpio-%d (%s)\n", i,
> +                       desc_to_gpio(descs[i]), descs[i]->label ? : "?");

If this desc->label business is why you need to include
"gpiolib.h" then I'd prefer if you just add a

const char *gpiod_get_producer_name(struct gpio_desc *desc);

to gpiolib (add in <linux/gpio/consumer.h> so that gpiolib can
try to give you something reasonable to print for the label here.
I ran into that problem before (wanting to print something like this)
and usually just printed the offset.

But if it is a serious debug issue, let's fix a helper for this.

gpiod_get_producer_name() could return the thing in
desc->label if that is set or else something along
"chipname-offset" or "unknown", I'm not very picky
with that.

> error = aggr_add_gpio(aggr, name, U16_MAX, &n);

Is the reason why you use e.g. "gpiochip0" as name here that this
is a simple ABI for userspace?

Such like obtained from /sys/bus/gpio/devices/<chipname>?

I would actually prefer to just add a sysfs attribute
such as "name" and set it to the value of gpiochip->label.

These labels are compulsory and supposed to be unique.

Then whatever creates an aggregator can just use
cat /sys/bus/gpio/devices/gpiochipN/name to send in
through the sysfs interface to this kernel driver.

This will protect you in the following way:

When a system is booted and populated the N in
gpiochipN is not stable and this aggregator will be used
by scripts that assume it is. We already had this dilemma
with things like network interfaces like eth0/1.

This can be because of things like probe order which
can be random, or because someone compiled a
kernel with a new driver for a gpiochip that wasn't
detected before. This recently happened to Raspberry Pi,
that added gpio driver for "firmware GPIOs" (IIRC).

The label on the chip is going to be more stable
I think, so it is better to use that.

This should also rid the need to include "gpiolib.h"
which makes me nervous.

Yours,
Linus Walleij

