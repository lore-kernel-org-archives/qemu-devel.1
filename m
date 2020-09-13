Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422B5C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 21:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A821221EF
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 21:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUL4q0yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A821221EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHZat-0003G7-QR
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 17:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHZZv-0002ct-O3
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 17:30:32 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHZZs-0004lt-AE
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 17:30:31 -0400
Received: by mail-ej1-x641.google.com with SMTP id i22so20418989eja.5
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vK2X+o8o2zwKeJ7g7E8ifZ1WGmpjcucsAYSvxZ4bKb4=;
 b=QUL4q0ynB6JN7t+fLGd8GOJqiar/D8WnET4TvrkSNRdOR8AtU7Mxy7tbR22rIuoGCm
 xivv6j8nD+9n7dp5Lme4f1XLw3A5jnvj01RfdMSJKpw17sncnTGlR1g2yzojhfyVpM6g
 HHGstt3tihqptX1+OoZc42mTKl5OfFO8bBAkiXwB+QODb0m83KPj8MY5r5F+YKvBnrzy
 /sIS0a+K0O53V7RN3k0IvBsnAvtd4U2m2cL5HpFAnhExiuGYDKVromo3Cs3ee3SR+HlM
 N9OkIdLQNxM625c8etdcPNSgW8OXl2S0UMtR5BxZqYsdR8B1apkO9L0/rAW6E/6y7o/P
 U8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vK2X+o8o2zwKeJ7g7E8ifZ1WGmpjcucsAYSvxZ4bKb4=;
 b=g2UflizRPSulBqVqbgo8QAOBtwEWU8s4wy4swEQ3+Y9ie8LCbcUL6Sp7Vi4pFaECcb
 GWX8fFO1+vaf3Z8HNIHfhHntTZB0wQoPqWp6fkWd1GZRKcCFtEAiTr7SW5YsZ8T712ft
 pkYhgqwHistlwkG2S1or2WoQmRqURQVY19/OahKCHlu9bRh7u11c2tXalHNfgWEaWFil
 eqFdEPzS1o4cbuWWKTB1Ui/gDtFgT0EzABjFOafxckrJ5ZCqUGhxvkz1RH1qQQ4nvy05
 1U5Vz1S5T33nRoyDJZSL/wz2liJJP2juJCmahOHZCyoU+v2yS9eePRWUqs+0dD/Wa/KU
 X1pw==
X-Gm-Message-State: AOAM532QNZTcsZv1jZXDqIYBd8TVzf+/kVswkk76KUyNwp5OQO4a2Bt5
 Ixf/xyY527RgHK72q18viAtzuzU9jPO3UQ2yvyUvEA==
X-Google-Smtp-Source: ABdhPJwvk4WdTs8HsVSQmxNTg0poSn9S9xCtoA8LSRoxmI0zz7IQ5dsWnTDzItlP1oslZBK0T0HIbH3YC6kJwNIQtPE=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr11422902ejr.482.1600032626618; 
 Sun, 13 Sep 2020 14:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200910180938.584205-1-alistair.francis@wdc.com>
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 13 Sep 2020 22:30:15 +0100
Message-ID: <CAFEAcA9e5kcRxO0zRmRK4QU7WfF=yWTM8JDD=26CyHkSdtqfKQ@mail.gmail.com>
Subject: Re: [PULL 00/30] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 19:20, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-pull-request' into staging (2020-09-08 21:21:13 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200910
>
> for you to fetch changes up to 7595a65818ea9b49c36650a8c217a1ef9bd6e62a:
>
>   hw/riscv: Sort the Kconfig options in alphabetical order (2020-09-09 15:54:19 -0700)
>
> ----------------------------------------------------------------
> This PR includes multiple fixes and features for RISC-V:
>  - Fixes a bug in printing trap causes
>  - Allows 16-bit writes to the SiFive test device. This fixes the
>    failure to reboot the RISC-V virt machine
>  - Support for the Microchip PolarFire SoC and Icicle Kit
>  - A reafactor of RISC-V code out of hw/riscv


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

