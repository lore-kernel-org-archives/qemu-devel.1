Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E432C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3133420674
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3133420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyP5-0004vX-63
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1iZyO4-0004Hq-Oj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1iZyO3-00021o-1f
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:33:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1iZyO2-00021L-T1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:33:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id o12so20220861oic.9
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 06:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p4HQ0sBvX9KwKME5QSEdWqGhxNVzafG2qhuy+QctP4M=;
 b=d1hob9Os11q9fccfNpUBbwdAlOwfPudnSXbQ/Z8iLIL2PeuopGuR0G5a8VaycWTgUh
 go7KXgzDI/LN9cJZRw4rgPv2lvxVrtz4M/u6aaVMk7RL7qQq7PGUZJTObO9UoGE8ckrI
 vMnndYEg9vIOPn/ufL8Ev5QkmXPtP3p4BMvbnrGEx9Tx+7mbKuI1Kkbac0INrye2AGQG
 P0HgCi/YPiay54OYh3Wst2xu71lyMztnlzr8xgcRA/UNUJBGGzI0/BQwoyRt6Vff2ZSN
 wvKU/EQSZqykIirSbSQN2St2QyM2a5dCfcg0j+73mkKblE54WB9TswrHW7QojYQl6mgl
 bORg==
X-Gm-Message-State: APjAAAXHF7bKFsIGSn91/h0jKSaXQDLcsy35R8ScW+MtH+w3e6V2YvvB
 9jxlacNd18V2hrmNsUqrWFQDV0EujIMmPY5jgGY=
X-Google-Smtp-Source: APXvYqxCCNIKdr71l4+aem/37DJmvPbfkWnFnSlhjT3Aiy6bb+myMARYI5vlJfzw8lh/LBhhdEQ2bi0iWvwnKGpu9eY=
X-Received: by 2002:a05:6808:b17:: with SMTP id
 s23mr4564212oij.102.1574865225731; 
 Wed, 27 Nov 2019 06:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
 <20191127141529.GA18189@vmlxhi-102.adit-jv.com>
In-Reply-To: <20191127141529.GA18189@vmlxhi-102.adit-jv.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Nov 2019 15:33:34 +0100
Message-ID: <CAMuHMdVMoo0rJ-Ji1ek-DqHEkRqM5Fk5o9RzQV08Z8SSdS9APA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Eugeniu Rosca <roscaeugeniu@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eugeniu,

On Wed, Nov 27, 2019 at 3:15 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote=
:
> On Wed, Nov 27, 2019 at 09:42:51AM +0100, Geert Uytterhoeven wrote:
> > +static bool isrange(const char *s)
> > +{
> > +     size_t n =3D strlen(s);
>
> Cppcheck 1.40-18521-ge6d692d96058:
> drivers/gpio/gpio-aggregator.c:69:11: style: Variable 'n' is assigned a v=
alue that is never used. [unreadVariable]
>
> Smatch v0.5.0-6150-gc1ed13e4ee7b:
> drivers/gpio/gpio-aggregator.c:69 isrange() warn: unused return: n =3D st=
rlen()

Correct, this is a remainder of code present temporarily during development=
.
Will drop.

(where are the days gcc itself warned about that?)

> > +     aggr->lookups->dev_id =3D kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME=
, id);
> > +     if (!aggr->lookups) {
> > +             res =3D -ENOMEM;
> > +             goto remove_idr;
> > +     }
>
> s/aggr->lookups/aggr->lookups->dev_id/ ?

Thanks, will fix.

> > +static int gpio_fwd_get_multiple(struct gpio_chip *chip, unsigned long=
 *mask,
> > +                              unsigned long *bits)
> > +{
> > +     struct gpiochip_fwd *fwd =3D gpiochip_get_data(chip);
> > +     unsigned long *values, flags;
>
> gcc 9.2.1:
> warning: =E2=80=98flags=E2=80=99 may be used uninitialized in this functi=
on [-Wmaybe-uninitialized]
>
> [..]
>
> > +static void gpio_fwd_set_multiple(struct gpio_chip *chip, unsigned lon=
g *mask,
> > +                               unsigned long *bits)
> > +{
> > +     struct gpiochip_fwd *fwd =3D gpiochip_get_data(chip);
> > +     unsigned long *values, flags;
>
> gcc 9.2.1, same as above:
> warning: =E2=80=98flags=E2=80=99 may be used uninitialized in this functi=
on [-Wmaybe-uninitialized]

So newer gcc is (again) no longer smart enough to notice the check is
the same for initializer and user...

> Should these be silenced like in 2bf593f101f3ca ("xilinx_uartps.c:
> suppress "may be used uninitialised" warning") ?

TBH, I'm not a big fan of silencing false positives.
But if people like to see flags preinitialized to zero, that can be done...

> I plan to do some runtime testing soon.

Thanks, looking forward to the results!

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

