Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF21CC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 17:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BAC2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 17:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiIDFb/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BAC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Sz8-0002Ge-TT
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 13:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Sxj-0001IF-DT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 13:00:23 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Sxh-0008Mf-JE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 13:00:23 -0400
Received: by mail-ot1-x332.google.com with SMTP id l27so8238366oti.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nXB9Cv4+vnMFrgEgMskTzBJJWd3aWy2ktDJsBIIomrE=;
 b=KiIDFb/iH4Lst3qQudDsGE0bj/v5Ajf/dPCVblWMeutplisNCUM+J+/J91NXjrzoCU
 aCGPYkIEWRmFgFh0Y8n3YEiHfuzD1gjigruNKpJ48gTir43r7P7U4jv+OMldRSVi9Y3l
 7WkbEFOifSMaawkLbWcVKWuRCdIbaDbX6mdBd4BIxIv/VzT/3lzdDPqjKG/sakmDh+dD
 qHFIU9yfU98eKYKiOG9TYd3O4ejqH50a3OENliN+KKwaqRgkzXCDuSJA3FMo/HF1XsEG
 tiesb6RB/wXfyigoxs4sq3K0e7/b9JAK1dypqtYYyyxE66CchMNX8uiwehfagcYRQFWV
 pk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nXB9Cv4+vnMFrgEgMskTzBJJWd3aWy2ktDJsBIIomrE=;
 b=VHR45Vr48XaMTfmrLbvw5m+PPIaz5F/ijky9hTMMMsEqw4bF8DSQqUawQ1w4Eo8AOR
 BmeDM+p7ymTxMVwHz5oZ90rYPCfgKSUew5VbmYlDlOjDpPlQNTTwB1Ts1XhtnPQdScF8
 3+0X4WsOU1wivFDFK9Bz878vBDYtBsKmqpm1vvovahIsc9AxgXPH/4J9Nzqf4o4EJnIB
 nL/k9Ht6UXnTWbpnNTFYOREXHdAEDr8d0SCke8GkvQ+8IQOhE/ZFUGqYzoM8CXTk1Nme
 obyNXPhtEyf7NDR2wQmySuucqNn2OeRCT0TRup+btABrwv5mBrmpSYLn1gSzCSKYEsQI
 5vFA==
X-Gm-Message-State: AOAM533nP65hQRAD1trNYhp+Ov88XEGFm4y8A+TkWgKmBQxQygkT1blm
 t97+z3f9zyfauCDNGApm5bxZ25sY5XMQYam3gOTPqQ==
X-Google-Smtp-Source: ABdhPJxnwejqmd49ehtkzmN9LrgMFZ8NL4khXzdb4Hom0+q2N5rYoBV/0jL9bOJWp0DVotBbdJEwmhKAO0o0i3AaFbo=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24044880otk.221.1595955619920; 
 Tue, 28 Jul 2020 10:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200728123432.501354-1-laurent@vivier.eu>
In-Reply-To: <20200728123432.501354-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 18:00:08 +0100
Message-ID: <CAFEAcA8d_iGpZT1c0W6D7+EhHjHcdL+yjBnC66Jom_aQ6A_Usw@mail.gmail.com>
Subject: Re: [PULL 0/3] Linux user for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
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

On Tue, 28 Jul 2020 at 13:36, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 9303ecb658a0194560d1eecde165a1511223c2d8:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200727' into staging (2020-07-27 17:25:06 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
>
> for you to fetch changes up to 0f6bb1958f3aae0171996941df7fb7ea7536bb12:
>
>   linux-user: Use getcwd syscall directly (2020-07-27 22:05:34 +0200)
>
> ----------------------------------------------------------------
> linux-user 20200728
>
> Fix "pgb_reserved_va: Assertion `guest_base != 0' failed." error
> Fix rt_sigtimedwait() errno
> Fix getcwd() errno


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

