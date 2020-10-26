Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9142C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22DE2070E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWzEIHvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22DE2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9LW-0001CS-RE
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX9KM-0000kA-MR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:42:50 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX9KJ-0002yX-DP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:42:50 -0400
Received: by mail-ej1-x642.google.com with SMTP id p9so15728387eji.4
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=iU+ZRCG+AFRiE68g8Pl07JSs3G5DgNs8ih7zug8A1HQ=;
 b=PWzEIHvPW+VznJn19AVD7Bx+08i5IAOS2/6PE9JbTfLk6xl/cwYiX64tlup1eXpJF1
 jirFSe4y4RBvPOT101PHq5wwsVROBTjiJ6dZR6z397LnMnhPlx7boOid2NNVJFbI0mki
 n4Fo2lX3swyRIjT07qrxui8Xpln1JCdxpJqORpQp66ISL04KzeVITlDNEwDcdmwBVoUw
 AgWpdXUcDl1EUGNVfZ7d7J/XsGNm/Q9VcS9SXvMPj7T7IAbELTESHuFw5ulQ54qIoOb6
 6kBlVO/foCIVb1cQVx++WO38bcZDlNG16Va3G0A0IrMilTjo7bUPfDT3N0F8k+H7d312
 uR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=iU+ZRCG+AFRiE68g8Pl07JSs3G5DgNs8ih7zug8A1HQ=;
 b=LCAGn0g96Q/SLfimmguyXSbAyM6rjFzxcrIRou9aRoKtmQMhDQjfknObIGyjAN+ovL
 anTzGSj3C8zPJSkPAMqDf5uAUSTp2PxDPxZ6D+/lVH51NmnMDJZDVVLGiwofgwKQ8J4f
 2/3kMGGNqYUcoRyLCSC63tIys/AhUe2FpG9DplJEOjgYJdOQW9H0gCS/0TrJvC423av+
 87qzTIWIzPNL8QIOIInElzrH1kAs5g3puY05ge+VFU+eS0yLzoppuqvcSEFV1lBwW2wE
 G680/OcjP5anmCOCmxxNyTrmZN2leJ5vu9yqtzjDUe2GNGFeNQ4WlSrS+KsD7d4Z6t3Q
 KhgQ==
X-Gm-Message-State: AOAM5323xq+15++tyLF0hkMsNYD8ZRrY+S5Pk49vtr2JKB2zhQDQciNk
 VtId1kxwSxkLkxoDzpxypA0yNogrWKydrrPlLl0MZ2r35eM=
X-Google-Smtp-Source: ABdhPJzzJInurkN+I5jFNa5W7sVXhw5ctJ/TP4zXCR8hieW2KkkrM7oBdsnBPAlLtdjxChmpXypLWGqasTbWWq+DrNI=
X-Received: by 2002:a17:906:af8d:: with SMTP id
 mj13mr17134664ejb.85.1603744965414; 
 Mon, 26 Oct 2020 13:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201015151829.14656-1-peter.maydell@linaro.org>
In-Reply-To: <20201015151829.14656-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 20:42:34 +0000
Message-ID: <CAFEAcA8g-n4gqy0Az7cBsQJqcQpsc_vH2=VatqqdRt034YD5JQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] armv7m_systick: Rewrite to use ptimers
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for review ?

thanks
-- PMM

On Thu, 15 Oct 2020 at 16:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patch series rewrites our implementation of the armv7m systick
> timer to use ptimers.
>
> The armv7m systick timer is a 24-bit decrementing, wrap-on-zero,
> clear-on-write counter.  Our current implementation has various bugs
> and dubious workarounds in it (for instance see
> https://bugs.launchpad.net/qemu/+bug/1872237).
>
> We have an implementation of a simple decrementing counter and we put
> a lot of effort into making sure it handles the interesting corner
> cases (like "spend a cycle at 0 before reloading"), so rather than
> trying to fix these all over again in systick's hand-rolled countdown
> code it's much simpler to just rewrite it to use a ptimer.
>
> Unfortunately this is a migration compatibility break, which will
> affect all M-profile boards.
>
> Among other bugs, this fixes
> https://bugs.launchpad.net/qemu/+bug/1872237 : now writes to SYST_CVR
> when the timer is enabled correctly do nothing; when the timer is
> enabled via SYST_CSR.ENABLE, the ptimer code will (because of
> POLICY_NO_IMMEDIATE_RELOAD) arrange that after one timer tick the
> counter is reloaded from SYST_RVR and then counts down from there, as
> the architecture requires.
>
> Side note: the trace from the test program in LP1872237 won't look
> quite like it does on the hardware: under QEMU the "waiting for 1000
> ms" debug printing generally reports a SYST_CVR value of 0.  This is
> because QEMU's emulated CPU is comparatively fast and our systick has a
> hard-wired value of 1MHz for the frequency of the 'external reference
> clock', which means that execution of the guest code reaches "read
> SYST_CVR" before the first tick of the timer clock after enabling of
> the timer (which is where the reload of SYST_CVR from SYST_RVR is
> required).  The exception is the first iteration, where the time QEMU
> takes to translate the guest code is enough that the timer tick
> happens before the register read.  You can also get the timer tick to
> win the race by fiddling around with the -icount option (which
> effectively is slowing down the emulated CPU speed).
>
> Some day we should model both the 'system_clock_scale' (ie the CPU
> clock frequency) and the 'external reference clock' as QEMU clock
> source/sinks so that board code can specify the correct reference
> clock frequency.
>
> Patch 1 is a minor tweak to the ptimer code to suppress a spurious
> warning message for the "timer callback function disabled the ptimer"
> case, which the systick timer uses.  Patch 2 is the actual
> conversion.
>
> thanks
> -- PMM
>
>
> Peter Maydell (2):
>   hw/core/ptimer: Support ptimer being disabled by timer callback
>   hw/timer/armv7m_systick: Rewrite to use ptimers
>
>  include/hw/timer/armv7m_systick.h |   3 +-
>  hw/core/ptimer.c                  |   4 +
>  hw/timer/armv7m_systick.c         | 124 +++++++++++++-----------------
>  3 files changed, 58 insertions(+), 73 deletions(-)
>
> --
> 2.20.1
>

