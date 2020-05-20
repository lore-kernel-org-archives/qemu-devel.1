Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD736C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900FF2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900FF2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOIS-0000a6-Mi
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jbOHg-0008En-P7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:57:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jbOHe-00049a-Ir
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:57:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id y85so2769384oie.11
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 05:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aJamwLm96ytvqLYKUjvZ9u/+2q4WNnQotOo2fde5CyY=;
 b=IwY2jTvnMT0KPcYYUBbsxKxbsujGzKjfsZvGzoBCn18rd0niM3uPJQi1bshReMGOFu
 jNfr/WYpPBycC0Gw227fBDyZBVae5dLkscD9K54PnTtNS2M7dmwFIrexczXvWlEZfriZ
 IN0p9fHJpUSr31GTLWHhN9ENBcANncyVs2vOZIIWW8AC+NnMfgvnTDxmoCWXQY2cF2gM
 +BdirsRbFyiXjvm230jQGDPkVmn5cV+4u1xbIW3OLXNPI9VLViyBHdy6E3oWALIqH2+z
 wSOZAAphxesqeCH3k9OfegA+ozgtH99MLJlLAfJdGN6oBYyQ7Wg/Lz1qWB5048u6gDkJ
 zITw==
X-Gm-Message-State: AOAM532F4vSDMc/7tX7lg+drETpdGO1SrfiS866Vh2WYpwG8ipnt5ulf
 2YOom8KZy0bAVFuds6/Jaeq+gfLzSv6opk8t7KM=
X-Google-Smtp-Source: ABdhPJwu+X5b8qR/tGxmz/DLvGSkjMTN6arpme3EHT/9IgTdRR+s5gJsMua0uE/HtMU43Dl221Icff70S4LCyfQLDG4=
X-Received: by 2002:a05:6808:1:: with SMTP id u1mr3056906oic.54.1589979437182; 
 Wed, 20 May 2020 05:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200511145257.22970-1-geert+renesas@glider.be>
 <20200520121420.GA1867563@smile.fi.intel.com>
 <CAMuHMdW9EsRLYYTL0pd-PqqZs5WcUfK8i2uceNwJnSvAQKuVgw@mail.gmail.com>
 <CAHp75Vc9=1cD81TDuaGuFQpBcHaKqEZKv8tA7ZGBbDJ6MKq6kw@mail.gmail.com>
 <CAHp75VcARgxf-Ty77mk2PJ0BUxJsXQdDLMffiDdv1gCkF_VMtg@mail.gmail.com>
In-Reply-To: <CAHp75VcARgxf-Ty77mk2PJ0BUxJsXQdDLMffiDdv1gCkF_VMtg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2020 14:57:05 +0200
Message-ID: <CAMuHMdXA8skK86yM4uX=2=ib0PNZvuvVdu4GzoD7zYngwz1emg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] gpio: Add GPIO Aggregator
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.167.193;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-oi1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 08:57:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andy,

On Wed, May 20, 2020 at 2:41 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, May 20, 2020 at 3:40 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, May 20, 2020 at 3:38 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, May 20, 2020 at 2:14 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Mon, May 11, 2020 at 04:52:51PM +0200, Geert Uytterhoeven wrote:
> >
> > ...
> >
> > > > Sorry for late reply, recently noticed this nice idea.
> > > > The comment I have is, please, can we reuse bitmap parse algorithm and syntax?
> > > > We have too many different formats and parsers in the kernel and bitmap's one
> > > > seems suitable here.
> > >
> > > Thank you, I wasn't aware of that.
> > >
> > > Which one do you mean? The documentation seems to be confusing,
> > > and incomplete.
> > > My first guess was bitmap_parse(), but that one assumes hex values?
> > > And given it processes the unsigned long bitmap in u32 chunks, I guess
> > > it doesn't work as expected on big-endian 64-bit?
> > >
> > > bitmap_parselist() looks more suitable, and the format seems to be
>
> > > compatible with what's currently used, so it won't change ABI.
>
> What ABI? We didn't have a release with it, right? So, we are quite

ABI = the parameters it accepts currently.

> flexible for few more weeks to amend it.

Indeed, we have time to make changes until the release of v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

