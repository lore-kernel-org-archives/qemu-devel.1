Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283E2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA65214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA65214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPES-00028C-RU
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ifOb4-0003eW-92
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ifOb2-0002f9-Os
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:33:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1ifOb2-0002dV-ID
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:33:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so409193oie.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 05:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B1c5GbpC2qZV4XZL32ReXMmOl4Gf9Xdye7e43MFMR8g=;
 b=ubcrILAsj0IiGasCgkyC49mc/Gmrg0xueyh88hZjFcZ5PUazTVkzBOVcWYi7ejGI8t
 P+MSGfJzGWxyBw1+3TQQXuSPECEXCHoeVp8+y7MeaULOa7r1+3wBxvpq1WBBzSRl6Lqx
 UDtn4nVxRgdrDMZVWcgpMkdfOiNEU6rzx3rUkCbLjm+9qD9K55zAAP4DdcZ0yQHeAutF
 LjMB0d+esnZ5IagBZUrgUnwzGD5wLFro3qllbbLZYig/2ZDchk4Q5tRm5RQXxv/v+m2W
 2H7vMIv30lAUgU+WW7F5UPNx9XgLcJnhwpoPnoePt0Npu81bHi1sMy8pIXq+gqT7IFPS
 /LYQ==
X-Gm-Message-State: APjAAAVHXRzsXHAXRy+U9BqulFC+ltx4pKFcnPyuPx85Oa0Snd1jv6Qo
 tIRLX3KrEfEBAT4Vw8gKLPJI6/8thJBgAsP/TYQ=
X-Google-Smtp-Source: APXvYqyZrB81syD0Ce6WwALcSofZswA84PMJGyV785ydrh5qmd3i1ZIC8I8AuxCcmSbHRH3rYOaGved6PnxX/cMztls=
X-Received: by 2002:aca:4e87:: with SMTP id c129mr4645921oib.153.1576157615510; 
 Thu, 12 Dec 2019 05:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-3-geert+renesas@glider.be>
 <CACRpkdYyY0eGipdK6ixZxLtdJ5px=U2mOa79VZb00NEEAEL=6g@mail.gmail.com>
In-Reply-To: <CACRpkdYyY0eGipdK6ixZxLtdJ5px=U2mOa79VZb00NEEAEL=6g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Dec 2019 14:33:24 +0100
Message-ID: <CAMuHMdVL2w=DzOHTh-Tq6NZLTNUKxUneMi3wX71Z83mdsy3LTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpiolib: Add support for gpiochipN-based table
 lookup
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.195
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Linus,

On Thu, Dec 12, 2019 at 2:20 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Currently GPIO controllers can only be referred to by label in GPIO
> > lookup tables.
> >
> > Add support for looking them up by "gpiochipN" name, with "N" either the
> > corresponding GPIO device's ID number, or the GPIO controller's first
> > GPIO number.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> What the commit message is missing is a rationale, why is this needed?

Right. To be added: so they can be looked up in the GPIO lookup table
using either the chip's label, or the "gpiochipN" name.

> > If this is rejected, the GPIO Aggregator documentation must be updated.
> >
> > The second variant is currently used by the legacy sysfs interface only,
> > so perhaps the chip->base check should be dropped?
>
> Anything improving the sysfs is actively discouraged by me.
> If it is just about staying compatible it is another thing.

OK, so N must be the corresponding GPIO device's ID number.

> > +static int gpiochip_match_id(struct gpio_chip *chip, void *data)
> > +{
> > +       int id = (uintptr_t)data;
> > +
> > +       return id == chip->base || id == chip->gpiodev->id;
> > +}
> >  static struct gpio_chip *find_chip_by_name(const char *name)
> >  {
> > -       return gpiochip_find((void *)name, gpiochip_match_name);
> > +       struct gpio_chip *chip;
> > +       int id;
> > +
> > +       chip = gpiochip_find((void *)name, gpiochip_match_name);
> > +       if (chip)
> > +               return chip;
> > +
> > +       if (!str_has_prefix(name, GPIOCHIP_NAME))
> > +               return NULL;
> > +
> > +       if (kstrtoint(name + strlen(GPIOCHIP_NAME), 10, &id))
> > +               return NULL;
> > +
> > +       return gpiochip_find((void *)(uintptr_t)id, gpiochip_match_id);
>
> Isn't it easier to just  augment the existing match function to
> check like this:
>
> static int gpiochip_match_name(struct gpio_chip *chip, void *data)
> {
>         const char *name = data;
>
>         if (!strcmp(chip->label, name))
>                return 0;

return true;

>         return !strcmp(dev_name(&chip->gpiodev->dev), name);
> }

Oh, didn't think of using dev_name() on the gpiodev.
Yes, with the chip->base check removed, the code can be simplified.

Or just

        return !strcmp(chip->label, name) ||
               !strcmp(dev_name(&chip->gpiodev->dev), name);

> We should I guess also add some kerneldoc to say we first
> match on the label and second on dev_name().

OK.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

