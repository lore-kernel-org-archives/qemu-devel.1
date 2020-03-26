Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A3C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469F120714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r72PNhsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469F120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZ5Z-0002Me-EV
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHYys-00034G-MC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHYyr-0007XI-Eq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:19:58 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHYyr-0007Wv-9x
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:19:57 -0400
Received: by mail-ot1-x343.google.com with SMTP id c9so7340259otl.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZPAWN5MUS4egYOv95HReiuAQNVf1YCBjE13Yrr+IeVY=;
 b=r72PNhsR6NNRmlb8y8tQb1Vavgiwva/iv0UsLCxmdeHuwio3kfMQHKKzL4O0nYbaQZ
 xfvYnzEk6n8jcjAG/6fcg6hSZmmZwGewEmj0KvBQS4+u5mng1HVWxELPJCh4BSedvuOE
 BrEbZImIq00Zf1AYakJvIey/zfCNArOYoFh7IYHRcpiPsXUFzxuf1QxRDBfGY3L/YpRr
 cdx7pNjCuoq7gY+cPlayjkpLTHhjH1dPMtgNN8cA1WMlTBg3vSSk4JvpwLWtWtJ3+JQa
 CKA2SayzViLFH85UB/afLihzCkfAhh3oycVFiETR+uuywOH7zkcTz/SEwROVhFC1EdaU
 yMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZPAWN5MUS4egYOv95HReiuAQNVf1YCBjE13Yrr+IeVY=;
 b=ekdKSUgsTeQTO058iq4wdQVNtuZClFZBQuMh0+sYnCjqkwDK6dSOqT/8iJCTu5Rdh7
 RxZ1A898/owYYsNndoH2C8eXsrUx7sxt4512spmEg3H7vX/AHvU9zHcGqDcsDTfkcjKX
 DTucxHeBsBLDmFpnzeQcv4hpsrA8vUcCVstsztwWS6l/vhvbxdJRO4P5XKUASIwX11Cf
 U9q0a4qyvPWvLoSx1X5RqpRD/1/5E4LKzG8Y1gYErtExRcYN1GKhDhD4MrTnSVDebIwr
 IT8EJ1rrGBBFRiQVPWHNTDMPuCwQnuyPHX1/+lb/+3+K+xjdHpJTNtJd6sWK2nJvsNi0
 Hh8Q==
X-Gm-Message-State: ANhLgQ3MDjf02akQCMH7USmWdw7pTNQFQiBEjFkbStQqnMJP9jJlcolF
 0ySdPK7q0pkcE8jiIkbbr+lNS4Xxjz2HB8hKBQetog==
X-Google-Smtp-Source: ADFU+vv7YIHW2fkMU44kFv31fo7GGvUs+cuN0nxbYSVAfWebcZk+DAaWKmyPn0sZKlLaLXpTwaSDF/QIRo5dl0gCcns=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr7420193ota.221.1585253996065; 
 Thu, 26 Mar 2020 13:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200326170121.13045-1-alex.bennee@linaro.org>
 <CAFEAcA8Lo84gNk2tFCKsgM_O50bXTCs6Z9jH6aCvfDA56TDCmA@mail.gmail.com>
 <ba33454a-6e57-960a-7114-fc71a9f09442@redhat.com>
In-Reply-To: <ba33454a-6e57-960a-7114-fc71a9f09442@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 20:19:44 +0000
Message-ID: <CAFEAcA_KSVHkVznGD=cxzLaHSbPmWLN6MSqWHBqB8_ux05gD7A@mail.gmail.com>
Subject: Re: [PATCH] qemu/atomic.h: add #ifdef guards for stdatomic.h
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Thu, 26 Mar 2020 at 18:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 26/03/20 18:14, Peter Maydell wrote:
> >> +#ifndef atomic_fetch_add
> >>  #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST)
> >>  #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST)
> >>  #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST)
> >>  #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
> >>  #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST)
> >> +#endif
> >
> > This will work around FreeBSD's current implementation in particular,
> > but I don't think there's anything in the C11 spec that mandates that
> > atomic_fetch_add() and friends have to be macros and not simply
> > functions...
>
> That's not a problem as long as they are all functions, the macros would
> simply override the function-based implementation.

Oh yes, so it would. I think I was also vaguely thinking in terms
of FreeBSD being the leading edge of "one day most or all of our
hosts will have a full stdatomic.h", so maybe we should shift to
use-host-stdatomic-by-default, with the use of the gcc __atomic*
as the fallback at some point ?

thanks
-- PMM

