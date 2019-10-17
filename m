Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580FFECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296A920820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGDs7B2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296A920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9qL-00036Y-Og
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL9A4-0003jP-1h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL9A2-00010L-IY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:02:03 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL9A2-000106-Dt
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:02:02 -0400
Received: by mail-ot1-x341.google.com with SMTP id y39so2511962ota.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9xHx0j42+dszKfXOAWKZcC/s62cmj3o+j92PtFulr3U=;
 b=zGDs7B2EOmdJxseG6U49S0CBXjwuVeXqnhN76ZrB19oW6M5OLTaD8BPRn0arFasfny
 Bvw63QrdlkoZb4+qdbQuI5BzrVwnEVDPOuMBfdECIoSWlxF4gWiU4qSlJsNSio9oB6zy
 xzk69iGeuwrS2ieLkrM5ibny4XxrbXchJGvvBYMMFHCB8NFBC3kT98l8KcGdDJY1msp/
 A4QXyDyd3FQtZ4DDMB05RVBqeG8KFPgeSa4+iakLwW0l4L/c407t5CDtOirTGPR9M3p6
 MOL0liFPnW8khU5D2THFabW0kOeUkMgwA/UP9+1TEyGjEUn6xcyQCj1U74KFyJal1Phh
 aRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9xHx0j42+dszKfXOAWKZcC/s62cmj3o+j92PtFulr3U=;
 b=uUMVOFF1QqcqaaBIJEvjwaHlaJb28xFiRmuqDEltgRP3S+GwpMBlXXG0GomL45RBfr
 VU2qvzUX1js4+E8GKF1yaKKsvqAQvK6o2ygG+DIRSjUPT/nPMjvF05xOuRjY2+6TFJBv
 sK+IkwF/Np+gMsWM+ktIVxGwoEEWujAlEUo+oXczlZl4499NtpU4vUM8FEcAv6tUst0b
 fp2QyboMG8fSdG4HPpyc37ZekFvEJRj6xVO9/YDdRC0Razjrdy5xhfP6BwEaI6b3XSks
 Hinh++c0Ge1KVk1VMMiYPphSCqqSkwfxt5rU1Fu5UyxniA5xsHsRRTvFMB52yqrt5IRK
 jBaA==
X-Gm-Message-State: APjAAAUgu1fxASDEZs8X7tPG8nIrcV5pTmoIq4bfdQAgWh8fMrzqFhUQ
 07jI9xd9c1b+LGRFF7n/7I0Y069x64gNS8P0ce1Phw==
X-Google-Smtp-Source: APXvYqzOmvkXJgr8OXNzax0VEYYlsZdv1JIS9YJnbSq2yTBTeRodfH7Fqyv1j8xQne2wWpSdEnFZ0S5K0SxpbKsQjuE=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr3987220otg.91.1571331721491;
 Thu, 17 Oct 2019 10:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <CAFEAcA_fmQKOk8k=Mo7MvuKvAq9Zb90xtQ0RdaxyMdLGZUwY0Q@mail.gmail.com>
 <a130df8a-5804-09a6-966c-2760b50a84c2@linaro.org>
In-Reply-To: <a130df8a-5804-09a6-966c-2760b50a84c2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 18:01:49 +0100
Message-ID: <CAFEAcA9+ryfqCzvOWagViFZw0HD9ngCpqXcd1xUktoaAHQbkOQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 17:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/17/19 8:26 AM, Peter Maydell wrote:
> > Don't we also need to do something to rebuild the hflags
> > for M-profile writes to the memory mapped system registers?
> > For instance rebuild_hflags_m32() bakes in state which
> > cares about env->v7m.ccr, which is set via nvic_writel(),
> > but I don't see anything whereby the write to the NVIC
> > register triggers a rebuild of the hflags value. Maybe I
> > missed it?
>
> How do you end the TB after nvic_writel(), so that the new behaviour can be
> noticed right now?  We can call arm_rebuild_hflags() within nvic_writel(), but
> it still needs to be recognized somehow.  I would expect to place one rebuild
> in the place you end the TB...

To copy my reply from irc, just for the record:

we don't end the TB specifically after a write to the NVIC.
This is permitted by the architecture: rules R_BMLS and R_WQQB from
DDI05533B.h v8M Arm ARM:

# R_BMLS The side effects of any access to the SCS that performs
# a context-altering operation take effect when the access
# completes. A DSB instruction can be used to guarantee completion
# of a previous SCS access.
#
# R_WQQB A context synchronization event guarantees that the side
# effects of a previous SCS access are visible to all instructions
# in program order following the context synchronization event.

A context synchronization event is basically an ISB or an
exception entry/exit. Since we do end the TLB on an ISB
or exception entry/exit I think we're within the architectural
rules, but we do need to do a rebuild-hflags somewhere.
At the end of  nvic_sysreg_write() seems like the best place as
it means that QEMU is internally consistent and not likely to
trip over itself.

thanks
-- PMM

