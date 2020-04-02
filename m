Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6598C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EA92078E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRT51vDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EA92078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJv54-0002e6-Oq
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJv4T-00029c-Cm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJv4R-0007xq-Vb
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:19:29 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJv4R-0007x5-IU
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:19:27 -0400
Received: by mail-oi1-x241.google.com with SMTP id k5so2045898oiw.10
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OAIiNJp5EcSVlgCqlJKhQ/RtGyDFw5Tgd1X1Blh8PNA=;
 b=JRT51vDC5d2ugjmv4cCgh2VXVO8wfO5tjOhhBzG0ibAcoeNibykd7FT4fCVmaq6LJr
 cBikArC8qE2d0AuWEEV6Zxzwn4+x7NC3lt+lgW4GNQ6RGpaUxbIqBdk6wA0/A3yDp1LB
 0unZsSqtzPcncSUl6tDPYUB59hrqZaJE67+mFeSiJW1DODeHXM8Ha2WMBkx8+tz6fQv4
 aK2RshWj66U8tvIBzQXVwA8OVOrp7KIbaLgSYHHhKBb1LzDVL8cfiiT3TTV/6Ps67g2l
 v4lNLbmbB9Sjci9nZsOHHp8qRWGcMPZuyvIIKwQVhjCLlEC9W0AE7TJ+g2EVUHRVS0gf
 PFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OAIiNJp5EcSVlgCqlJKhQ/RtGyDFw5Tgd1X1Blh8PNA=;
 b=LcrRKznqMFfhTgZ930+ZNEvC9A+sMqire8Xs7RGleTXQAX+us058i6Wbh1RWv8n6FZ
 xJ0a2TDJDq8M6mILma4DD21Wc+sGBAuxJFTP4EYJlvcui4L60un6/THfeaefmR/a94Vs
 /buyHOmONuGvjIt2g7Hx69ayK3ADTuh8248/ev0heEk+anURZ51lvBtPX5Y5MRuuC1BH
 YERq0ivmbAFBk8zrSLGO0DqNe6cbmgYxirLZDYiSt7BWswIm0sfvVuTwW/wkjKwWckrA
 bzUAF1QKdR7UlCXezTeMYO5h4Hr/0qtWjm72fXA3W7Zf/Ir+3o6Fl0rVI26D1q4vyBAo
 MTYg==
X-Gm-Message-State: AGi0PuZqezPPU2kYSJkbCMiD5YoZXT5K+hQ1EAs5XLMp8zQEj6/XxYBh
 b2xRIg5K6EoXzUsOJ6M+nk82UDkb1ytvklZ9Gu0H+w==
X-Google-Smtp-Source: APiQypLamOjJajBTflltdu4SfFMYgRrFGj5oeQKc9B4GJ9+sp6aYHofKRwEJCf+QFWh/5/rGc5FfpjvoV+nHjs7yFc0=
X-Received: by 2002:aca:c608:: with SMTP id w8mr1369082oif.163.1585815566407; 
 Thu, 02 Apr 2020 01:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
 <CAFEAcA-c_gX4=Be0oMLCmQy+PWc4uEHpQatuyNQjbrZXvsv1+w@mail.gmail.com>
 <87wo6zoku0.fsf@dusky.pond.sub.org>
 <CAFEAcA-mZ5nPOoPz0kafmEjUORYQj-DvieMeWqgbFarp1_DhNg@mail.gmail.com>
 <87tv23fepa.fsf@dusky.pond.sub.org>
 <CAFEAcA82AzhV3DSO=nogJg1YLwKk3RrGPVRe85ByhFbaW=YCJQ@mail.gmail.com>
 <87d08qbcm3.fsf@dusky.pond.sub.org>
In-Reply-To: <87d08qbcm3.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Apr 2020 08:19:15 +0000
Message-ID: <CAFEAcA82V5tMJs7jiuVov7-GFBG+4O037UkDngUKuKFqLj-6HA@mail.gmail.com>
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 at 07:55, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > I use this thing maybe once a month at most, more likely once
> > every three months, and the documentation is notoriously
> > impenetrable. I really really don't want to have to start looking in it
> > and guessing about how the original author ran the script, when
> > they could have just told me.
>
> I'm afraid we're talking part each other.

Perhaps; but I think we're also genuinely disagreeing.

> >>           $  spatch --sp-file scripts/coccinelle/qobject.cocci \
> >>                     --macro-file scripts/cocci-macro-file.h \
> >>                     --dir block --in-place
> >
> > Yep, that command line would be great to see in the script file.
>
> Except for the --dir block part, which is even worse than noise: it
> suggests this is just for block/, which is wrong.

It tells the reader that the original author only tested
the script to work inside block/, which is useful information.
(This is why scripts/coccinelle/cpu-reset.cocci specifies
--dir target in its command.)

> > The least-effort way for the author of the script to do that is to
> > simply give the command line they used to run it.
>
> If you're capable of writing a Coccinelle script that actually does what
> you want, you're certainly capable of doing better than blindly paste
> from your shell history.  Kindly drop the options that are specific to
> just this particular use of the script.  Keep the ones that future users
> will actually need.

I'm a future user; in fact I'm the future user whose needs I have
the best information on. I want to see the whole command, please.

> Two proficiencies: using a script somebody else wrote, and writing
> simple scripts.  Let me try to sketch just about the most basic of basic
> levels for the former.  Note that I'm making *liberal* allowance for
> reluctance to learn tools[*].
>
> Understand
>
> * that .cocci means Coccinelle
> * how to install Coccinelle
> * that you need to feed the .cocci to spatch
> * that this produces a patch
> * how to apply the patch to the tree
>
> None of this I want to explain in every .cocci script.  All of this
> I want be explained in scripts/coccinelle/README.

I'm certainly not arguing against having a README which helps
people with onboarding into the world of coccinelle scripts;
I think that would be great. I just don't really see much benefit
to either authors or script readers in asking authors to do more
than quote the coccinelle command line they used in the
comments at the top of their script.

thanks
-- PMM

