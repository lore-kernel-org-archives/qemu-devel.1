Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32FAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7176120758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMPUbzd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7176120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbO3x-000172-KL
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy.shevchenko@gmail.com>)
 id 1jbO1y-0005vd-VS
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:41:06 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andy.shevchenko@gmail.com>)
 id 1jbO1w-0000SU-SS
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:41:06 -0400
Received: by mail-pj1-x1041.google.com with SMTP id l73so2310602pjb.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oByZiP5udJbQzBWklBptE2RceP4HV/dxPc97SQf5r9I=;
 b=bMPUbzd4w8Xckix21mTZAu4nqS8lo47Q1IuxRu1bg7ZEfkEGQ8nXx5annWGMvSJpUG
 Ik/OdHHZVFQzOUM1UtH3eq53mId64W2QngOShgah4eBAgtzA8wecG2nCqBzMqTNljtsD
 I/obKtjGl79PBq18fdqrzfjBAgO5nXDSxTC6ja6DWm6PPpb0EEEoMoUqBYfL2jgwEY31
 ny9uKMDOQHdpq3EmyqBSW1qcC/9hybhjlqyzXdhMmUELkNCHd+FG4uFvvhSZ89c0FYk8
 Wc8Amekl/xkn7XYPvcq8vhfKVysczN0Bay8pc2ehG7MO/QFdv0+hAQ81qW7BWXJ5hvL3
 f5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oByZiP5udJbQzBWklBptE2RceP4HV/dxPc97SQf5r9I=;
 b=QOp/Mz1P2tC44dlCUQKZ7GuvURVyeLDv8Q0YTacssTC3I/HAYS8nVIPj+raOWHF9oP
 aG0w6vSZi6pZmiG2wUn8y/lsYdieLdVjtlxeAAUlSf0Geu4JmFwu9I9jS2Bn9giTdwUW
 /lSOON2NF4cRPBuwDlkXZ91tYXqdhlrXr22dwThNLxg/CB8sBvdinEsf/CY99tLPjtpl
 CnM+vEQJqvOxR0Vcn4+BP1RiRRKZj7IX2ZbSunsmZYL43eNKu8RQRWpXbbjj7Xa6QIVZ
 gXprXZQTo8/9A0Q+2awsRiUXCOHpYctLrK14za4QsyMXachRrtK1FFPZG9Fljiab/9mb
 MMUQ==
X-Gm-Message-State: AOAM530FQLaZiaNriFImsb16BkuKzLllclIY6EhjFrqV45mZXNKc8JOe
 zBn0fdrCFV14bL6ztt57pDwtDMp4TssL1rXmL3s=
X-Google-Smtp-Source: ABdhPJyjV9IcI4Rvhp2yDHZ0cMw5+9uLEMBQuP44Edg6AhPbW7DTGRWOGVfUVIEgCtyep5Po1iHo+g/GYI8TVSX85T8=
X-Received: by 2002:a17:90a:1704:: with SMTP id
 z4mr5093444pjd.181.1589978463619; 
 Wed, 20 May 2020 05:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200511145257.22970-1-geert+renesas@glider.be>
 <20200520121420.GA1867563@smile.fi.intel.com>
 <CAMuHMdW9EsRLYYTL0pd-PqqZs5WcUfK8i2uceNwJnSvAQKuVgw@mail.gmail.com>
 <CAHp75Vc9=1cD81TDuaGuFQpBcHaKqEZKv8tA7ZGBbDJ6MKq6kw@mail.gmail.com>
In-Reply-To: <CAHp75Vc9=1cD81TDuaGuFQpBcHaKqEZKv8tA7ZGBbDJ6MKq6kw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 May 2020 15:40:52 +0300
Message-ID: <CAHp75VcARgxf-Ty77mk2PJ0BUxJsXQdDLMffiDdv1gCkF_VMtg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] gpio: Add GPIO Aggregator
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=andy.shevchenko@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

On Wed, May 20, 2020 at 3:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, May 20, 2020 at 3:38 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, May 20, 2020 at 2:14 PM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Mon, May 11, 2020 at 04:52:51PM +0200, Geert Uytterhoeven wrote:
>
> ...
>
> > > Sorry for late reply, recently noticed this nice idea.
> > > The comment I have is, please, can we reuse bitmap parse algorithm and syntax?
> > > We have too many different formats and parsers in the kernel and bitmap's one
> > > seems suitable here.
> >
> > Thank you, I wasn't aware of that.
> >
> > Which one do you mean? The documentation seems to be confusing,
> > and incomplete.
> > My first guess was bitmap_parse(), but that one assumes hex values?
> > And given it processes the unsigned long bitmap in u32 chunks, I guess
> > it doesn't work as expected on big-endian 64-bit?
> >
> > bitmap_parselist() looks more suitable, and the format seems to be

> > compatible with what's currently used, so it won't change ABI.

What ABI? We didn't have a release with it, right? So, we are quite
flexible for few more weeks to amend it.

> > Is that the one you propose?
>
> Yes, sorry for the confusion.
>
> > > (Despite other small clean ups, like strstrip() use)
> >
> > Aka strim()? There are too many of them, to know all of them by heart ;-)
>
> The difference between them is __must_check flag. But yes.



-- 
With Best Regards,
Andy Shevchenko

