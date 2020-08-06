Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C64C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35FA23132
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJFsZaiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35FA23132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3iUv-0000f0-Lx
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 12:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3iUN-0000DU-Ph
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:11:31 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3iUM-0001q1-0U
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:11:31 -0400
Received: by mail-lj1-x244.google.com with SMTP id z14so14819845ljm.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6EPkV+t2f/BtD6irpZcGMlee+995nkUG3b4XsNwI9dg=;
 b=CJFsZaiEeJX2DYmTwWiJYTEDvIXPMQjVWbdTUHuifn+BHvdCu059j6uXdj6lt+LvU0
 2KzE36nUaWXFpGlky9w0E568AHuDMkQlPEURTLpFBMTMzMC94QasAazDAYyhaASvcNsa
 rmIByNQmiLfTKm9tyPK4loqfk7UVSpQe2vtI8wL2jbVbZQ7NFYunEP5G2uG98WbG/3uK
 f6vZgu3lx1rjOPnjC1WYWblmtuTsrplKx3rbqBuvB7NOPH7TkiThfQ5vBbi12TL/mdOl
 g+UAGZsLx6NrYvlItLHDCL3b7T5nsWoV9J38VIi5KVMVfOmK/Idm2dV/zeUWnTd0n0wl
 FB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6EPkV+t2f/BtD6irpZcGMlee+995nkUG3b4XsNwI9dg=;
 b=LbXriCDQefVlKJVYwTrxungzrpy9f8rWjFSU246kRPyxXMdIHKAvqH9hb+rx0KV6J5
 PNJMYf1rF13REi2tbypd6qDpcdsDp05AFY0zLMt5rPo3I77hRfGNLqv5hDP96/6epz/j
 60rzWZvdyJTshoc3eqYkQb68KrePUdBRPXb8hO0NJehhKNvAotU+l16eNW6tihw/qPlX
 FgskM2M/ushKwe+wNiyipRgp+EjULryym5q7uYa27vdH1uefRVzHPj00m7GvbsYIOAix
 wFO+Pvx87TArrbD0A6pyFc0DJQbf14TPKK43UokHnGngzYBZU/LaAWmCjbUcmAMm9eio
 phJQ==
X-Gm-Message-State: AOAM533lOrY618WDXdHQzNPH1CLcTyMxG60g4CfONfkOTUnpIK1zuJ3/
 N4hWY8jtdTYWjwZzjXw9bJnyxjZHtXJkChdn0Zc4nA==
X-Google-Smtp-Source: ABdhPJzPAQEiS2VaMpZiT5z82aOR3UXyS/XjHreHoXa39WKkDhtn8+yhvH06OCS8Of7Un9mqkCmyM2ssYeUloK8e6xw=
X-Received: by 2002:a2e:7f1d:: with SMTP id a29mr4385768ljd.424.1596730287508; 
 Thu, 06 Aug 2020 09:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-2-robert.foley@linaro.org>
 <ca24d2c5-2c5e-eace-4cf2-90011e684485@linaro.org>
 <4e678ed7-fc36-7918-ce9e-7a7e309c56df@redhat.com>
In-Reply-To: <4e678ed7-fc36-7918-ce9e-7a7e309c56df@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 6 Aug 2020 12:11:48 -0400
Message-ID: <CAEyhzFvveC=nhpo4uyJ_89J8Wi4+9NEc2T2Mk9mg6Y9ZMQjNSA@mail.gmail.com>
Subject: Re: [PATCH v1 01/21] accel/tcg: Change interrupt/exception handling
 to remove implied BQL
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 05:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/08/20 21:18, Richard Henderson wrote:
> > On 8/5/20 11:12 AM, Robert Foley wrote:
> >> This change removes the implied BQL from the cpu_handle_interrupt,
> >> and cpu_handle_exception paths. This BQL acquire is being pushed
> >> down into the per arch implementation.
> >>
> >> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> >> ---
> >>  accel/tcg/cpu-exec.c | 19 +++++++++++--------
> >>  1 file changed, 11 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> >> index 80d0e649b2..8e2bfd97a1 100644
> >> --- a/accel/tcg/cpu-exec.c
> >> +++ b/accel/tcg/cpu-exec.c
> >> @@ -517,9 +517,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
> >>  #else
> >>          if (replay_exception()) {
> >>              CPUClass *cc = CPU_GET_CLASS(cpu);
> >> -            qemu_mutex_lock_iothread();
> >>              cc->do_interrupt(cpu);
> >> -            qemu_mutex_unlock_iothread();
> >>              cpu->exception_index = -1;
> >>
> >
> > This patch is not bisectable.  The removal of the lock here needs to happen at
> > the end, or something.
>
> Indeed the series should be structured like this:
>
> 1) rename all *_do_interrupt functions to *_do_interrupt_locked
>
> 2) add back *_do_interrupt that takes the BQL and calls
> *_do_interrupt_locked, point ->do_interrupt to it, remove the BQL from
> cpu-exec.c
>
> 3) modify the cpu_mutex and BQL critical sections around
> ->cpu_exec_interrupt, so that the BQL critical section covers just the
> call to ->cpu_exec_interrupt.  Document which fields are now covered by
> cpu_mutex.
>
> 4/5) same as 1/2 for ->cpu_exec_interrupt
>
> Patches 1/2 would be pretty large, but they're trivial to review just by
> grepping for "->do_interrupt\s*=", and likewise for 4/5.
>

Thanks for the details !

It seems like we will have 3 separate patches for this series, 1/2, 3, and 4/5.

We will go in this direction.

Thanks,
-Rob

> Thanks,
>
> Paolo
>

