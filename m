Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30303C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F9620719
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F9620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE7uR-0001Is-75
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 04:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jE7td-0000sy-K6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jE7tc-0005fN-Fb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:48:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jE7tc-0005bp-Ai
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:48:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id j16so20798029otl.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 01:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TF9ZPq6K3m7hthYQMxgsfrxGm1XjgIE20ka3eMWPfOI=;
 b=nMIUgiefu8x1cILWpPflZh6tHuk4mcHWTLaIAV05OVbo2owp9EucNHqGExq1iD3hit
 U7AiaebyAJnYIqhjn/E4/8l4IgaDKOclLtReG3ne0edg4Vrubdxo6u/rUvOitSGeyskC
 wbMcnCV9OG5DabfRifuJEqAOmeC7SQhHtvKYnvMVX++Whx0AEaMjcFWHIrqOyPlN6Dv2
 XXfNQbWp5aMAdyQF2Nx2pQACICglDQF+QlPt74+CHk3TbLHurvbyqsicOI3iezAFL7W2
 OdYvjrkQdkRxT7srHpBfCBCcFnwB0rovyinlPIzOavkb6nx4Guud2q1S4RClQN/tajv4
 ibAg==
X-Gm-Message-State: ANhLgQ3YlPfek6nFjGGHXNCGaNgIUQ4LCLwrXgaLwLXVhJeakvpcOx7F
 jj7+amMyDCbyKEni7ggS/PDdDoD2tHJw4O2KSJ4=
X-Google-Smtp-Source: ADFU+vvY8Z0ef/19Mtjmqmv34pha/3636uxkMdzDg1Xxss7VCZaBeH5oruI+jGiAKjqfKhyWlQxYBTSwLqHEgrCeU/s=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr2783773otk.145.1584434899513; 
 Tue, 17 Mar 2020 01:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-3-geert+renesas@glider.be>
 <CACRpkda1JAnC=Feb39GeKEEP6q8Qwpsth6J+4OKj6A8S3YAUyQ@mail.gmail.com>
In-Reply-To: <CACRpkda1JAnC=Feb39GeKEEP6q8Qwpsth6J+4OKj6A8S3YAUyQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2020 09:48:08 +0100
Message-ID: <CAMuHMdVwbGNOWk+MK-XZSrSMY3nNnn0sfJ0UZFXaZgQh-tQDZw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] gpiolib: Add support for GPIO line table lookup
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.66
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

Hi Linus,

On Thu, Mar 12, 2020 at 3:21 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Currently GPIOs can only be referred to by GPIO controller and offset in
> > GPIO lookup tables.
> >
> > Add support for looking them up by line name.
> > Rename gpiod_lookup.chip_label to gpiod_lookup.key, to make it clear
> > that this field can have two meanings, and update the kerneldoc and
> > GPIO_LOOKUP*() macros.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> > Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>
> I will try to understand why this change is necessary to implement
> the gpio aggregator (probablt I will comment that on the other
> patches like "aha now I see it" or so, but it would help a lot if the
> commit message
> would state the technical reason to why we need to do this change,
> like what it is that you want to do and why you cannot do it without
> this change.

It's very simple: how do you want the user to refer to a specific GPIO
line? Currently he can only do so by gpiochip label and index.
However, there exists another stable reference: the (optional) line name,
which can be attached using "gpio-line-names" in DT or ACPI.
As this is the most use-centric way to refer to a GPIO, it makes sense
to support lookup based on that, too.

Will reword to make this clearer.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

