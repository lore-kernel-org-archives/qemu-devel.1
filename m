Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A60C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E65206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktcCDNCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E65206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwAFq-0007OF-4r
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 16:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwAFF-0006wt-NT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:12:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwAFD-0000Zc-QO
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:12:41 -0400
Received: by mail-oi1-x242.google.com with SMTP id k6so6101307oij.11
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7FU1SlemzLKa/dmDjED8fqEZ5uLJ3MxawsPeWiP72yo=;
 b=ktcCDNCCcmZJyiZC/JNC8mmXQ3G5/ggZrz8gXLfD74ci/ZlnD+rp/ihRBEy/i3yzYQ
 HGERJM7e5NHkjMNuAqhJ5iQzvKGJ7LGQBOWSPCaqOIL0LGr8M3wBwwvN16upxLB8c4NC
 X7rYVFIo6cox6QvkFhPuPZU/b189pbYfWIsh21ZgG2t8TeYRustRRIoc8dhOP5SahRj4
 LhzrGAzoshdT5FjmcOiSBmlW86gkt+6I5/1CuFYaQyxJ2L+4T6xoyCU7JNZIqoxBMQv6
 wbtBwuShEUlTJ+d11+Dug5jXcQYVmt6ksHD/MW9PoJ4W496f0YhiCpitVShCNwafiPbg
 yw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7FU1SlemzLKa/dmDjED8fqEZ5uLJ3MxawsPeWiP72yo=;
 b=NZKZWwnfWvniRD3YtXmg4/3Y6F71OwRiy4hA4iaeTx5Qk7YZP4d/uWSvGgzxVxWxVD
 wFYTkZpFBSkPXzygXWGXMpShAPtEwV1qB2lOyv1Wl+PA7LTM+XlruCjREctksAz2Q1uJ
 z44mox+ygpGvTaKwzSZMgzZrZbZShR1+BKl655A0XfoV4MNDyQHpnF0qxcDnXLygq4ca
 I6JxxXyGOE1v/xqCSNb+XkLB9mTkHvx1G2rqGrWfjSFb201gDefatpQ6Sba5ojaFt6L8
 QRfOzZgJZve6gqhFsNxqlhA8PnzqDgLcIzK/8Gevvq6GGk266gMQ58d/s5KAtmA4P1uB
 2u5A==
X-Gm-Message-State: AOAM530uPp5ORP8uxIk3TlKtLkoQjpZZWnuhNSiifFQ3ZPrTovjkJY2b
 9fEWzU4/L+slEx5UTgSjOBkydcyNKzbc9/NMj7DHVw==
X-Google-Smtp-Source: ABdhPJwnlMHBsFmw9OLxW7GqrlBrup6acF3pZHjUZQIGzGzz2XOlLwSjMNzJqlUfYw6VMUNdA3sa/4q7P8afVNqWy7g=
X-Received: by 2002:aca:1706:: with SMTP id j6mr4964851oii.146.1594930358453; 
 Thu, 16 Jul 2020 13:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200716100445.3748740-1-luc.michel@greensocs.com>
In-Reply-To: <20200716100445.3748740-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 21:12:27 +0100
Message-ID: <CAFEAcA_fGQoPXGg_t0jsXk7R+aSbWp9S+mpVJbAVZRr9FyUSpw@mail.gmail.com>
Subject: Re: [RFC PATCH] tcg/cpu-exec: precise single-stepping after an
 exception
To: Luc Michel <luc.michel@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 11:08, Luc Michel <luc.michel@greensocs.com> wrote:
>
> When single-stepping with a debugger attached to QEMU, and when an
> exception is raised, the debugger misses the first instruction after the
> exception:

This is a long-standing bug; thanks for looking at it.
(https://bugs.launchpad.net/qemu/+bug/757702)


> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index d95c4848a4..e85fab5d40 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -502,10 +502,21 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>              CPUClass *cc = CPU_GET_CLASS(cpu);
>              qemu_mutex_lock_iothread();
>              cc->do_interrupt(cpu);
>              qemu_mutex_unlock_iothread();
>              cpu->exception_index = -1;
> +
> +            if (unlikely(cpu->singlestep_enabled)) {
> +                /*
> +                 * After processing the exception, ensure an EXCP_DEBUG is
> +                 * raised when single-stepping so that GDB doesn't miss the
> +                 * next instruction.
> +                 */
> +                cpu->exception_index = EXCP_DEBUG;
> +                return cpu_handle_exception(cpu, ret);
> +            }

I like the idea of being able to do this generically in
the main loop.

How about interrupts? If we are single-stepping and we
take an interrupt I guess we want to stop before the first
insn of the interrupt handler rather than after it, which
would imply a similar change to cpu_handle_interrupt().

thanks
-- PMM

