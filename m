Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F94FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410672074A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgCOGzp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410672074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBiKi-0001RE-El
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBiJz-00012V-P2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:37:51 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:46827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBiJy-0007Mc-1u
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:37:51 -0400
Received: by mail-ed1-x542.google.com with SMTP id a12so1161783eds.13
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=53MJDahnUPbN0P9xKBU1hm+aXP9Ho56kl9fpgkafNPQ=;
 b=YgCOGzp+BO55pkBgYL4LU9bHnE7VbGceqopneKrHyLyLOsDHx5ppkP3fDJ2pD/Np7/
 vjusVArISY/6oaODBeQUin31SEKDCOrGZW708Wnn406pB+ZBsBjm5C21hc0AQmW+2Y6/
 HeMOlT08rqLTT0EjNBQyKABz5IGSUYNP5ZkyJl2jhG0TXbmrwCbWrD/szpABSKteasJF
 CCZ9UBuafldgTf3IiBuWUCEVSMx7gyx/3T3njULUHD2cNWK+EodSdfdVeIf3NrULum3c
 iWvTXPeeVt33yfd5A0PtvSZLgWx74fddirJVwxIhn1M2fcOu9KPbUT+V4GRHn4MXQoyO
 ozkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=53MJDahnUPbN0P9xKBU1hm+aXP9Ho56kl9fpgkafNPQ=;
 b=KlL8xmFZ0j8ARNzjLqcxML+hW+3DO61mSmJrXibJQiykExavr30s/j49sAg+dhpW/T
 3+UyeKWnRztcTjyR6g0mwK8nkGXlm6aa7SI9d1OFFAXTjgKI3MM6DbSmFkyTID4r2a3E
 bUU2Gv+Q67eLAW/qoHSg3I+59jrhzrfphMf2H94+l4Rx6S7/x2PZIO40mte21cGG/539
 vkNm2W/3Ry1687JAJoreRIzYB+P9uFpraH21Wwy0vjGYB68TrzAljvV26KeMzLThqC3h
 RyaI389HCthsqtTGJ90qU+v+/uOE3nPc3qs1GtCIaRMJ1qMF7i01OmeW+WIp10RkZ+GW
 3UsQ==
X-Gm-Message-State: AOAM533wJHIP8uiJ3q2GUpniZ+wDgbO4ufa/w/MLh7wdziXUP0j9BUhE
 I5u545ZGXDfjlNRN4uOHuCGpbQ0/jJo0xtNw/LjpZ0+Ub1kVjA==
X-Google-Smtp-Source: ABdhPJzzULXRgbVUJTWXJWKWHUyB7PfpkyxI8R3IwfbyIHeDw1jjUzVluSsTNlB6PUrPZpANsFasAn+rks83bkK3LFc=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr3154032edy.52.1598636267662;
 Fri, 28 Aug 2020 10:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200828092413.22206-1-peter.maydell@linaro.org>
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 18:37:36 +0100
Message-ID: <CAFEAcA_OXnkUrVXBXsgfgHkajgvZdXGKKBh=p=oBgJqwJHgbVw@mail.gmail.com>
Subject: Re: [PULL 00/35] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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

On Fri, 28 Aug 2020 at 10:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Nothing earth-shaking in here, just a lot of refactoring and cleanup
> and a few bugfixes. I suspect I'll have another pullreq to come in
> the early part of next week...
>
> The following changes since commit 19591e9e0938ea5066984553c256a043bd5d822f:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-08-27 16:59:02 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200828
>
> for you to fetch changes up to ed78849d9711805bda37ee026018d6ee7a606d0e:
>
>   target/arm: Convert sq{, r}dmulh to gvec for aa64 advsimd (2020-08-28 10:02:50 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: Cleanup and refactoring preparatory to SVE2
>  * armsse: Define ARMSSEClass correctly
>  * hw/misc/unimp: Improve information provided in log messages
>  * hw/qdev-clock: Avoid calling qdev_connect_clock_in after DeviceRealize
>  * hw/arm/xilinx_zynq: Call qdev_connect_clock_in() before DeviceRealize
>  * hw/net/allwinner-sun8i-emac: Use AddressSpace for DMA transfers
>  * hw/sd/allwinner-sdhost: Use AddressSpace for DMA transfers
>  * target/arm: Fill in the WnR syndrome bit in mte_check_fail
>  * target/arm: Clarify HCR_EL2 ARMCPRegInfo type
>  * hw/arm/musicpal: Use AddressSpace for DMA transfers
>  * hw/clock: Minor cleanups
>  * hw/arm/sbsa-ref: fix typo breaking PCIe IRQs
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

