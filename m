Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57D9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910B02072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0FtSt16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910B02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbouP-0002HH-Of
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbocg-0002yU-Ta
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:04:46 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbocf-0002YH-Tn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:04:46 -0400
Received: by mail-oi1-x241.google.com with SMTP id d191so6776561oib.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IVvQ4BnC7G1Cm6dall93+lmFqFNZBQ6yoJcC7Zbwr9s=;
 b=M0FtSt16hrFEPgUdCTy68KJLezgkuLQTTwU5Y93/VSYIMXN2l9Q+WL8IrNswX/NQjD
 fYtm8awR4R5FEgSQtbYGXrnUkqSwu+0EHmFevRwg0Q9Dz7+QD5Wcmmv1DeyfEp4kXiwy
 p9K2uALB+4EaYYI8WjJI9nHuOR33vy27HABY1MfrRyMehtGXzMd5JBJPRn7VTh5I+YEw
 xa2ABFFg/mUxZyffs7ou4g+y4ot17gmYDx5NbLCuAmFg3Vh7n777SB+SuHCCRT9nq30K
 Fs6cJxM3h2NacmzHJtjZ83vwpuztjoe1kzPSWbjASbvNMp93zy9ANeKU9SPYZ0bIo2jb
 +ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IVvQ4BnC7G1Cm6dall93+lmFqFNZBQ6yoJcC7Zbwr9s=;
 b=Vv99aLrtcexfYeyVhJ87VyfywXwuIIRKpltqPwrd6ThHEG4ekvP+HwFt5p+RdPPqHs
 cLKqZAXTVpSXjZVZvnTEdlNsGBgVWHBrpz+i+3uEVnmoWIAZCIQX+Na9PwfZ0M2ooF79
 U99PkxcI363p6fQGp9zJIIg/U9m513jQLcOagOvszKlKYoAhcNC1jmLKsvg/hjamrRMC
 rOGnYiizlEJHAWKiNlY07BCOepkg0Xlq7mTcIQn7kTisJG4w48Td/hKaQX0XF6g8Hb1d
 HmGHgtENBdfFD12Q/Zy/KZpbw/PgkbvABr3GObW3oxDsNcugeCxq0p7sB3CthwxneCPK
 keQg==
X-Gm-Message-State: AOAM530Q5xhG2ZXIAK4/kwmrL6RIqcfj+qztdomXdw473/7ddoPyWVG3
 IHkdhb2xUo1blGO3hyITOu6vviri2oTx+uM1gL9WLQ==
X-Google-Smtp-Source: ABdhPJy0mXP6dRz5tVVsFZR8am4LIiiwaXSXbLuLaz+JWVZBsTvY5umqyRZzM/ADOM/qzWVE/B9Mu3glGxpfyFV8zh0=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr6872783oih.48.1590080684653; 
 Thu, 21 May 2020 10:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200518142801.20503-1-peter.maydell@linaro.org>
In-Reply-To: <20200518142801.20503-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 18:04:33 +0100
Message-ID: <CAFEAcA8TDGUX-3x6Ha9skH8rO7mWEXzrDPYvqe=e2+yTiOQ1eA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Allow user-mode code to write CPSR.E via
 MSR
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Amanieu d'Antras <amanieu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 15:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Using the MSR instruction to write to CPSR.E is deprecated, but it is
> required to work from any mode including unprivileged code.  We were
> incorrectly forbidding usermode code from writing it because
> CPSR_USER did not include the CPSR_E bit.
>
> We use CPSR_USER in only three places:
>  * as the mask of what to allow userspace MSR to write to CPSR
>  * when deciding what bits a linux-user signal-return should be
>    able to write from the sigcontext structure
>  * in target_user_copy_regs() when we set up the initial
>    registers for the linux-user process
>
> In the first two cases not being able to update CPSR.E is a bug, and
> in the third case it doesn't matter because CPSR.E is always 0 there.
> So we can fix both bugs by adding CPSR_E to CPSR_USER.
>
> Because the cpsr_write() in restore_sigcontext() is now changing
> a CPSR bit which is cached in hflags, we need to add an
> arm_rebuild_hflags() call there; the callsite in
> target_user_copy_regs() was already rebuilding hflags for other
> reasons.
>
> (The recommended way to change CPSR.E is to use the 'SETEND'
> instruction, which we do correctly allow from usermode code.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

