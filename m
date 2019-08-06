Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119F0C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC2320B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovj/xRI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC2320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huwac-0007Lk-1S
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 06:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41735)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huwa9-0006vt-Lh
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huwa8-0007WX-EK
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:20:41 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huwa8-0007W2-9E
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:20:40 -0400
Received: by mail-ot1-x344.google.com with SMTP id r6so91125848oti.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WDoDldayOWWAtEMDGk83ckSLS8BuWtvj+yd0ZbqHilo=;
 b=ovj/xRI03+Os1ASd8QoaHb0oZxBv3DWz3wSN3LurJe8QSsBCRf0yP3uJPiRIhu8ZDK
 IsLbJK0CkB9X8h5sHO1cqLL9gN6v0zu6akaGpO/y0o/6YySw4j7BqbfQrrMB4SPkVG8i
 xDWhY9qW5Lsq63wAk53kSkI8CEWGbqQUDdddU+g+B1mSs8tAljcXk4HN/KwOeoIuYYLj
 qttCbSAp0LEgI6b9nF3pFRY9JAPf8FPZeQJw2FXN13g53Qih7tccYoyTq/OLWqbE0ndR
 xcAEGVRtrsRjfMXpaTNv8IqkyPGeKGeQ2eW5+2IqnJGUVMJvL49gjsKyp2j/eqWTM25/
 9Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WDoDldayOWWAtEMDGk83ckSLS8BuWtvj+yd0ZbqHilo=;
 b=qwAP1wxK7qUDG0WdQIxQlPOosreKfG675YXLch+New1UTuWtog4ez1RnZ9ClsBYndO
 TpidYkT6HAcV7Vi05SVf+HdS7yPBJrq+4U1aeXxNmNdiXhxg7RaYg/ONgQ/PyFT3Nm92
 XDu5nolWqvjTKoqL8M6Q5VhUUlw5+A9qPwNojSt4Q+86sZJuK691goPIM6MvdQhWvL8g
 Ri1in5K+zEiQysp+GjKiFZmFI7by5z01qoP7YdZFrDXbBLN68aTE2hBXg6DXTPJx8Qr2
 1t3d2su43hKdRqVXViLmmdTVvpA5pj8GglrkuifR5vOov0O+Ek+oU4qYxmGVYu1bFPEE
 RBEw==
X-Gm-Message-State: APjAAAWUfpcPmIWSM838IQ83bNEIQba3/8MiUyDQWFybHu9+B2131VGx
 8lsBR75Shi0mv8ffZW1pv/4DWJUW+lvPyA+m7vU0hA==
X-Google-Smtp-Source: APXvYqzvUfvuV9KPCVcmWTm21sSmYmts080OQkgUrLfhE0le9BXv0T+I9zg0h3aqPP2HFORjBaplIQogFSWkthfHHLw=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr2616179otn.135.1565086839391; 
 Tue, 06 Aug 2019 03:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190805180332.10185-1-peter.maydell@linaro.org>
 <d788f3ff-6814-117d-942d-7870b6201f30@twiddle.net>
In-Reply-To: <d788f3ff-6814-117d-942d-7870b6201f30@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 11:20:28 +0100
Message-ID: <CAFEAcA_LZo0_J+LH3kaPXEKvH-_HPASNjdXdyauE-esk0D=FUA@mail.gmail.com>
To: Richard Henderson <rth@twiddle.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] target/i386: Return 'indefinite integer
 value' for invalid SSE fp->int conversions
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 22:13, Richard Henderson <rth@twiddle.net> wrote:
>
> On 8/5/19 11:03 AM, Peter Maydell wrote:
> > The x86 architecture requires that all conversions from floating
> > point to integer which raise the 'invalid' exception (infinities of
> > both signs, NaN, and all values which don't fit in the destination
> > integer) return what the x86 spec calls the "indefinite integer
> > value", which is 0x8000_0000 for 32-bits or 0x8000_0000_0000_0000 for
> > 64-bits.  The softfloat functions return the more usual behaviour of
> > positive overflows returning the maximum value that fits in the
> > destination integer format and negative overflows returning the
> > minimum value that fits.
> >
> > Wrap the softfloat functions in x86-specific versions which
> > detect the 'invalid' condition and return the indefinite integer.
> >
> > Note that we don't use these wrappers for the 3DNow! pf2id and pf2iw
> > instructions, which do return the minimum value that fits in
> > an int32 if the input float is a large negative number.
> >
> > Fixes: https://bugs.launchpad.net/qemu/+bug/1815423
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I've tested that this fixes the LP:1815423 test case. If anybody
> > has an x86 VM image to hand that has node.js installed it would
> > also be useful to test the operations in
> > https://bugs.launchpad.net/qemu/+bug/1832281
> > (I don't have such a VM.)
> >
> > The other approach here would be to make the softfloat functions be
> > flexible enough to allow this behaviour -- from my reading of IEEE754
> > I think the exact returned result for 'invalid' inputs for float to
> > int conversions is not specified.
> >
> >  target/i386/ops_sse.h | 88 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 60 insertions(+), 28 deletions(-)
>
> I guess this is exactly what we already do in fpu_helper.c.
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Huh, so we do; I didn't notice that :-)

thanks
-- PMM

