Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1060DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFDC20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhlBEo4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFDC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuP2-0006Xw-3N
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyuNI-0005G2-1J
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:52:20 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyuNA-0002tC-7t
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:52:19 -0400
Received: by mail-oi1-x242.google.com with SMTP id 12so7561021oir.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jyzty+WAdV19z+dNer/461U7cKVrDErw51F9eQQ79dM=;
 b=hhlBEo4NTZglWEunSJevi3PURKkDIQ3II1I+3CWw5jO/g/HG5cm17S482jgLrMDYlg
 gKYGw0cYO5kT04l2U1tX4GLxrfDu/janBZhFUjFPrmj8aPIUu6x7Vei82v88zXR8bzQv
 +++G+iVmjg0D6knwwdLzOVkyBDtw292xb+P5fiiKiktO8UWBKqtFxGxcd1hdkytn4BJs
 wGj1/RRIRvJ4PanUlwiCpK2aSh1I0O/Jc2MaBHiBXKo7oUng8ExteMDyfWUpIExawNiC
 iDnSvHjJZ507FQMOmnaxlbKOsNknvn4wX5XT0C+DiZdK85e1dw3T8ObXU8J6r0XAxpGR
 jKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jyzty+WAdV19z+dNer/461U7cKVrDErw51F9eQQ79dM=;
 b=XLx+iE1jWABK0mOphDo+5wgsn1VGWTSuMxV2qbv306WxRrDNnP+dNcyngJmbvHXLWJ
 g3Q9QxV7B/yQhs4WSPjJI4Xd8+9jg00CbqMnOEDzzUuWKNVBjMyR7s9ONfYs0SICPDVX
 c5b8Z0L2ME+pkmTaXHeBDLf4K5ks1QAeuJ4Y3TQ2E9fm5tz94TiurHW47w8APbfHo8F7
 WuIVWrKmy/oNMGqtOrpp/HtuhABfy2bjmKNymMHxShHyNtaAuP79W+KTRIj6+hNCzMp9
 yIV/YwBID+c+y9+yMkHeEs48Csb+pBOztCXWCL86AoYQCMhggJhQ8SXDJ4+CDggGLHC6
 f1AA==
X-Gm-Message-State: AOAM530gzPeijFCL6jKBS2AoZm6v97FCSCV9/REK0AF41q14OifI+UIs
 QtTNkdrQaQgkuygB2NNfJmPWBYy2C6SM+9v9zE9pZT1S
X-Google-Smtp-Source: ABdhPJy0M9ThO7TkUAp/6U02iHIXJBXYuPryf1VWCHoAW1F7h1jT/UClvFghVRq0Mej4oz0amXnTE3uSqgxRMyYKvrA=
X-Received: by 2002:aca:2819:: with SMTP id 25mr6861324oix.48.1595584330774;
 Fri, 24 Jul 2020 02:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200722164838.1591305-1-alistair.francis@wdc.com>
In-Reply-To: <20200722164838.1591305-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2020 10:51:59 +0100
Message-ID: <CAFEAcA9H2EGfGUsojPwZLya22Tk4jsKuiry1EoN3y00DCz=Xxw@mail.gmail.com>
Subject: Re: [PULL 0/5] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jul 2020 at 18:00, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 3cbc8970f55c87cb58699b6dc8fe42998bc79dc0:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-07-21' into staging (2020-07-22 09:13:46 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200722-1
>
> for you to fetch changes up to 8ba26b0b2b00dd5849a6c0981e358dc7a7cc315d:
>
>   target/riscv: Fix the range of pmpcfg of CSR funcion table (2020-07-22 09:41:36 -0700)
>
> ----------------------------------------------------------------
> This PR contains a few RISC-V fixes.
>
> The main fix is the correction of the goldfish RTC time. On top of that
> some small fixes to the recently added vector extensions have been added
> (including an assert that fixed a coverity report). There is a change in
> the SiFive E debug memory size to match hardware. Finally there is a fix
> for PMP accesses.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

