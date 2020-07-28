Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BC0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E676220775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZcmuQz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E676220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MF9-0007Jh-7b
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MES-0006m8-1s
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:49:12 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:38685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MEP-00047E-1L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:49:11 -0400
Received: by mail-oo1-xc44.google.com with SMTP id n21so2808122ooj.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 02:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TdyyyqywWUMdnHNVZWGjksiBBFcyc3F5QM+a5cnsI6M=;
 b=CZcmuQz0+fChzJYgANcCMKOFWNVO3nbzqpsuahJiXsM/laZXIVdLxMRAHt4npoyRCl
 70G3mD52PI70p0JWv0qRLs8sRNY6sA4RyQWGw0MhGSduBQkCTvCGR1jNVR9bi0lH5ybf
 Evlj0B7Upx7JgYHHY58hGzlQsFFUm3zQDtIkvPv/D7MBcmSNVl2fyfmzl/Gd7vstKUNC
 +Q6IlTvmK7gSlUG/vvNFgj3BYV4Qi54EAJFd1o5lKGeBn9brO4CCmePhvSA0P6cG2H3w
 AdS7niyV6lK1U7v/HaBiz2L7Nt4FroG0yuyFvZ0kWuIOOyQABdSk5N4wb458V5r3HnkS
 7XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TdyyyqywWUMdnHNVZWGjksiBBFcyc3F5QM+a5cnsI6M=;
 b=qQuTdcLN1OpDBuGn2QB6JUxLNELrAChfUjEGpTLIOU6MdnuDNX62B2vE57zISeS2tC
 TW48E7dcXIkHS4vmSzvjtvbfq2ZYDnhMz7gucNLBKr5edEGe+TJ7do7508e0FL0z9Dhv
 dzcYvgJe5V/80neoYHh3Tl5mQLIFkr/t7ajItqkAvrwU/48EudJtdXCD36dsDLLou3sC
 BXCSUDIQ3ZVkYXVmfL6JDaZSXf2V9s1KdVfHLiFtC2LaUJLzHmtwgd55D0cx7ndSvWSY
 FPBocbTG4oOmNCbnCnttfOq9SAhIvrpF1rnJ/W1HObbxP06eF7bGxMMvX3av+o+RIPyc
 4gkA==
X-Gm-Message-State: AOAM53351n/YreZ3BQyjie/l9li1Efg1hea/vQ9IY39A4WFtf5gUjTwY
 s3dhRM/gx6te6wdHMA1MdIHSWeK/YSMPliyEyiZ/zQ==
X-Google-Smtp-Source: ABdhPJzzTQ/jXcq8/sKyHn3ybKUlbopQPDUo3bwsPERxQxQKwZLXW9tA7zh/rQ5blb36xDnR9nHsYE7zDQh583J4Np4=
X-Received: by 2002:a4a:4c44:: with SMTP id a65mr16107989oob.20.1595929747785; 
 Tue, 28 Jul 2020 02:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130225.32640-1-zhukeqian1@huawei.com>
 <CAFEAcA9vQMP0YLAuzdPW2m3RcRNySxA0gJQZmeXBUYRy4=Dk+w@mail.gmail.com>
 <92e8dc9b-deed-afb8-89ae-f50b68bbafa8@redhat.com>
In-Reply-To: <92e8dc9b-deed-afb8-89ae-f50b68bbafa8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 10:48:56 +0100
Message-ID: <CAFEAcA8myew9LM=ARwSwJybzWQu5=uOn55VrF=SX2xZr=bkRFA@mail.gmail.com>
Subject: Re: [PATCH] bugfix: irq: Avoid covering object refcount of qemu_irq
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, yezengruan@huawei.com,
 qemu-arm <qemu-arm@nongnu.org>, wanghaibin.wang@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>, Keqian Zhu <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 09:48, Thomas Huth <thuth@redhat.com> wrote:
>
> On 27/07/2020 16.41, Peter Maydell wrote:
> > On Mon, 27 Jul 2020 at 14:03, Keqian Zhu <zhukeqian1@huawei.com> wrote:
> >>
> >> Avoid covering object refcount of qemu_irq, otherwise it may causes
> >> memory leak.
> >>
> >> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> >> ---
> >>  hw/core/irq.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/core/irq.c b/hw/core/irq.c
> >> index fb3045b912..59af4dfc74 100644
> >> --- a/hw/core/irq.c
> >> +++ b/hw/core/irq.c
> >> @@ -125,7 +125,9 @@ void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
> >>      int i;
> >>      qemu_irq *old_irqs = qemu_allocate_irqs(NULL, NULL, n);
> >>      for (i = 0; i < n; i++) {
> >> -        *old_irqs[i] = *gpio_in[i];
> >> +        old_irqs[i]->handler = gpio_in[i]->handler;
> >> +        old_irqs[i]->opaque = gpio_in[i]->opaque;
> >> +
> >>          gpio_in[i]->handler = handler;
> >>          gpio_in[i]->opaque = &old_irqs[i];
> >>      }
> >
> > This function is leaky by design, because it doesn't do anything
> > with the old_irqs array and there's no function for un-intercepting
> > the IRQs (which would need to free that memory). This is not ideal
> > but OK because it's only used in the test suite.
>
> I think this could better be done without calling qemu_allocate_irqs():
> Simply call qemu_allocate_irq() (without "s" at the end) within the
> for-loop for each irq instead. What do you think?

Well, what are we trying to do with the function? I think that
your suggestion still doesn't really fix the leak in the sense
that there's no mechanism for undoing the operation and freeing
the memory allocated by qemu_allocate_irq(). The whole concept
of the function is pretty dubious because it's arbitrarily
re-plugging IRQs, which in the whole of the rest of QEMU are
assumed to be something that's wired up by board code or by
an SoC device that "owns" the two devices it's connecting.
That's fine for test-case purposes, and for the qtest code that
is the only in-tree user of this function we could construct a
(nominally) leak-free version of the function by having it return
some kind of handle that could be passed to a
qemu_irq_remove_intercept_in() to clean up [this would fix a
Coverity nag, which would be the main benefit...].

I agree that copying the refcount here looks wrong, but in
what situation is the refcount on any of the qemu_irqs
involved changing anyway?

For non-testing uses of this function it gets trickier (what if the
device on one end or the other is destroyed while the intercept is
in place, for instance?) So I'm a bit sceptical of ideas about
extending the uses of this function to non-test-code, and I think
I'd want to see what the intended non-test uses were...

thanks
-- PMM

