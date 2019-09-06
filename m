Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8E0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54047206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54047206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6C8V-0000py-Hw
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 07:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1i6C7m-0000M2-Ob
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1i6C7l-0003WK-Fx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:09:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1i6C7l-0003U6-Ar
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:09:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id n7so5338653otk.6
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 04:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YjIOTnA7AJrnGQlF0RtRVuR7iIuADp5iAhDiCUvFbDY=;
 b=cXqyiUGSfqHWcdtqmi+zmHMORFrmRBSYS3+OuR8vTNphR/MaLjukUYqSqzfBtScD12
 vxXLEQzkI4Uh7KOqddyUbtv5Lfm2CauSOr313AqBMzz341xzD7FbP5jrgzcgOgH+cM/y
 SVhF0+eIagneZmvxQsEf4vLjhEI+bS3S1gwxp1Crwwd5LyJ6vJqgjHHzYDFmxiV18cfM
 ziQ89xOUZGAKJAsoCHDoa13lwCtibJae97/7xM2m1c8e2TRH+y+hUV4WUvnYF55nyErR
 oasQaMPnRRCBMDDg4LofpjDoXLcuXihkdlSw0ESw/NjcfKMYENHEMP4gnITeibZhX+wv
 X2cQ==
X-Gm-Message-State: APjAAAVu8vwhBLpKWL63To3q6NmeZGCbGCGNcmkDyKHo1L+gWyGGQgRa
 4wV0pXtIeZL09Hm4gH5kE0NYj5wBLL1D0O7lONQ=
X-Google-Smtp-Source: APXvYqycNpCL4JLDQsajFhUn38P3soOaWnlH2I8lUg6IR7dOErT/aqJzV4mupZNPg2j96MybcS6x7VN9KphMVsGGLLA=
X-Received: by 2002:a05:6830:1196:: with SMTP id
 u22mr6795961otq.39.1567768190812; 
 Fri, 06 Sep 2019 04:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <CAMpxmJXOrDLdw6ZPBHxzsDRYiLmhRNCb-s_Z=Gu=Ecg1XA5ONQ@mail.gmail.com>
 <CAMuHMdWdb0dcS8Nvk-Poz2dT7nuHjFhqpsRPZZnSKsc3VffcRA@mail.gmail.com>
 <CAMpxmJUF1s1zyXVtoUGfbV7Yk+heua4rNjY=DrX=jr-v8UfNxA@mail.gmail.com>
In-Reply-To: <CAMpxmJUF1s1zyXVtoUGfbV7Yk+heua4rNjY=DrX=jr-v8UfNxA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Sep 2019 13:09:39 +0200
Message-ID: <CAMuHMdXOhrc1o5Jh3TN+JT4VFSSMg8Wy-rsgH=b8hNZQd8rXiA@mail.gmail.com>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
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

On Tue, Jul 9, 2019 at 4:59 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> pon., 8 lip 2019 o 12:24 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
> > On Mon, Jul 8, 2019 at 11:45 AM Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:
> > > pt., 5 lip 2019 o 18:05 Geert Uytterhoeven <geert+renesas@glider.be> =
napisa=C5=82(a):
> > > > +static int gpio_virt_agg_set_config(struct gpio_chip *chip,
> > > > +                                   unsigned int offset, unsigned l=
ong config)
> > > > +{
> > > > +       struct gpio_virt_agg_priv *priv =3D gpiochip_get_data(chip)=
;
> > > > +
> > > > +       chip =3D priv->desc[offset]->gdev->chip;
> > > > +       if (chip->set_config)
> > > > +               return chip->set_config(chip, offset, config);
> > > > +
> > > > +       // FIXME gpiod_set_transitory() expects success if not impl=
emented
> >
> > BTW, do you have a comment about this FIXME?
>
> Ha! Interesting. I'll give it a thought and respond elsewhere as it's
> a different subject.
>
> > > > +       return -ENOTSUPP;

Upon closer look, this turns out to be a red herring: gpiod_set_transitory(=
)
converts -ENOTSUPP to zero, so there is no issue.

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

