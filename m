Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 00:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82146207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 00:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe0dawuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82146207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Zb1-00087g-Rj
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 20:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Za3-0007bS-Iw; Tue, 28 Jul 2020 20:04:23 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:43122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Za1-0003PS-Pg; Tue, 28 Jul 2020 20:04:23 -0400
Received: by mail-il1-x143.google.com with SMTP id y18so9404306ilp.10;
 Tue, 28 Jul 2020 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mMSBBT6V4DhQDoK4cmBE3DWHDtiZcXiDt7eGq/nM6SQ=;
 b=Qe0dawukf/sxKj/FbNcaYZqmemTUrGnTJ8WgTN6JhmR6x2l8gs6EB4Vm1dyne1XFEB
 8RwkFUTQbSVDiWafkpwkoHDpGD7RLQ0pj/GQfss8AqwEoWBwzYQRAjlSMicc7PlvMZQM
 rwbaGXrW9bKw2uWVLp5qrhaF9I1F+HTALQnIxiMUG5AK6FkCFuRdYsvdXttH9xPMwZJd
 aCE7SBTZAhbINHxrWaQrqR532UYdvV9oXywkMApn+PCdXO4L5DqmLfuErxHctzKVni8A
 7xxNRDm59VoeeJUn9OaxbmGzevq2qDMqFKb8Vljyrzno1klyMZlmP1/Lt/3f+X8zcK3S
 6mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mMSBBT6V4DhQDoK4cmBE3DWHDtiZcXiDt7eGq/nM6SQ=;
 b=qPg+D8FgikdZueEX3N+JfALX0MsueRtLXTYBwpCGbtKFV2YXuqRpBPhJAU9CGZYyJT
 PwHhoUVNsqwBYHKP0Qz/agLgweXkkUnTiMAfwk5nspeC0vCdeFQg5L8uKS3u3RWRLz2T
 oUnOAe1lKPzZsl9rwZ7DSqCpfCFHhnVYGF7CbEScnltk5y2PB1HeYUC2+aGQUW+chioW
 WC53S/DDXqk785tAtsdpTjxSWUSW9HDNri4ekGVMnWh2K+RYIN5NMRw+2FUx7wBI/2Cq
 cyZt8r10b/QERaCXqw5GdgUMdt4VWmqoIWdUofbj0TcNaVPOQ81yH2c6xvZ+wjiyKqIq
 zd+g==
X-Gm-Message-State: AOAM5327PNiE9375OCAkdaMFltQkIWVnA9NP0cqAWrY1JZ93FmKjroCI
 Zad8Moslt5IV4SD5B/rsJujNT3Dg6sTSfuyEOdA=
X-Google-Smtp-Source: ABdhPJwdxSDh+v4nKwkjVmngl26UJVbAqIn9Ndl+c437AnJKQSsVTo06OxmPdVDxjnNNbSr+8TO08ucA5SkpgRV+ao4=
X-Received: by 2002:a92:cf50:: with SMTP id c16mr11547180ilr.131.1595981060059; 
 Tue, 28 Jul 2020 17:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200728103744.6909-1-peter.maydell@linaro.org>
In-Reply-To: <20200728103744.6909-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jul 2020 16:54:07 -0700
Message-ID: <CAKmqyKOvvVzu3qGVd=B56wT7oaR+BgYQ=YsiqR4GQRc-bTA3FQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1? 0/3] Fix AIRCR.SYSRESETREQ for most M-profile
 boards
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 3:38 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> QEMU's NVIC device provides an outbound qemu_irq "SYSRESETREQ" which
> it signals when the guest sets the SYSRESETREQ bit in the AIRCR
> register.  This matches the hardware design (where the CPU has a
> signal of this name and it is up to the SoC to connect that up to an
> actual reset mechanism), but in QEMU it mostly results in duplicated
> code in SoC objects and bugs where SoC model implementors forget to
> wire up the SYSRESETREQ line.
>
> This patchseries provides a default behaviour for the case where
> SYSRESETREQ is not actually connected to anything: use
> qemu_system_reset_request() to perform a system reset. This is a
> much more plausible default than "do nothing". It allows us to
> allow us to remove the implementations of SYSRESETREQ handling from
> the boards which currently hook up a reset function that just
> does that (stellaris, emcraft-sf2), and also fixes the bugs
> in these board models which forgot to wire up the signal:
>
>  * microbit
>  * mps2-an385
>  * mps2-an505
>  * mps2-an511
>  * mps2-an521
>  * musca-a
>  * musca-b1
>  * netduino
>  * netduinoplus2
>
> [I admit that I have not specifically checked for datasheets
> and errata notes for all these boards to confirm that AIRCR.SYSRESETREQ
> really does reset the system or to look for more complex
> reset-control logic... As an example, though, the SSE-200 used in
> the mps2-an521 and the musca boards has a RESET_MASK register in the
> system control block that allows a guest to suppress reset requests from
> one or both CPUs. Since we don't model that register, "always reset"
> is still closer to reasonable behaviour than "do nothing".]
>
> We still allow the board to wire up the signal if it needs to, in case
> we need to model more complicated reset controller logic (eg if we
> wanted to get that SSE-200 corner case right in future) or to model
> buggy SoC hardware which forgot to wire up the line itself. But
> defaulting to "reset the system" is going to be correct much more
> often than "do nothing".
>
> Patch 1 introduces a new API for "check whether my qemu_irq is
> actually connected to anything" (the test is trivial but the
> encapsulation seems worthwhile); patch 2 provides the new default
> and patch 3 removes the now-unnecessary SYSRESETREQ handlers in
> board/SoC code.

I checked the STM Reference Manual and this matches what they expect.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   include/hw/irq.h: New function qemu_irq_is_connected()
>   hw/intc/armv7m_nvic: Provide default "reset the system" behaviour for
>     SYSRESETREQ
>   msf2-soc, stellaris: Don't wire up SYSRESETREQ
>
>  include/hw/arm/armv7m.h |  4 +++-
>  include/hw/irq.h        | 18 ++++++++++++++++++
>  hw/arm/msf2-soc.c       | 11 -----------
>  hw/arm/stellaris.c      | 12 ------------
>  hw/intc/armv7m_nvic.c   | 17 ++++++++++++++++-
>  5 files changed, 37 insertions(+), 25 deletions(-)
>
> --
> 2.20.1
>
>

