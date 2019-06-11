Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB965C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A15A207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVyt6hU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A15A207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hadS4-0004IJ-Fd
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48488)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hadR4-0003s5-NK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hadR3-0004UC-5T
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:51:22 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hadR2-0004RP-Vk
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:51:21 -0400
Received: by mail-ot1-x344.google.com with SMTP id r10so11260533otd.4
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6hLmsyQ2L0BhQYeULo6gObtrN1hxLx/mhblVI0pAKxY=;
 b=xVyt6hU2WDcWnHJ5IEn4HVS68pMNofoOx+Hs3JZsbqKB7pGotr7VW1IlRGR3kAM1PT
 Fl0u9p7tJnyOkjsjt2ZiNQDu/lZ8IiHONHeieN5+tr9xjaWGjOHgTYswuLLKcAVdJY7V
 So1hJkEJtdUYxZ3qaTcQon7oMWVgX0kbDZnb6d/6vzls0GdchP84CIynModHBZvL9qmp
 GosCbtcvPjiltsf0fI/rgyNzZ5hxYSdVRBRYBbE0yGQC1Q2BPvWM9bs/r5MpkdBI3C9c
 3YVc0dO+fY5qUB8r1mSFXe11ZF9LGN+Vdwb2Yv6IJOpwwVfYrH8BblN7sG3acSQg+i+B
 JQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6hLmsyQ2L0BhQYeULo6gObtrN1hxLx/mhblVI0pAKxY=;
 b=L6K/AMZY68MT1AaaK7lhjPsPGe2WQ3zS41H86lwaePln2u1fqSlLg89q5XC9eHcVaP
 dpyDBZ7H14XARNu+LfYUW5ZKoVaOj1JAYc5V1t6A9FOJ+XpOm2P/ZFqoFPPZLE5aA+hR
 Zksa4gJbDO1vJi1jdFwhI2H/dU554Lkylw1ZDB0zBUi2UZ5N/1/UORxvFIeFEYFMLuoV
 VCrsx9ETDB3RQFqoJopnTmnq7yvOOSV8fxWnH3z81VFcQjzuQNSGiqL2OJq7wgB5QGnD
 55QZn/9Qet40jlVfj/br5dMV/MSADfw+WS6ciQUaUATP1uZ1ULGN9sThd11rSxZyIT5z
 78gg==
X-Gm-Message-State: APjAAAU10CojRneyepLVuBRYKRm94WBhR9qNKQlIj60n9ntTNCVkP+30
 vhYQpN9j7mobK9O6rUqgIpAUCWVDmHIl4NQrVJgagQ==
X-Google-Smtp-Source: APXvYqxepeYe8iawP9DyHnkPpR/0WkmnOHb5SyoK25QFEvI8V8PPeZY3ALXzqrYmdhwrKqX4V8XjlfLdvKpuOomIy7w=
X-Received: by 2002:a9d:630a:: with SMTP id q10mr12496452otk.91.1560246676496; 
 Tue, 11 Jun 2019 02:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190610152444.20859-1-peter.maydell@linaro.org>
 <20190610152444.20859-2-peter.maydell@linaro.org>
 <CAL1e-=hSY4uWQ9QmebdzkkV4WTZ82JFSW2fRafHBtvdJv1tm5A@mail.gmail.com>
In-Reply-To: <CAL1e-=hSY4uWQ9QmebdzkkV4WTZ82JFSW2fRafHBtvdJv1tm5A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jun 2019 10:51:05 +0100
Message-ID: <CAFEAcA_TAQvXbjP1h9SS6TiCxwwDf5oAUDAWDn0FRX3G0PBzaA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 1/2] docs/specs/index.rst: Fix minor syntax
 issues
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Jun 2019 at 22:41, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
> On Jun 10, 2019 5:25 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
> >
> > The docs/specs/index.rst has a couple of minor issues which
> > we didn't notice because we weren't building the manual:
> >  * the ToC entry for the new PPC XIVE docs points to
> >    a nonexistent file
> >  * the initial comment needs to be marked by '..', not '.',
> >    or it will appear in the output
> >  * the title doesn't match the capitialization used by
> >    the existing interop or devel manuals, and uses
> >    'full-system emulation' rather than the 'system emulation'
> >    that the interop manual title uses
> >
> > Fix these minor issues before we start trying to build the manual.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Hi Aleksandar; I'm just wondering what you were meaning
with this acked-by tag. Generally acked-by means  (to me,
and I think usually with qemu) "this patch touches an
area that I maintain, I haven't reviewed it but I'm OK with
it". But this series isn't mips-related, so maybe you
meant reviewed-by instead ?

(Acked-by is a bit of an odd tag because it's less
clear what it means than reviewed-by or signed-off-by,
so it's not very surprising if you've picked up a
different opinion on what it's for.)

thanks
-- PMM

