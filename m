Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF41C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7F9216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOePnv+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7F9216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjL1S-0006xd-AM
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjKza-0005Y4-A8
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjKzZ-0004JZ-A5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:58:58 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:44362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjKzZ-0004Ir-3d
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:58:57 -0400
Received: by mail-oi1-x22c.google.com with SMTP id e189so6717455oib.11
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mu89ZaTr0Q5Rtgrq3rLKUt+w/qx5N2xWCIpIzDByVuY=;
 b=VOePnv+qU8nVTGzRXriUDsDWu7te8OJRcqcAjheW5q0O4smTWY07JsrClc4QTkOuO0
 9kD7Q/9qpZ6mye/lhQKY1SaCPhuZl5kHkD1rLe2YCUOhH1ucXGOiMTQPOOtCb5gTQOkT
 2Rj6L/S/HVPeL8ylMTMg4Fm2IVr5rH30XVqmCZEdifrEDqhJ85XMYvu6u883d/dNkLX+
 EEM8r71Rya4JNdVo19TZjBt0lf4Tq8Vl9UWmjwg9seVkmubHY96iPWgoCtQhH/OG7P/+
 li3uwCk+V/bjSQ5MN+TA81bWDszyvQ7m8wJZMVUDp5bWOkaW0+kDOf6cBBiiw0PQVkPp
 56lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mu89ZaTr0Q5Rtgrq3rLKUt+w/qx5N2xWCIpIzDByVuY=;
 b=Ea/um8OZXgXXrJ+qRFZEYm0JOaM9LfNlRXEsGCW1SsQ0pAXEQuILAEMELHGHwyOmuk
 gJLEBPg/GElbEGRe4IwwEVZzs38WrZ+57PkNwA6//hw1TM1aeGpYlKnM93kKEfSCmwwi
 R/GyKMUSTdKyimj+GnJtw7TpCDTEUeKSMQ31kOjVAdps25aBjWjItaA+1r9m3UnptaGi
 ifR0u1tVInhEBS9IOc8Pyl/K3U6zE66LESnzJl8ct7lyxopprK+vQJSVIu/J/8UqTi4O
 w9qknpKYs52DVi9Fe8I7C9/9E7BHlukCmPugxvuAWHe4287g7145JiR3YUP2S9bAwMFk
 sJJA==
X-Gm-Message-State: APjAAAUec2gP0QOy+cWxh/pbcz9MnkVCPKTjpeeqJ2DPHqtLGoABIOVm
 iZAPGQQYpK68LKaOce017Wua9/HnKpa3AFm2kQ+ZIg==
X-Google-Smtp-Source: APXvYqxTvZ8mnr/eU3RQVxWlkDMXCwNAsAG+KjfLU0+8dWrCMo1ZqdgNKYdAjYyvfg55GcGQxJSOGTxudskXNSlaUiE=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr1454816oie.48.1562320735218; 
 Fri, 05 Jul 2019 02:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
 <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
In-Reply-To: <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2019 10:58:44 +0100
Message-ID: <CAFEAcA-giDCA8ZTR3Ft3ZNQUBEJBaXNaMnZOmgPo3Auw1gvZjg@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> You're right, the compatibility causes wrong behavior for the default
> -rtc settings (the RC pauses across migration).  The right thing to do
> would be to store the base rather than the offset: that is, you store
> the time at which LR was written.  Then the offset is s->lr - s->base
> and it's independent of the machine on which the rtc_clock is being read.

Right. How do we handle this for back-compat purposes? I guess
we need to have a new migration subsection, so if it's present
it has the 'base' value and we ignore the 'offset' in the
main migration data, and if it's not present we assume an
old->new migration and use the existing offset code. New->old
migration would not be possible as the new subsection is
always-present.

> By the way, the data sheet says "the counter and match values are
> compared in a comparator. When both values are equal, the RTCINTR
> interrupt is asserted HIGH"; QEMU compares the RTC value (read from
> RTC_DR) and not the counter value, but Linux code seems to expect QEMU's
> behavior.

The datasheet appears to be confused on this point -- for
instance in section 2.1 figure 2.3 talks about "interrupt
generation when the current RTC value (RTCDR) equals the
Match Register value"...

thanks
-- PMM

