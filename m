Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84102C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3CC20724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB/9xyNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3CC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKJD-00022p-E1
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFKHr-0001aU-CD
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFKHq-0008E7-9O
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:14:19 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFKHp-0008Dx-RQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:14:18 -0400
Received: by mail-ot1-x344.google.com with SMTP id k26so6519377otr.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nOoTJLL9PLRamroC3VmRwLzrlSrUz7xl+QdtUEtV9zg=;
 b=EB/9xyNbhhWrjTzUHVyuWm1u+k1D+Fy4CA7bMk9PUvNkkpQCXJE8rB5+5LjAnJcQnh
 WLMJFcef2iby/9/GxvoANCTu0SE4+w2lIfGbujnuMoSnagrJSJ2R9paTGquIMy1jTGPj
 5znUYG73rP0DpKteSbLnu6ZbBR2RN+bQhSnunl9aPbY5Jetqwb7n1IU0XRhTtjY3kxV1
 LnGKtZ7Z8rbrORp5wEJJnzYbitYf21raNyqJHxLCJTIW41yQXpZRZyw3AordxrpZKMKy
 umutQa/7bDbdXwe207mjLvbNt6gS5ZJAVuf/EysyW4PiddIkpxG5YfG863V8DKmW8gea
 VA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nOoTJLL9PLRamroC3VmRwLzrlSrUz7xl+QdtUEtV9zg=;
 b=f0P/rJnMzIQKNGnZCwDVogSHkXAgtH4/Q5HJ8EPEb/Y5Sl0Pn8cJ7veX+Exqb5Hsqp
 QjgJdRcBxJlpI5jhw6lUuOosfeYnubbnp4aO/WA3Ea84fQINQX52QIBB+b0qZ1xlvRGB
 2dk295LDSxGR05cYZOeEbpC7tzPr8TkZAeaIy/91JQccG3e/LbhDoVBR7GFyYavQPFDN
 0/BPwaJw55ACOFTkhLeQ+MpxSpNJ6ZjaHY92mc7MZfcHwmttsn2dapxrsNev9hY5SjDD
 Q/4pMlTd4pPdiyi4CSZSjR5nXAcZCdHegOdCkQTHThosI9OG6gE8WejIYbgGisgILmrn
 LMqw==
X-Gm-Message-State: ANhLgQ2HPtorqmYhgmG2h7bR/VBh1YapGmlDo6DOIu4xS/0k+G78BXbY
 nVqj4SwqNrXNoZrk/QC35kX2t0R2TmsalJ7yBWrMiw==
X-Google-Smtp-Source: ADFU+vuXQSKAkWUSyvaWJQOZutzI2zwb7cFSor8Y+gECe+6g3JUpUSKZTCXpm/GZP5XPHvztLJQfytcjxy8nPHrGHQk=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr7466445otm.91.1584720856823; 
 Fri, 20 Mar 2020 09:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011217.2102748-1-ehabkost@redhat.com>
 <CAFEAcA_6i1ponfRK6vUA_KCz_F=2c886CPQNKE8Kn4SifaRRxw@mail.gmail.com>
 <ae222b3b-04ef-7dc7-4560-2e24d32b69b5@redhat.com>
In-Reply-To: <ae222b3b-04ef-7dc7-4560-2e24d32b69b5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 16:14:05 +0000
Message-ID: <CAFEAcA8M4P3a-QGA9qjOTmpsAKGBcKDG2KRhOC1V=iLHK3mqkw@mail.gmail.com>
Subject: Re: [PULL 0/4] Python queue for 5.0 soft freeze
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Cleber Rosa <crosa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 16:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 3/20/20 4:59 PM, Peter Maydell wrote:
> > On Wed, 18 Mar 2020 at 01:12, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> >>
> >> The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c29=
9cb17:
> >>
> >>    Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' in=
to staging (2020-03-17 18:33:05 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>    git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> >>
> >> for you to fetch changes up to f4abfc6cb037da951e7977a67171f361fc6d21d=
7:
> >>
> >>    MAINTAINERS: add simplebench (2020-03-17 21:09:26 -0400)
> >>
> >> ----------------------------------------------------------------
> >> Python queue for 5.0 soft freeze
> >>
> >> * Add scripts/simplebench (Vladimir Sementsov-Ogievskiy)
> >>
> >
> >
> > Applied, thanks.
>
> I guess there was a mis understanding with Eduardo, he was going to
> resend this pullrequest due to:
>
> ERROR: please use python3 interpreter

Ah, sorry. I'd read the replies to this thread as meaning that
those things were OK to fix as followup patches rather than
requiring a respin of the pull.

thanks
-- PMM

