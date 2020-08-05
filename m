Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189EBC433E4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6B720842
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYN9TVCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6B720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3PXl-0005qB-3D
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 15:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3PX1-0005Ow-6V
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:56:59 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3PWx-0000ts-Af
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:56:58 -0400
Received: by mail-lj1-x242.google.com with SMTP id g6so36455958ljn.11
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Obx+ZZyNjXWkD/lMdK686gvUo9vtwZIvl7liisR/dhA=;
 b=ZYN9TVCVPhqCMjgmbk0wpYiAYEefsgX0+OuJotlntirNgZYP4ukHpysEUdHr9+Rkt2
 Gd5Fp9ZII++rrHN6xX2GskF/TIF0zlYasGtJIg5GYioQ6d0E0OK5QV6Jfe0WHQecYU38
 6+l1McS0Sr7CA1j/LwP1x8tQIIoJZFT3sJtvn6OwtWRt6rwB8LORlehr959Hgt//TrwW
 IBjAL3vBiMm5euG8lzuJLNWK71e2ldHUPC1iY/7+mdOkZtGG5+AfSlj6cY/vV+yQjLj/
 VjS0y0YtLBgKpL4nqnaQLeA40NXp/10bGoIPZJq15PZfxs/K2vaEvvgC0uDyJqE1yYN9
 XOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Obx+ZZyNjXWkD/lMdK686gvUo9vtwZIvl7liisR/dhA=;
 b=HVv1calValDnW12qFM4DlY2F72jgYgV6An4mWmwBCnXLTDbte/Y8CmIyGUMY432U2a
 Xui/NUE4ldJ0h0yegCbQAzafeBS2AHej26vmk+VXE4pn2jIbSDdWRCZI7w6quYmyHmbD
 1WZf8olJJYzzfEnOoYtV1eGOXO9wa4Q3VQHdiUi6t5YXQAdkb8k6i9mVcrq4w5CBc8vp
 IU86NbRbKSCgp2XcL23SNVrtMOYuOxSxY7igT5/bicCuEOmOpxNd1arVj4Byye7YwXu3
 ezK9iCTKQSSCrltA5BU15U6eaA89AH5BVzi555vdUb0Obq8ndf1YcaZQnzk3iPvEE174
 J5fw==
X-Gm-Message-State: AOAM530h4broxRVu1lKGpsM8qmOKH8Yc9MfL/R/qqIPbTLw9I0dky9R1
 kDzYEAin0t3ACwZoPBB96qOrEJ1l4WzqJyd6DUTJ6Q==
X-Google-Smtp-Source: ABdhPJz/l9gF2XShgwvOX7f4CLUAkWIAOjY8fuZ2UKM04ERCzP+LRToVbgHz8H7cg65YAMu4f6o8B2Q7Il5e4lLVeuQ=
X-Received: by 2002:a2e:9f0a:: with SMTP id u10mr2115939ljk.140.1596657412706; 
 Wed, 05 Aug 2020 12:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-3-robert.foley@linaro.org>
 <02c892db-164e-89c0-d484-ba1cb33f2d6d@linaro.org>
In-Reply-To: <02c892db-164e-89c0-d484-ba1cb33f2d6d@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 5 Aug 2020 15:57:13 -0400
Message-ID: <CAEyhzFu=y=hnF_CG6WVOCWzi6tvWt+R2g+6UFPrAS-_UbO9mTA@mail.gmail.com>
Subject: Re: [PATCH v1 02/21] target/alpha: add BQL to do_interrupt and
 cpu_exec_interrupt
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 15:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/5/20 11:12 AM, Robert Foley wrote:
> > @@ -299,8 +299,12 @@ void alpha_cpu_do_interrupt(CPUState *cs)
> >  {
> >      AlphaCPU *cpu = ALPHA_CPU(cs);
> >      CPUAlphaState *env = &cpu->env;
> > -    int i = cs->exception_index;
> > -
> > +    int i;
> > +    bool bql = !qemu_mutex_iothread_locked();
> > +    if (bql) {
> > +        qemu_mutex_lock_iothread();
> > +    }
>
> Why does this patch for alpha need to check qemu_mutex_iothread_locked and the
> next patch for arm does not?
>

In alpha (and arm) the do_interrupt function can be called separately or by
cpu_exec_interrupt.  In the case where do_interrupt gets called separately
it needs to take the BQL (bql == true).
In the case where cpu_exec_interrupt is holding the BQL, and calls do_interrupt,
do_interrupt needs to check qemu_mutex_iothread_locked, and in this case not get
the lock (bql == false).

The next patch for arm, checks qemu_mutex_iothread_locked in its do_interrupt
function, but not in its cpu_exec_interrupt function, the same pattern
as for alpha.

Thanks & Regards,
-Rob

>
> r~

