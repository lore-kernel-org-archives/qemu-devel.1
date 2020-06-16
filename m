Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B16C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D260F20A8B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVlBJWT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D260F20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBm1-0002e4-3a
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlBl3-0002BY-JK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:36:09 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:33993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlBl1-0008Ib-A1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:36:09 -0400
Received: by mail-ot1-x333.google.com with SMTP id n5so5302906otj.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=HXDYg40Tcw2v6MIHO423jnwkFGWvCks+1VuhhHRf/JA=;
 b=NVlBJWT+VvmLE5ZSDwxGUhWpKgBjCgzq7WZVjwGngeSL2BIOKIhorNRKlWxekbmIMa
 ZyUoP8TSpXNuqtJdVq5yBVNJ9N9tfXy16qYlDmk6GDt50PooZMTNqruOAsCGcuGsyJrS
 8w35hnL/pk4Sn3fGH2Gqi0OEMMDXoGPRCAazS1G5rDrRlF0NctFQoB2Frkjd0rMEBMhw
 5Ihqw8TdII78Uy2zA3byF9B0D9AzI6iyLkQH2380m3RI5XnQKSdBRatQvAxwlHkIptLd
 8Bm/RSO5GEY4iHRCNbXj4fvetSQbFvuzL9QBGkCg7aJOYVrwfvpYgJCRxeN8m7Vca6Cr
 r1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=HXDYg40Tcw2v6MIHO423jnwkFGWvCks+1VuhhHRf/JA=;
 b=T7LupcXOKnDZNaNOmUn7I/fxTFQvIQlDO79S35dXhOxjFSXaa3n2KjPtTcjdJbcOdB
 FeCtm6BGPhppufcBLwg+41FweABdK0yLcjDS/zkGBI8UEItBgS13biiOIyjOr8m3wlvi
 s2GPZi2MYukT2wKc01tAKiKCN2NRHhmUmR3Sve/9nSGaJyax7lt+0RFEpjXEE53fkBG7
 HuR7FyYbxCJbhcyqqTfRzo0DnZXeI4p9mSAdpDGifr9bcxMT6waq2KhtrqkxJZHNoef0
 FuiJk4Td0uQTjOs3goWbms298swKaKuteUZUHRLwx8yzpBmjPMCdz4mGJ1HFLJYPzuZq
 Mklg==
X-Gm-Message-State: AOAM532YIiE0GOyQeP8hqtGH30NQNIsQfeJivo7bxIbGozPCS5AQOjAb
 wHc1YXr+JSg1l9bT1f+l1THXflVjpkHnligGCF8QazsCP1w=
X-Google-Smtp-Source: ABdhPJw2fawBCDQ1XxzN+AlIGlGfaR2p7pWXMTNqkgdZobVOE+Viy09z0cYCWdO2WhESh7kQd9Rx6IFmwLH1TrD4pxg=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr2400103oto.91.1592314565675; 
 Tue, 16 Jun 2020 06:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200616095702.25848-1-peter.maydell@linaro.org>
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 14:35:54 +0100
Message-ID: <CAFEAcA9xkLHTudUiwuMAeSEvvysPHTTVhPra+KZswamvj-oEoA@mail.gmail.com>
Subject: Re: [PULL 00/23] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Tue, 16 Jun 2020 at 10:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Mostly my decodetree stuff, but also some patches for various
> smaller bugs/features from others.
>
> thanks
> -- PMM
>
> The following changes since commit 53550e81e2cafe7c03a39526b95cd21b5194d9b1:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-request' into staging (2020-06-15 16:36:34 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200616
>
> for you to fetch changes up to 64b397417a26509bcdff44ab94356a35c7901c79:
>
>   hw: arm: Set vendor property for IMX SDHCI emulations (2020-06-16 10:32:29 +0100)
>
> ----------------------------------------------------------------
>  * hw: arm: Set vendor property for IMX SDHCI emulations
>  * sd: sdhci: Implement basic vendor specific register support
>  * hw/net/imx_fec: Convert debug fprintf() to trace events
>  * target/arm/cpu: adjust virtual time for all KVM arm cpus
>  * Implement configurable descriptor size in ftgmac100
>  * hw/misc/imx6ul_ccm: Implement non writable bits in CCM registers
>  * target/arm: More Neon decodetree conversion work


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

