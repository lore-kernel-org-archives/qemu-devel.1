Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861B8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498322067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thyxRV2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498322067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jko9o-0001YA-JZ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jko99-00010H-R5
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:23:27 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jko97-0000p1-32
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:23:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id e5so12896747ote.11
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eaDE4ZYdGzsV2wxB6szKgCsHjBiotD7bTkZ0++Hm7DY=;
 b=thyxRV2pZlkrvTA2y/77D4Wf2+GWcl0VaWYl+6ZtgakOEwv2EKrOHLYxpY3PzoNFQr
 JRUGqINYjI7x6GoVHpDuJ2N+WxjxWXkkh3v7OyzTNPVHwc6PpFL0XBAghioyL84Xjb3D
 zrDJYYJ+cScOHmEqQozBqscenB9G2pvMfVdfEv9mYzZyVZ1HW/plUwyr9xPVzkBe2VIG
 Ig0nsahxeKKxL44z4SuWJeDhP1vbu3HwTmMJvsn6bgObVBoIkFGJqEpPJAKKkLxOBu6S
 blxC9F2h0kWuCkpwi+woZUMbs8PbhpffRxqa2jo8uzTMKjX9FX74I031wKAcCBKxwvCl
 ptlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eaDE4ZYdGzsV2wxB6szKgCsHjBiotD7bTkZ0++Hm7DY=;
 b=sq9si91uc5YYUb7R2A/+hNvPGjnF3QZtTIxD+H3yJSTgNOTS55+OISt98RIN8JMKXr
 +LlG8HnFAHOEpjzd2aZUPCdW77QyVLPrd24RrM5xwTRfIMJSuwCqKvnHcunrp1vfSEnk
 hoyyAje4+kEawatZSvMM+aAPliduYg1yJqFzR693MQLLyVAsX9RnABZdiadlMga8K7Bf
 h7cYFABiXodnvzFrMqsdbE6ShsNjVUH3pLCw0wTNBssvxznwmEmIXVOiDu9dvZZK3x9Z
 HIKUEvY+bgF95jYx1uxcJCvDVbkZPGM+30qYWDj6Un2mccyKtQjdoukKhkP1W9q4o2DZ
 fmtw==
X-Gm-Message-State: AOAM532OmlqBNfeFmbnKgkyvI8kDZdJP/wHtHkRoRA1jvU7o8DABuR21
 8/qLV+/SWpryUo1CgP0MOFJkbVS4qLTQZCGuYQt6gg==
X-Google-Smtp-Source: ABdhPJzjV8S7v9To7k1rY4P01YNuhANMx5Dzon+P2jKwAhg8l1f3T+Vw8xg+30oZq0oLDr1x1YyFjuzzsZiCHYLz+yk=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr21753266ote.135.1592223803661; 
 Mon, 15 Jun 2020 05:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591272275.git.jcd@tribudubois.net>
 <a6223b7b5c1564afc5fb3c2a9ad514bdb41be5a5.1591272275.git.jcd@tribudubois.net>
In-Reply-To: <a6223b7b5c1564afc5fb3c2a9ad514bdb41be5a5.1591272275.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 13:23:12 +0100
Message-ID: <CAFEAcA_b0k4m29NqU82GC2xvjQXTVkYWQei8hrG2fxjQAcgc0g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] hw/net/imx_fec: Allow phy not to be the first
 device on the mii bus.
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 13:39, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>
> Up to now we were allowing only one PHY device and it had to be the
> first device on the bus.
>
> The i.MX6UL has 2 Ethernet devices and can therefore have several
> PHY devices on the bus (and not necessarilly as device 0).
>
> This patch allows for PHY devices on 2nd, 3rd or any position.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>

> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index eefedc252de..29e613699ee 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -280,11 +280,9 @@ static void imx_phy_reset(IMXFECState *s)
>  static uint32_t imx_phy_read(IMXFECState *s, int reg)
>  {
>      uint32_t val;
> +    uint32_t phy = reg / 32;
>
> -    if (reg > 31) {
> -        /* we only advertise one phy */
> -        return 0;
> -    }
> +    reg %= 32;

This change means we now support multiple PHYs...

>
>      switch (reg) {
>      case 0:     /* Basic Control */
> @@ -331,19 +329,18 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
>          break;
>      }
>
> -    trace_imx_phy_read(val, reg);
> +    trace_imx_phy_read(val, phy, reg);

...but the only change we actually make is to trace the phy number.
Surely if there is more than one phy then each phy needs to have
its own state (phy_control/phy_status/phy_advertise/etc), rather
than all these PHYs all sharing the same state under the hood?

It also sounds from your commit message as if there isn't a
large number of PHYs, but only perhaps two. In that case
don't we need to fail attempts to access non-existent PHYs
and only work with the ones which actually exist on any
given board?

thanks
-- PMM

