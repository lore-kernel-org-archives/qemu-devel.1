Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B61C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C70220723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+4Nti1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C70220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcFJO-0004XB-R7
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 17:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcFIP-0003f3-Jm
 for qemu-devel@nongnu.org; Fri, 22 May 2020 17:33:37 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcFIO-000099-DV
 for qemu-devel@nongnu.org; Fri, 22 May 2020 17:33:37 -0400
Received: by mail-lf1-x141.google.com with SMTP id r125so7278107lff.13
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7JlkUZtCdNcp9FEiAbt/vaM6ONHQ2wi4161m9i3NjJU=;
 b=O+4Nti1Ul5wQC5PosjsdTlbmQmW5I8B+4NUingiFCZiDZACAI2Y6u+BRH3BQkYrrNh
 gFqwRg6lvJ9jwUidyDpAlJffMRqc6tbqJPyT5am9/w5oUqFdRjj42K+A/5QfmTMzxWET
 WpPi6HjTiRewbtZvoPKnv29DoWdl8EPqo4LCC1lh/04eCV0OdqKiIVEPTy15+kLVa/+k
 dX2TkO/a58Sd1z74udatn6RssgBnxDQlWodOOWghNppEId3TKf5hChNM+UrqJwqy0gVH
 ewg3ne63ZFcuNH/YqHNFbgL3ZkjMfQQSxgVhgP0Vyk07mRWn2pMbMrpaA255iQk0h1OX
 +wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7JlkUZtCdNcp9FEiAbt/vaM6ONHQ2wi4161m9i3NjJU=;
 b=oRGIPW6kq9KzekotsK9UJJ+oulCY+NGmB7MI9ND0RbyeKmhl8H0C1iSEOAJco4jO3B
 PXTer4K595dVp4KbRUE/0Y+fIspVB9OqRVIU1frL9hjeA5hZnjN5DCSd6cr+AYGcTr2a
 SzhT+kObyXuPh7+MVCusLMprgAo56rI0jAlQ9pkRgndyb1LicRA3MbSiqFoQWIcjJ9tk
 GtdubwwYmh8/NRdbgfkJw2pKal/zFmbOCSLqkN/086YoFsd4WDW3/wa13ydbQR5UMmyc
 8i7giEfp/nircS9uH38SnpwdqmeYcaU0AJdJoiZF4wuBF1EiKSPw1d+FEAMxzKQBSK1R
 27tg==
X-Gm-Message-State: AOAM5332v5L04NUsjyyQayiirfFRF4jZs3ChbrcLhqsJ1EicDPYAbWO/
 esEMBya2FgUZZDhjxTkW6ymPs+PKu54SoOWmAO3h5w==
X-Google-Smtp-Source: ABdhPJyJDvGNXvOx+XSDMfcFLKAVWUTcG2IfB9GFr8f/0IL7OclKGLwIoZQUH8i7l+/2GHXF/LPAMp8qFVqaUMYEDzc=
X-Received: by 2002:a19:be11:: with SMTP id o17mr8260735lff.187.1590183214500; 
 Fri, 22 May 2020 14:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-19-robert.foley@linaro.org>
 <CAFEAcA8gqM1vn4eV5XK-2qOQ47ugO9OsFWA_+MgRpO4Vb5JFOQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8gqM1vn4eV5XK-2qOQ47ugO9OsFWA_+MgRpO4Vb5JFOQ@mail.gmail.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 22 May 2020 17:33:27 -0400
Message-ID: <CAEyhzFsS3g-OQ0JzcDVfaaKAt9632XmKfzC0tfy0VmF_RRB2Og@mail.gmail.com>
Subject: Re: [PATCH 18/19] target/arm: Fix tsan warning in cpu.c
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 13:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 22 May 2020 at 17:15, Robert Foley <robert.foley@linaro.org> wrote:
> >
> > For example:
> > WARNING: ThreadSanitizer: data race (pid=11134)
> >   Atomic write of size 4 at 0x7bbc0000e0ac by main thread (mutexes: write M875):
> >     #0 __tsan_atomic32_store <null> (qemu-system-aarch64+0x394d84)
> >     #1 cpu_reset_interrupt hw/core/cpu.c:107:5 (qemu-system-aarch64+0x842f90)
> >     #2 arm_cpu_set_irq target/arm/cpu.c (qemu-system-aarch64+0x615a55)
> >
> >   Previous read of size 4 at 0x7bbc0000e0ac by thread T7:
> >     #0 arm_cpu_has_work target/arm/cpu.c:78:16 (qemu-system-aarch64+0x6178ba)
> >     #1 cpu_has_work include/hw/core/cpu.h:700:12 (qemu-system-aarch64+0x68be2e)
> >
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> >  target/arm/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 32bec156f2..cdb90582ee 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -75,7 +75,7 @@ static bool arm_cpu_has_work(CPUState *cs)
> >      ARMCPU *cpu = ARM_CPU(cs);
> >
> >      return (cpu->power_state != PSCI_OFF)
> > -        && cs->interrupt_request &
> > +        && atomic_read(&cs->interrupt_request) &
> >          (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
> >           | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
> >           | CPU_INTERRUPT_EXITTB);
>
> Every target's has_work function seems to access
> cs->interrupt_request without using atomic_read() :
> why does Arm need to do something special here?
>
> More generally, the only place that currently
> uses atomic_read() on the interrupt_request field
> is cpu_handle_interrupt(), so if this field needs
> special precautions to access then a lot of code
> needs updating.

TSan flagged this case as a potential data race. It does not mean
necessarily that there is an issue here, just that two threads were
accessing the data
without TSan detecting the synchronization.  TSan gives a few options
to silence the
warning, such as changing the locking, making it atomic, or adding
various types
of annotations to tell TSan to ignore it.  So in this case we had a
few options, such as
to change it to atomic or to simply annotate it and silence it.

We started our TSan testing using arm, and have been working to iron out the
TSan warnings there, and there alone initially.  Assuming that we are OK
with making this particular change, to silence the TSan warning,
then certainly it is a good point that we need to consider changing the
other places that access this field, since they will all see similar
TSan warnings.

Of course if we are not OK with these changes to silence the TSan tool,
that's OK too :).  In that case we can certainly just add an
annotation either in the
code or via our suppressions/blacklist and leave the code functionally
unchanged.

Thanks & Regards,
-Rob
>
> thanks
> -- PMM

