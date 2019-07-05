Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43CCC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5F721850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Up9JyrcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5F721850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLjt-0000yV-I8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58043)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjLgP-0006Qc-94
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjLgN-0005Fa-JJ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:43:13 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:36826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjLgM-000552-Kg
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:43:11 -0400
Received: by mail-ot1-x334.google.com with SMTP id r6so8637679oti.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v0qhgR18Fi9HfFrlJtSXlRGtgiDzyVzDSnBD1LqJNoQ=;
 b=Up9JyrcMhbIv4DgwIeiphhPJ8C+R9qbl3MafDn6WcITYa56HhNrf02rAHjUrwikaLS
 ttoHSy6NU0c+g55Cr4292V93Ea8nRgRgSt2fzSrot1J9iBdhW5qRNTsRaSNwylRrzCvf
 7aocgSAIwgRuckyzPUQLW1PBJOmA/QmBx8Q91sZ1wy+NIDny0DlEb1N4PP7qtTZKRh2K
 qCom7bQHCsalGf0CKVYQmgVeTJEINW1rHtbwbwdor04kbBDiWfxk6LIbeCC1v3g2SLkH
 dw63qvTnuSWrsNT6uFOFEtp/eHhjPhvmK51CXvgKMqxHjeC0A8frA5YvUMpKFN+PMFeO
 aBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v0qhgR18Fi9HfFrlJtSXlRGtgiDzyVzDSnBD1LqJNoQ=;
 b=hJHTBs8KZi1EM1QP61cjEceWdPsaMX7zyXsNgSqZobsQJJvjxI79iZi5jBtTLTBqQv
 awKZ/K7cyqkMRuEhdtFW6ph3+1ngLiQGUlzkCX8loIn1De43+qTCmPbPC/iCm1KeWHhR
 uNcrXtGPcH60DHsKjYSWnq9cMnS/DJMuxTYQMlHd0X9QIV1v1qppaf/dBQl8KZUymML3
 W3RM/TtNt87zVYhN/sLWvk2XtQL+MinDmlFxFWSmFo7mQh/tSnrgBgYWKgaUbCNEIWW1
 hXYqC9k3MrfmZld0hiEJrJW1/bMHgryIiaXAXq39P5QaWbUkOvf5FsJ6gdcngi6/9Xio
 J73Q==
X-Gm-Message-State: APjAAAXJKs6AoAS2STVZHp7KT5G1teFLDG5JZC2qB8H5jr5dOzodwJdO
 +BOkaFg4uerHsAsn0d5sJK1wa5nzFsFqHQRyxRTbfA==
X-Google-Smtp-Source: APXvYqyhPKEIk5toetEPxl+OuHN45B+5FhSi+d5WnmgsbDd4+ErjZazdi0MofP9peyyRfxsZcjwjLZ4DJ2ZtrCZNI4I=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr2182472otk.221.1562323387343; 
 Fri, 05 Jul 2019 03:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
 <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
 <CAFEAcA-giDCA8ZTR3Ft3ZNQUBEJBaXNaMnZOmgPo3Auw1gvZjg@mail.gmail.com>
 <faeb493b-f61b-16fe-3aff-aa40dffaf06b@redhat.com>
 <CAFEAcA-o-_tvgxZFs8rWcgK147pFLrbQLZ1s_fD0Gzc+iQc4UQ@mail.gmail.com>
 <9a1dbf89-a0b1-aeea-9066-e21029b0c48f@redhat.com>
In-Reply-To: <9a1dbf89-a0b1-aeea-9066-e21029b0c48f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2019 11:42:56 +0100
Message-ID: <CAFEAcA-=qUZTUPOOf8YecS2ut26=WwNBR=uEKuKqn8TWjsQtVQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Fri, 5 Jul 2019 at 11:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/07/19 12:21, Peter Maydell wrote:
> > On Fri, 5 Jul 2019 at 11:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> Yes, something like that but I would just bump the version.  Version 1
> >> has the old meaning for the first field, version 2 has the new meaning.
> >
> > Yeah, we could do that. I thought we preferred to avoid using
> > version-numbers for migration though these days ? (cc'ing DG
> > in case he has an opinion.)
>
> Yeah I suppose a subsection would make it easier to keep the old broken
> behavior for old machine types.  It would be a bit more code.

On which note, which of us is going to write this code ? :-)

> >> And also, since our brains are fresh on pl031... currently s->lr is
> >> always 0; besides the bug that writing RTC_LR should update it, the
> >> datasheet says the counter counts up from 1 so perhaps at startup s->lr
> >> should be set to a nonzero value?   That would be
> >> qemu_ref_timedate(QEMU_CLOCK_VIRTUAL) - 1.
> >
> > The 'summary of RTC registers' section in the datasheet says
> > that RTCLR's reset value is zero...
>
> Right, but RTCDR doesn't return the current wallclock after power up on
> real hardware, doesn't it?  So the choices are 1) RTCLR returns 0 and it
> looks like the board was powered on in the seventies; 2) RTCLR is not 0
> and it looks like some firmware ran initialized RTCLR.

I would want to test the behaviour of real hardware here before
bothering to change QEMU's implementation. And I'm not sure
it really justifies fiddling with it... (It's not impossible
that the hardware implementation really does hold "last value
written to this register" distinct from "whatever the offset
we have between the counter and RTCDR is", such that the value
read from RTCLR immediately on reset has no relation to what
the RTC is actually done and is just the reset value of the
relevant flops (ie 0).)

thanks
-- PMM

