Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB0CC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088F620679
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wyvu6dMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088F620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJio-00060A-4d
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iFJgi-0004jM-9P
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iFJgh-0006dw-5x
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:03:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iFJgh-0006d1-12
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:03:39 -0400
Received: by mail-oi1-x243.google.com with SMTP id k25so14654085oiw.13
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CBhiG6VBo7GbpwY9wroaOB4oTGwI0Tgdl2zBSwIeY08=;
 b=Wyvu6dMrTbtH535UVioXdHo42Odff31mvpd32o7ZWbonmZKY1O3MzdhU//0fl35/SY
 qbQWpTe7vXaK24LpYgp7QEuIGD5vgZxdBQQ+qRd6LxATvI+PX+GlE167a7dJ84RTukAH
 ATH85IbpUevAUZ1Y4LlBRlEKkJKmdkNNeTyOLw7TSeLiHOo1iWPoiJgmAyotUpxmpC7K
 F3Ktz8OIZnkXzfr2YsGx+QKUJF3R1XFcWCgi+ZTXWdpQ/MIHYCbkRWOkddrbl3VJ1lQg
 gmcoRZcYWW55jtMh44ICGTJyzxtyHRNwA5DxmpSFjGDJHtl/kFwxjWLhJ6E1J7h/Rrnd
 oAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CBhiG6VBo7GbpwY9wroaOB4oTGwI0Tgdl2zBSwIeY08=;
 b=gl2nlyBKN5WA2DBLEpQerOQCxq3hfYNdoDpSu8Vn5qPPFRsBPswM7Ccr9PpyTNDjxk
 XyGyB6rnIyFcspat3Us0b5A9DBrI5t6AZkxLJFlCua860H1emlZso44ueAtrQjWGNJOK
 80F/vq+Z5/u3/vO17pC1lxLBegv/FplJxau1MkFSwZkUt/HSJNawcvNpTcTwu+jUQnCL
 5NJe2VC0mFJFXRhcBJNPIGb5sN5YikWOR7tw3AgaJp5MyfsmfHnBNIDLK9nGBrXzDrdz
 qFMsWfFrvCKeYQkF4zNk0gY9rjHouvlVuP91iAQJYcGg5HBrlyGmXmGjYOeH2+P12slj
 5syg==
X-Gm-Message-State: APjAAAVn9xgSYRZgFIrS5RGCWZG8dRddECVXBub9hAydYe22y5TjWEB2
 KC+jdGH7MgOlf8rXr9mG7VH8CKw2rxTn9tfnGVFwyw==
X-Google-Smtp-Source: APXvYqy/BzmwEhxEPBcMRJyg6xj3pDBJUPtYPDGfu078aI0vHD+JXYiGd/txnwT+FWs3tz0RJNdofANPvxvYxwcXATw=
X-Received: by 2002:aca:b646:: with SMTP id g67mr4107588oif.163.1569942218023; 
 Tue, 01 Oct 2019 08:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8HGEdHs74-m3Wa7RHU_ZE5g9kEidP-9Z69zhsMkCPRZQ@mail.gmail.com>
 <40ec672d-b6a0-9b3b-f619-331b2fac05c2@linaro.org>
In-Reply-To: <40ec672d-b6a0-9b3b-f619-331b2fac05c2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2019 16:03:26 +0100
Message-ID: <CAFEAcA_rkFA62XZxP0ZGomNk6=XjVqOXUCLDA2f4tuaS28O9Hw@mail.gmail.com>
Subject: Re: ptimer use of bottom-half handlers
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Sep 2019 at 18:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
> If "other things" are being changed along with ptimer_set_count, then is the
> boolean result of ptimer_set_count necessarily still relevant after the "other
> things"?
>
> Can we record the set of things to be done within a
> ptimer_transaction_{begin,commit}() pair and then invoke the callback (if
> necessary) when committing?  Is it even easy to see the set of "other things"
> that would need to be wrapped?

That seems like a good plan. The calls into the ptimer that can
cause the trigger function to be called are:

    ptimer_set_count
    ptimer_set_period
    ptimer_set_freq
    ptimer_set_limit
    ptimer_run

ie all the functions which set ptimer state plus ptimer_run which
sets the timer to enabled. In all those cases what we end up doing
is something like:
    if (s->enabled) {
        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
        ptimer_reload(s, 0);
    }
(and ptimer_reload() recalculates the timer parameters and might end
up calling the device's trigger function).

So we could instead postpone the whole
        s->next_event = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
        ptimer_reload(s, 0);
to the transaction-commit function.

This would actually somewhat simplify users like the
cmsdk_dualtimermod_write_control() function, which currently have
to be a bit careful about the ordering of ptimer_run/ptimer_stop
calls relative to the other state-setting functions.

thanks
-- PMM

