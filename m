Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C0C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F64C2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjwluSQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F64C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecmU-0001Bd-9u
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iecls-0000gp-8Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ieclr-0005qX-1Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:29:36 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ieclq-0005q8-SX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:29:34 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so9333026oic.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 02:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ti24g5Ml8cfyB8YPNcyhO9AecXFyWAWKkXXMl7FXl00=;
 b=wjwluSQ1qNM2r8wY1O0DiAsyN6DHzdrop036iklOQCL7dzWdo29Cj8x1Ol/AtaHO5/
 +9kRzICtxLb+WThzB/a65Sk6undmRl5SSUI+DbnhdwVvhtzDmikD+DKi72BaXdgLF0ge
 D2D5j5bB1wHy9IeXZ9IGPYZh8A+BGQlE/9LMIATDsHXTA1wNiLevnalEOoW9LKbTGwF3
 kEIHx/vH1mDTMaRaCK9ZF4yB49D2t/8J+39O9CrhgIaNgzcWe4RZqBvrugCBq3ADCzT1
 ydCdq156Nql2O7q0wriHO2zpNXbZt7nPSUKJoihE5Hj33YLDgPypt+LlBWfx0ryokIXC
 dV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ti24g5Ml8cfyB8YPNcyhO9AecXFyWAWKkXXMl7FXl00=;
 b=mXW53SJxb3BvDadsnRT4vniNxTrRLLvWrYKROWWx7EPt+2YPap8n9gNE7qh3sBA+af
 0vGV/jDW34fUvUxX/u/WN5zokD6O9L+CLGAMpOioBZYiF53V4O2/OTdbVPR3SWYYwGTL
 afsfZ6YQ2tRs3/mumc0jKxykGUdfO2jbxrtSc3rC58rYc1PGhkW+QXpwZnSQOYeD+Ela
 V4YMNecCpzcSBnTFboOpp4X6soeAAMoipc48xMOn4uzf99sUtHROnMUje3EzsO5TEUMi
 11ywbIoU1xqZQt0u8gz0rIKHsv0q/TziIR2LLILTZoBWk4sWt6AGObiZIOXJoDWfqFLT
 ZICw==
X-Gm-Message-State: APjAAAV37wrp5vX7BJOywwjerXjOB9zLUhCp9QBq4ndPnrLHgpDBu9go
 2DAiR1RQv33aHNUmkv6c43Ebo3TM0ePzUzuPFaA9Mw==
X-Google-Smtp-Source: APXvYqx4rTi+YVEJMvNpW3CY+zwgfAxZ7qsdv3+IMUaFdB7N0TsvxXWY3Pp0jrCrXoe0fmpiKY5zTgzFtaO3RH+TTk0=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr3143457oic.146.1575973773941; 
 Tue, 10 Dec 2019 02:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
In-Reply-To: <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2019 10:29:22 +0000
Message-ID: <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
To: Andrea Bolognani <abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Andrew Jones <drjones@redhat.com>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Dec 2019 at 09:51, Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Fri, 2019-12-06 at 16:53 +0100, Andrew Jones wrote:
> > On Fri, Dec 06, 2019 at 03:22:58PM +0000, Peter Maydell wrote:
> > > On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
> > > > This series is inspired by a series[1] posted by Bijan Mottahedeh about
> > > > a year ago.  The problem described in the cover letter of [1] is easily
> > > > reproducible and some users would like to have the option to avoid it.
> > > > However the solution, which is to adjust the virtual counter offset each
> > > > time the VM transitions to the running state, introduces a different
> > > > problem, which is that the virtual and physical counters diverge.  As
> > > > described in the cover letter of [1] this divergence is easily observed
> > > > when comparing the output of `date` and `hwclock` after suspending the
> > > > guest, waiting a while, and then resuming it.  Because this different
> > > > problem may actually be worse for some users, unlike [1], the series
> > > > posted here makes the virtual counter offset adjustment optional and not
> > > > even enabled by default.  Besides the adjustment being optional, this
> > > > series approaches the needed changes differently to apply them in more
> > > > appropriate locations.  Finally, unlike [1], this series doesn't attempt
> > > > to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL, which
> > > > only ticks when the VM is not stopped, is sufficient.
> > >
> > > So I guess my overall question is "what is the x86 solution to
> > > this problem, and why is this all arm-specific?" It would also
> >
> > x86 adjusts the counter offset by default, and I don't think there's any
> > way to turn that behavior off. I think it's too late to follow that
> > default for arm, but this series provides a way to opt into the same
> > behavior.
>
> My understanding is that turning kvm-adjvtime either on or off
> results in a different set of advantages and drawbacks, with neither
> begin a one-size-fits-all solution. So it's good that we offer a way
> for the user to pick one or the other based on their specific needs.

If this is the case, shouldn't we be looking at having the
option exist for all architectures, not just arm? Obviously
pre-existing behaviour would imply having the default have
to differ for some archs/machines.

thanks
-- PMM

