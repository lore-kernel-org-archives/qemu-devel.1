Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E183C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A84206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPpUDBby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A84206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEf4-0007cL-0N
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiEe7-0006vg-76
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:04:47 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:45869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiEe5-0005rZ-4O
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:04:46 -0400
Received: by mail-oi1-x22d.google.com with SMTP id p70so14706375oic.12
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=AhUImpmSB9pMI6/G/at7Xga5V2tbBswdnZrQDUlZSUw=;
 b=qPpUDBbyz05xoqkjVxLYBxGt7EEOJjpiTaD6MQ20lZrMt8fI3w1dQDBWliS6q2loo/
 5DSXWT3+gOsq7tZYfuJzlRVtgqrIzsSTK3ZE6H/Rk5FmDmnS4ijLXK0WQfL/pGe83ceR
 j0T9Egw4zl7n/OPEw9xkw5OYVs1eIld/0VPKXM90J+HplDCfMwgf7hdQLpzVeCKavqGA
 tbgHKosMQQyxpELuYA0AHdrnKo4oRctAH/R4d0bvhKBP2uDRwxNFY+5B5nA1k+AA/ZfD
 ifHwUa9eMDn6tGDYYRFQk//Y9BogGf4J+WL9n4F/L0MUV7tZFGkfZwTjlrn8OT6swCY/
 1i6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=AhUImpmSB9pMI6/G/at7Xga5V2tbBswdnZrQDUlZSUw=;
 b=UUGCwWv8pSUOImRdVR3xenvtdR3RmMghfq4K0rHJOSL46MIFmtnolHHfZNc6bEGt2B
 miHBdHIiuUMtlG3/Kl1jSCKu/G2nUZszIKb8LO70VDbO/kyhCmwkrMpdrwbAj62lhlO/
 jOaTYuirb5M0OTr04ooXJB9GsZ7FOd4+SJ8kIop/khrE/6d4xq3yf6yk5k5Yw6iHlbWN
 85HORbq/lMn7iIrb55rf8jCTxUwwsm8x56OiM/zfPZLYBONlu31nAZAF2Z94QzbdTBm7
 aRAJ3bb0KDn1Mii8gZc9beEwnaYV7gvujGLOn+S766zWDi6g7+aaHwnnWjTtgbH1SxZH
 9PUg==
X-Gm-Message-State: AOAM533JP6gKa7XBKgKxh4Yc5HW+0i987i//HRJtaw3Qkv6Wk6HwjtFD
 SwbVJdyHx5okLghGW5FMsz82L0qD8Wwdl4J/7yquOGNME4Q=
X-Google-Smtp-Source: ABdhPJw+qCm32gTIrVcnv6RV6U39/5PmkPmOzgVoZpGG9AWk+UdX72OOrukmdGcxlFLFjF7Lg7+mW/AsvG64c1YcjaM=
X-Received: by 2002:aca:5152:: with SMTP id f79mr9642097oib.146.1591610682785; 
 Mon, 08 Jun 2020 03:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200605165007.12095-1-peter.maydell@linaro.org>
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 11:04:31 +0100
Message-ID: <CAFEAcA9+DgvsYo738bEVeMrZGe3OcXC32wG2Bs2ivyE8+r=weg@mail.gmail.com>
Subject: Re: [PULL 00/29] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 17:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Arm queue; some of the simpler stuff, things other have reviewed (thanks!), etc.
>
> -- PMM
>
> The following changes since commit 5d2f557b47dfbf8f23277a5bdd8473d4607c681a:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200605-pull-request' into staging (2020-06-05 13:53:05 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200605
>
> for you to fetch changes up to 2c35a39eda0b16c2ed85c94cec204bf5efb97812:
>
>   target/arm: Convert Neon one-register-and-immediate insns to decodetree (2020-06-05 17:23:10 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  hw/ssi/imx_spi: Handle tx burst lengths other than 8 correctly
>  hw/input/pxa2xx_keypad: Replace hw_error() by qemu_log_mask()
>  hw/arm/pxa2xx: Replace printf() call by qemu_log_mask()
>  target/arm: Convert crypto insns to gvec
>  hw/adc/stm32f2xx_adc: Correct memory region size and access size
>  tests/acceptance: Add a boot test for the xlnx-versal-virt machine
>  docs/system: Document Aspeed boards
>  raspi: Add model of the USB controller
>  target/arm: Convert 2-reg-and-shift and 1-reg-imm Neon insns to decodetree
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

