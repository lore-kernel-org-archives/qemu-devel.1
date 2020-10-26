Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D866BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4946622265
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKPyYDx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4946622265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6hO-0000jc-D2
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX69Q-00081P-2v
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:19:21 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:42677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX69E-0008SI-7z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:19:18 -0400
Received: by mail-ej1-x633.google.com with SMTP id h24so14733616ejg.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u1X3uBwS2qZ8jbsivQ/HRseVrRa5gN7qWeMUp5zhAtE=;
 b=jKPyYDx6oflaz+c0xYN26agkuW28XDtf1RJoKjToNNokIVP2AAh+9A0nWBPakD0FB/
 KoyAn65hBHqccghQ/+ZeMnAkk0BWKmWpnYUR37VNLgznp4SvewGsGA69G2rxX7JhIjGW
 UldZcNRG7vBsqZFuGHc+4UgBBDVhq7NoUWbM5J9Y0wTtdT9edhxbdysDickOsQAlfjeG
 ydd9wejRyQMKtXesstYInaV1Rn+r6vd9tl9y3DlhdxO3Z2qMSMLONlWNYkaK6uwcgt1w
 +Lwr5LFoY0F1BsisvMo0YwKpIsw8vDIVy30RhD6rW0hQ/EfcAz0i1Q3aYePQn9Y5mTDG
 rHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u1X3uBwS2qZ8jbsivQ/HRseVrRa5gN7qWeMUp5zhAtE=;
 b=deLCN+qkag38ZZFmjwrtseRNn+64+CHXHUiODzbSzaVTYTT8WJC0+Jt/BUCsF8fXxp
 dlUgHYDQLrm6iJgnYAH+FJhS1XJkqWKPyHmKXYWDH99lhja6yK/s6Gpm+UkYlH+OtXA+
 1LCCLbtXqhNih29RzNpI8eu50vA805cGhkJsFqk/4Avoha0VtCVMWe1YzaBCLNzEVKef
 OV3bJXwie0w4cxOHoZ6o6cZfM34tD1mPIC16hLrGG1I3nggjTYhO+XPPpamfRr53U7p5
 tiJUQksIKOHc2qCNjw7vE2QfiG5Fb/NRFnMI5Ju0mhmLqUFWSY/VgDjG3uXsQeCJ10XK
 wFlQ==
X-Gm-Message-State: AOAM533pm+OFoK6bOOJiXtL+8boUAQdRX3iAiZdZsO5+GmA9pwDcfBWT
 blWgJcu6RKX3I9wJXPWugMCL/2mYHrbZ8ARMUBU7ew==
X-Google-Smtp-Source: ABdhPJwDmZBopxxzARlOzuchzojUZbN3rJh80I8wRK/vZ1VX55Ixkkc32hN8i5hTEPTimSCU4f4JYlz6NKa1Br5Ou/Q=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr16613621ejb.482.1603732745498; 
 Mon, 26 Oct 2020 10:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201026135131.3006712-1-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 17:18:54 +0000
Message-ID: <CAFEAcA-WscaYcpooMQ0F2Etc+Rzf5M=Bb-b9Dw7pGsaaO8Od=g@mail.gmail.com>
Subject: Re: [PULL 00/17] Build system changes and misc fixes for QEMU 5.2
 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Oct 2020 at 14:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8b0e484c8bf82e07bb0439bff04e248c63cdc86a:
>
>   machine: move SMP initialization from vl.c (2020-10-26 07:08:40 -0400)
>
> ----------------------------------------------------------------
> * fix --disable-tcg builds (Claudio)
> * Fixes for macOS --enable-modules build and OpenBSD curses/iconv detection (myself)
> * Start preparing for meson 0.56 (myself)
> * Move directory configuration to meson (myself)
> * Start untangling qemu_init (myself)
> * Windows fixes (Sunil)
> * Remove -no-kbm (Thomas)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

