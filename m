Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D17C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C692072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FS4HnzfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C692072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBk4-000793-5J
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcBiy-00068W-0I
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:44:48 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcBiv-0005uu-HN
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:44:47 -0400
Received: by mail-oi1-x244.google.com with SMTP id w4so10026653oia.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=He9Ai53bigQ3wpXR+okYJKvzTlf4suF9oFtHPuKvZnc=;
 b=FS4HnzfJxV6ArVQgu42LeEQppXIc6eMQNe+jzlb3SzQ80q67PV8ncoET5EJxNqOJFm
 qJEtGSSh8pnmnVnFMPSQVcJnwwo6t8OqfFSFNRf35wxf+qvD2C5KzowyrCjBBtsCUajv
 S1qBTVkd7uJ88EQ/HY6JC3+vDduu2+61lAKfVuDaEARSS7+5jpivMRRl9Nie2xVZNJ7C
 6MOZgAdq+OqpisBRD7pTxuEl0xN6FRl5xflf87XxElT35+943rtum5/K48Sho6/H8hq1
 Lposg3TZkMSbomVpkNSUOboyv+5evzSRhFDJXv2kOUIC4sbH/tGfSOfLFKO0vjzmJ76o
 9yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=He9Ai53bigQ3wpXR+okYJKvzTlf4suF9oFtHPuKvZnc=;
 b=Ai7dNvncnhDJ2iIm/lFB6t6EQqv+CMdeQEcQSQY95FUq4AY2xH5W8ZTG2czNSWrV7X
 K4TMwwZchBzt1h/+FOjAMHyDNyf+wzHMhXqkDSIeq+qiwre1ciRGHg7m4iaN1VVxJ5bC
 Nz7iGDilxGHSd8ftTTmoiytJNWJeobfJgPsp7ZmnLX9FnUP1z/jn2QAnT1CN7p7oIqJ0
 H6qE5t0DKLfDt4Dcau0bKSTpiltcwfZIgyrjHu0WuialEqnt+Y3ui8Yw7x8yqVo6wXN9
 4WnwUES5LhQ3u96KO+hnXco22si/SIXhS5cpzRRPpvNS9lGG+You0/aDm7EAuOG3qnx0
 QWgA==
X-Gm-Message-State: AOAM533AcyqMIVAqx3SD0Y0S9CUnxZSqfzWYDkHfN4lFAq5VP59e0NMx
 Esp9PrholgUPFeoP8Ok6LDw/Ki+HJSa0TNF9yGFMDA==
X-Google-Smtp-Source: ABdhPJx+Jwc5ZS1MCE1tWn2UahnrexoxK4r9e97Bv7klGjAvsxQmIUdw6rzzMesMxnNsS+neeS5cR4/+ylWxggFwBgs=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr3191029oih.48.1590169484037; 
 Fri, 22 May 2020 10:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-19-robert.foley@linaro.org>
In-Reply-To: <20200522160755.886-19-robert.foley@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 May 2020 18:44:33 +0100
Message-ID: <CAFEAcA8gqM1vn4eV5XK-2qOQ47ugO9OsFWA_+MgRpO4Vb5JFOQ@mail.gmail.com>
Subject: Re: [PATCH 18/19] target/arm: Fix tsan warning in cpu.c
To: Robert Foley <robert.foley@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: peter.puhov@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 17:15, Robert Foley <robert.foley@linaro.org> wrote:
>
> For example:
> WARNING: ThreadSanitizer: data race (pid=11134)
>   Atomic write of size 4 at 0x7bbc0000e0ac by main thread (mutexes: write M875):
>     #0 __tsan_atomic32_store <null> (qemu-system-aarch64+0x394d84)
>     #1 cpu_reset_interrupt hw/core/cpu.c:107:5 (qemu-system-aarch64+0x842f90)
>     #2 arm_cpu_set_irq target/arm/cpu.c (qemu-system-aarch64+0x615a55)
>
>   Previous read of size 4 at 0x7bbc0000e0ac by thread T7:
>     #0 arm_cpu_has_work target/arm/cpu.c:78:16 (qemu-system-aarch64+0x6178ba)
>     #1 cpu_has_work include/hw/core/cpu.h:700:12 (qemu-system-aarch64+0x68be2e)
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  target/arm/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 32bec156f2..cdb90582ee 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -75,7 +75,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>      ARMCPU *cpu = ARM_CPU(cs);
>
>      return (cpu->power_state != PSCI_OFF)
> -        && cs->interrupt_request &
> +        && atomic_read(&cs->interrupt_request) &
>          (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
>           | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
>           | CPU_INTERRUPT_EXITTB);

Every target's has_work function seems to access
cs->interrupt_request without using atomic_read() :
why does Arm need to do something special here?

More generally, the only place that currently
uses atomic_read() on the interrupt_request field
is cpu_handle_interrupt(), so if this field needs
special precautions to access then a lot of code
needs updating.

thanks
-- PMM

