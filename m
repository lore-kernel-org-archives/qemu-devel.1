Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8656AC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 10:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0D920708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 10:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9vN4yWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0D920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTjka-0007Zg-A0
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 06:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTjjE-0006ql-5O
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 06:46:24 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:46787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTjjC-0007GG-49
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 06:46:23 -0400
Received: by mail-ed1-x536.google.com with SMTP id 33so5282292edq.13
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vyzUBl6qaWvPTq7/dyP0/sP/smhUCbh0Kd8s7L+ZsWo=;
 b=F9vN4yWbHYLSIfUh/TZIdY5p6jGm4jDcy7KtLyJLhFKYG0tc3cisN8ku4r/a/YJ5Ff
 ircV4FkFoEjiwq0Y9lDYUVLONYEhnAyXYl5Rs081gVGYSBejOVCeqE/+hIoh1UwSui5r
 +JpzAWxLC8+xJ7khumphiK1/J84CBOlhWM0NOdBUtuQpVlopuBoMlDSS6SLcdyg+NKbA
 H5jJK6uk/apP3RN0wRGLZ21IO0tobPwLKXfRRVS8RIxFdhR7Wpi3FYwW/hOvwk8KJPW4
 tnqeKpu6BV7rno3JzixQV5FUeTdEuI26W3Qkdx7bhSIpXOyj6N2KIY4cSaZgNSufdtxC
 /eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vyzUBl6qaWvPTq7/dyP0/sP/smhUCbh0Kd8s7L+ZsWo=;
 b=Ucz8twd/DHEvLw7hkiX/SEDTykADAfj+zWb1yVodOcSyI6TjCv8aeANdR6iEJyyZmm
 gLDE1No2FLCORnlI54A3IBzxcKyCs1iJQxVcrPpsjytTW0Kod58P2FyLQchPtOOXyby4
 vyfKPlUnDwK7nMmDROAqXPHxb7RavainkvBdyC4vjoDCBYs+nk77zL41Yjnoz0YowAC7
 kn/A+DD72j2UBmejLsgq6xbMIjrtBub/r/kZO355pZBYeXb5LlcekFMRj7rO/GXIIju9
 hxyOgFzkjdX/kySPreGipYHosDclWjxWPNRb1B/sZGzpJgdp2HT9Y+ywwvCCQQEfMMgi
 pGHw==
X-Gm-Message-State: AOAM533896He1S63EddYH3w/q0yLE5jFSxpp3HLIE/LB2LCIl3/Y0nP/
 +wlS13rP/B3Y0nPQa/mxrcruRxZD88c5OCLkV9JD6w==
X-Google-Smtp-Source: ABdhPJwH/ll9WOmbSO7zvgl33YL8vs5rBMwCgrDbzMwG5eyfQsSuiLNRorqfLWqYwzZZ0SlwVrmS2r2yOJDUyZ85X38=
X-Received: by 2002:a05:6402:3133:: with SMTP id
 dd19mr8943279edb.100.1602931580216; 
 Sat, 17 Oct 2020 03:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201015164501.462775-1-ehabkost@redhat.com>
In-Reply-To: <20201015164501.462775-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2020 11:46:09 +0100
Message-ID: <CAFEAcA-YU_eZxdc+491Uve_ZBTh5U+MoKg33u_xQrE=mVffEtQ@mail.gmail.com>
Subject: Re: [PULL 0/9] x86 queue, 2020-10-15
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 17:45, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 3e6a015cbd0f61c19cdc02d5ce74a3e60235cb9a:
>
>   i386: Mark Icelake-Client CPU models deprecated (2020-10-14 15:28:55 -0400)
>
> ----------------------------------------------------------------
> x86 queue, 2020-10-15
>
> Cleanups:
> * Drop x86_cpu_get_supported_feature_word() forward declaration
>   (Vitaly Kuznetsov)
> * Delete kvm_allows_irq0_override() (Eduardo Habkost)
> * Correct documentation of kvm_irqchip_*() (Eduardo Habkost)
> * Fix FEATURE_HYPERV_EDX value in hyperv_passthrough case (Zhenyu Wang)
>
> Deprecation:
> * CPU model deprecation API (Robert Hoo)
> * Mark Icelake-Client CPU models deprecated (Robert Hoo)
>
> Bug fixes:
> * Remove core_id assert check in CPUID 0x8000001E (Babu Moger)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

