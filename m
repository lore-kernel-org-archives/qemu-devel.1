Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1E6C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BA820753
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOScXjW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BA820753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDA9-0004PE-A8
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jED9G-0003Tw-6Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jED9E-0002xv-Pl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:24:49 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jED9E-0002r9-JB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:24:48 -0400
Received: by mail-ot1-x344.google.com with SMTP id t28so19150134ott.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t2EcVrjjuP0uBiHvRWpoI3rAeHGpND26XfmnTsd4lkA=;
 b=gOScXjW7ONp3cIOLognYEsKkUY6KUYaTBQ6WvKrIQz4qFeDJ4rOjNThrxYI2vtoHdg
 SUxYIfkjV5dEqhK6PExXmFfnF2h3uVkAhc3D75DXlwBnJfmpy6OJup3Xbh/vzDGJJG7Y
 VMf1NntFMr48oUx8k53NLXvWNfZSYJvHpIRWz88Vjz5Tb4SwXzc1TVF8ku2mXfjv9W4w
 Sp0dsexd/5jxbD8Xvo8cb0I2a53fFvspUsPKxHXuiIJPqDnG9yqNTRxamSVougIOh0yE
 Wp+20k99y6gy8tjM/421wQLNrTUWRz6mnWRcJEUMzAQjuqVYAbv0GB15tQ0Zlci6xoHH
 Lnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t2EcVrjjuP0uBiHvRWpoI3rAeHGpND26XfmnTsd4lkA=;
 b=FbtJv7rgjBlg3KOywDYbcO/81t+UeWTehG4LNKJXhHUzeBzt96YKo/0e5+oqQPS3la
 iWkuOEYRnK+jFyO69hFwbBHPjZ+/kHgR4jtnJ7crBBRfDDiW9Hd2XTj6wunj2hOYMOYG
 GDXi1z1TYvHHKXMcbyTeS6cTSyvHPsb3sMLe1F9kX4fKn2Hkp12ZAr7iHH+z+ATGLInI
 erzJYmphNH0e2vby/SUoR5lMXhEw/h/DiNaQzbmsGBAlRZ8HJq4GxQPT0ToAwOCqv1PW
 nPdLdpKVabEFgBmvX2by0ZT0tt3JbJB4Ke6xL61seyJADZFCsHBTGqLfyVGFQdWiO7ll
 Vyow==
X-Gm-Message-State: ANhLgQ2ZfnTZS3uXRPTGf122iBoXQwsEQzVZTWaAZketwNayklfXs1Ip
 6AlzRztljVidmFgTNSU6NyOOeYzKPG32McEpeEd3Cg==
X-Google-Smtp-Source: ADFU+vsjC/eFTzTbx/56kVkybTB5o/RmXar9CRTwhTsd8GPv0HGewnckjEKw+n3AU1k1IAGcIx34l7L6kJkL/GnOp2o=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr3934762otk.232.1584455087480; 
 Tue, 17 Mar 2020 07:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
 <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
In-Reply-To: <20200317141257.GA5724@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 14:24:35 +0000
Message-ID: <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 14:13, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Tue, Mar 17, 2020 at 09:29:32AM +0000, Peter Maydell wrote:
> > Ah, I see. My assumption was that this was all stuff that you were
> > working on, so that I would then be able to test that it worked correctly,
> > not that I would need to do configuration of the gitlab.com setup.

> So, I had to use temporary hardware resources to set this up (and set
> it up countless times TBH).  I had the understanding based on the list
> of machines you documented[1] that at least some of them would be used
> for the permanent setup.

Well, some of them will be (eg the s390 box), but some of them
are my personal ones that can't be reused easily. I'd assumed
in any case that gitlab would have at least support for x86 hosts:
we are definitely not going to continue to use my desktop machine
for running CI builds! Also IIRC RedHat said they'd be able to
provide some machines for runners.

> OK, I see it, now it makes more sense.  So we're "only" missing the
> setup for the machines we'll use for the more permanent setup.  Would
> you like to do a staged setup/migration using one or some of the
> machines you documented?  I'm 100% onboard to help with this, meaning
> that I can assist you with instructions, or do "pair setup" of the
> machines if needed.  I think a good part of the evaluation here comes
> down to how manageable/reproducible the setup is, so it'd make sense
> for one to be part of the setup itself.

I think we should start by getting the gitlab setup working
for the basic "x86 configs" first. Then we can try adding
a runner for s390 (that one's logistically easiest because
it is a project machine, not one owned by me personally or
by Linaro) once the basic framework is working, and expand
from there.

But to a large degree I really don't want to have to get
into the details of how gitlab works or setting up runners
myself if I can avoid it. We're going through this migration
because I want to be able to hand off the CI stuff to other
people, not to retain control of it.

thanks
-- PMM

