Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA65CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B00921872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knSS8sfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B00921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6eg-0005ib-8p
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO6ao-0000PQ-5W
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO6am-0001XM-JW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:53:53 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO6am-0001Wo-Dh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:53:52 -0400
Received: by mail-oi1-x242.google.com with SMTP id o205so2467995oib.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p02z0OsfvVJIqy8Wkqr51LLW+ZWmWxj6T9miCmOTccE=;
 b=knSS8sfHij5EiTv9pSRRaZCaggntt3op++bR4R+2FoUFVOiPxKTKDQl5jOCUHJGBfb
 wAlUUCXiM99Cajrp9s/Z+HDZoEvD/px70+rkie+XpmVCv2gN4lVBXNo2mwAqbiKhjWvH
 ouuEVxfOQesZPnd+7YrEytoqzNmeyidKSrsNNRzWhUEZidUWnHJW2p6ulEfiFcuVivXN
 UTliGYt5gyymCVZLNMLtmVweO6Rpangm29/ePCSqAgDNv8U3I6w+Q25sBfAzKm4Sg0pr
 QzlQkj/Xs+25B5AnwDlrU9QkOBlsVdg2aS6XmC04Lh0ZhqEPSJqQ9SCt5aADN61rsp9l
 3EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p02z0OsfvVJIqy8Wkqr51LLW+ZWmWxj6T9miCmOTccE=;
 b=LjaTXsRppBEwLrKQUaN0B3gbqUJG8ppBtTBflqRVbZBNIpx+0l27W7sCV6tatHXgMZ
 PoiGmvzGN78TotQkxhvzEwcbU/7U8BfvL00w3UjwAIHW4hwXHWDOfZ3N4lV9Hc46FSrY
 ZM/wA4pOEqpoon+Q5uWsDfaoFtROYK7897gQlzvDvjZZsgx6IUXQjsbUtzta5GMY16Qz
 19RAKGRdMCekdsNw6oAmL5sg3qLXptVtBTaGUQ37DoxvJRf2COsRnserUxhlDOUulAyO
 Qw/h+PUu8ZgFOWq0rOddARiW077O4lkxGWwbcA8P8fJVI05fROkZyW4F2lWEjy7LBIhh
 mdSw==
X-Gm-Message-State: APjAAAWp+fRhZNY0pDYBsrw0rVbuDWdbKo1+sYVTa43xlrCMvaQd2Bov
 23wTA0rLhAAw4WJAJMBR2hyfHwXzjq+86/IU2tarWQ==
X-Google-Smtp-Source: APXvYqxg9vQROYbzhQPdIDOCCLiFre9b0ANcxYngQskm3q+/Q/PlyCsqxLGMEM+LHDMcWG1zBhQ9i8DG2b5E/0+Z8jI=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr3991280oij.163.1572036830819; 
 Fri, 25 Oct 2019 13:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
In-Reply-To: <87mudo4owu.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 21:53:39 +0100
Message-ID: <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 20:15, Keith Packard <keithp@keithp.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Is there a specification for RISC-V semihosting? This is
> > likely to be my first question when the support comes
> > round for review, so you can have it early :-)  We'd
> > prefer to implement specified interfaces, not random
> > ad-hoc "this seems to be what newlib wants to see,
> > which is turn got hacked together by copying some other
> > architecture's code".
>
> There seems to be convergence on a pretty simple interface which uses
> ebreak surrounded by a couple of specific no-ops:
>
>       slli x0, x0, 0x1f
>       ebreak
>       srai x0, x0, 0x7
>
> There are implementations in rust and openocd, and I've got one for
> picolibc.

I'm going to push for somebody actually writing out a
document and putting it somewhere that we can point to
and say "that's the authoritative spec", please...
it doesn't have to be a big formal thing, but I do
think you want it written down, because the whole point
is for multiple implementations and users to interoperate.


> > Isn't the answer to this "don't use a command line that tries
> > to connect stdio to multiple things" ?
>
> Uh, we do that all the time? The mux device is designed to handle this
> so that you can use stdio for both monitor commands and application
> I/O. It's very convenient, the only issue is that the last device that
> hooks to the mux ends up getting input first (you use ^Ac to rotate
> among the selected devices).

Yeah, the mux works fine for this kind of thing. There's
no inherent reason why semihosting ought to "win" as
the initially selected thing on the mux, though --
typically that would be expected to be the UART/serial
console.

thanks
-- PMM

