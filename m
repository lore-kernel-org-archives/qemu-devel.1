Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDA0C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2857920989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGiPEehU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2857920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLOd-0002h9-G1
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjLLH-0008Qa-Js
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjLLG-0007BX-Ju
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:21:23 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:36673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjLLG-000789-DU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:21:22 -0400
Received: by mail-ot1-x335.google.com with SMTP id r6so8586822oti.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oLyn7LjqKhRHs1v6bvFGYiniargHMFddlRTh7OzHlxI=;
 b=MGiPEehUPrWtHDN6HzvEPlBlA4UNeZPXPJwDLd1OE91kYs5tD61eZTF95SKxQvBvC4
 IUHYUzaL0gTr0pTzM6Y32JbeGbHVjMccLMjIqbgceXF9OiTjU5KBzYaicfN91y/dmNuM
 UTeo5ejUFXwl/DoWexAtFOCdg3nP/iz0CZhSGmm4+LiiQXJ2ALz6HtrpNzwX4dAjHO1q
 e10Y8UUWTXQTLWTH5WKR8fQK1Mf3lTpZzuSmM30n9W8MKqnn2wGosoe8oRLXCU5+bsq9
 wC0LFAbHv4Hekzp3gdMHZAHRYafll7R7/3hZSc4GbFZ4ghfuse7sEG04aW6GAfcG6gLU
 YU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oLyn7LjqKhRHs1v6bvFGYiniargHMFddlRTh7OzHlxI=;
 b=fBcT8vImH1h3DsozNJGu3MBkeosTD67iuwKZNxVD0X7xau4W5ynUIAQ2lfNHmO0JP9
 21Ie9lcJ7/gx2+ODdyUcFwAIxb2x4gyeYAtXN3oAqCQy+3UDLC/wpGDA2WlA/nZrLInK
 g+w0OTRMnRFZsIKU6WRG67PJLDgzxXUhh2WA69J6YZJUwiX8ZRqD7f4vjQjtfO/dySl3
 e6rWVqJwIa24in9vyHhOf57/lS6t0u3bHr8vk9Uf78mYdoA5w1zNyp2+2W39CRin828f
 4YsdA2cMS8tQCAqYh8JyzfjhiuF/rfIu6E2c/ewCUYOg/bCv9smlzVOKTlaH//Q0C/lP
 Oywg==
X-Gm-Message-State: APjAAAVikegjCJ5s1atQP47JlmrGunntGqAuFNSxZerqjJpeAIy0P5MS
 QFcvDIZB91mkWxKwYEfeqUoaDHhABMFU/npioFrQLA==
X-Google-Smtp-Source: APXvYqyRPCt47g7TYnwjAnBa+7apD23Hi1S/qBb0PUuwgSvpgd2zkwtfQSvaRavws2DHG8hCbsBOweV8pCpHz/+lJ88=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr2315750otn.135.1562322080907; 
 Fri, 05 Jul 2019 03:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
 <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
 <CAFEAcA-giDCA8ZTR3Ft3ZNQUBEJBaXNaMnZOmgPo3Auw1gvZjg@mail.gmail.com>
 <faeb493b-f61b-16fe-3aff-aa40dffaf06b@redhat.com>
In-Reply-To: <faeb493b-f61b-16fe-3aff-aa40dffaf06b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2019 11:21:09 +0100
Message-ID: <CAFEAcA-o-_tvgxZFs8rWcgK147pFLrbQLZ1s_fD0Gzc+iQc4UQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] pl031 time across vm save/reload
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 11:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/07/19 11:58, Peter Maydell wrote:
> > On Fri, 5 Jul 2019 at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> You're right, the compatibility causes wrong behavior for the default
> >> -rtc settings (the RC pauses across migration).  The right thing to do
> >> would be to store the base rather than the offset: that is, you store
> >> the time at which LR was written.  Then the offset is s->lr - s->base
> >> and it's independent of the machine on which the rtc_clock is being read.
> >
> > Right. How do we handle this for back-compat purposes? I guess
> > we need to have a new migration subsection, so if it's present
> > it has the 'base' value and we ignore the 'offset' in the
> > main migration data, and if it's not present we assume an
> > old->new migration and use the existing offset code. New->old
> > migration would not be possible as the new subsection is
> > always-present.
>
> Yes, something like that but I would just bump the version.  Version 1
> has the old meaning for the first field, version 2 has the new meaning.

Yeah, we could do that. I thought we preferred to avoid using
version-numbers for migration though these days ? (cc'ing DG
in case he has an opinion.)

> And also, since our brains are fresh on pl031... currently s->lr is
> always 0; besides the bug that writing RTC_LR should update it, the
> datasheet says the counter counts up from 1 so perhaps at startup s->lr
> should be set to a nonzero value?   That would be
> qemu_ref_timedate(QEMU_CLOCK_VIRTUAL) - 1.

The 'summary of RTC registers' section in the datasheet says
that RTCLR's reset value is zero...

thanks
-- PMM

