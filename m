Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC0820791
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJXbGOJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0820791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5Wr-0003xF-Ki
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX5Qw-000582-58
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:33:23 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX5Qs-000201-V7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:33:21 -0400
Received: by mail-ej1-x642.google.com with SMTP id w27so14541500ejb.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DI53dgFPkps8h/TY5y041PBMFl/Ix4XWl8lmpI6++jY=;
 b=pJXbGOJ0idyZzT6rBH9Lt8m+PdlZePfNpNtF3gGKrocKmeTnpb/jWDZ9gnaMo2DCta
 42STIfKSSVdvt4LOhvsjRlo3T9eWFYjcpcX+K526bXb8uF6L7oG9Ux7rwerhh8t84mmd
 bQ6Xp7Cjfb5X/Ami9VcC5Yl/Q7GtP1GA1dwoJoJBWmEgcs090Zg2yTeyGBxWycb3ir14
 GS9AEXEnJ1JZNCVL+VLTOz/lB9rEPCkGANsNQNG4aVjPHcYz1oY14eCy9OZDyIJQsqvH
 ocRndUHoh8lRG29p3i6lI6dAGX3M52TdfF0NZobA1jeHar+lBmU75ZPzdlViuUkS30hp
 kCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DI53dgFPkps8h/TY5y041PBMFl/Ix4XWl8lmpI6++jY=;
 b=FqCCbawqyXMGa5ZHisvrGMr7GyD9tRotB24dxBuwwmY+W72cuvV1klNoOLuDzRzxYC
 jfV9zRSerMh748QIHs15lw1Wgb/HNnYx+wPcc+wrn/2aNaMQbpQIuIIMMynLnvnHRL56
 dHn39Pwib3CQ7EeZnRFHdvM8qbaEYnOhdD+WaGSmKVo4ZsNoBjrLomiNMHlUsRZflsNb
 thAsUmRL2IO0LlgQk8EEpk2scic11BI9B0LUpChAfgh2lFJHXGGG0wSO20GrzgT0NsLM
 iNMl2m4sPRf2K9h6RK452iLPO/JOugAn61TEQLRY0f33+qBtP/Chrt+frYcMuPG70mB/
 AnAw==
X-Gm-Message-State: AOAM5301wHm2Jp3X+ZAPZGoNPRZvsCjBLgdKSyBj6M08PxgspV5bnzoZ
 BVo597JG7iI8kCYZKj84U3N9fYAotZZTApatZSt5VQ==
X-Google-Smtp-Source: ABdhPJx8daC1K6NRey3EgtBUoTNxvZjKTjERiHjtaa1YY45YGcy87G4fqk1JVqemPdf1Xlgu7PGSZA63yRW+Mm/35gQ=
X-Received: by 2002:a17:906:af8d:: with SMTP id
 mj13mr16141276ejb.85.1603729997270; 
 Mon, 26 Oct 2020 09:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201023160057.21543-1-shashi.mallela@linaro.org>
 <20201023160057.21543-2-shashi.mallela@linaro.org>
In-Reply-To: <20201023160057.21543-2-shashi.mallela@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 16:33:05 +0000
Message-ID: <CAFEAcA9AeG6U1rCHuSSJctBafwMu+h1-8x5OgF==QdWs2SBM4A@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] hw/watchdog: Implement SBSA watchdog device
To: Shashi Mallela <shashi.mallela@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Leif Lindholm <leif@nuviainc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 17:01, Shashi Mallela <shashi.mallela@linaro.org> wrote:
>
> Generic watchdog device model implementation as per ARM SBSA v6.0
>
> Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>

Thanks for the respin; only a couple of minor issues left.

General note: you implement WS0 with an external qemu_irq line.
You correctly call qemu_set_irq(s->irq, 1) when you set the WS0
bit in sbsa_gwdt_timer_sysinterrupt(), but you also need to lower
the line by calling qemu_set_irq(s->irq, 0) whenever WS0 is cleared.
(The exception to this is that you mustn't call qemu_set_irq()
in the sysbus reset method, because it can confuse the device
on the other end of the irq line which is also going to be
resetting.)

Otherwise I just have some minor nits about bit operation style.

> +static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
> +                             unsigned size) {
> +    SBSA_GWDTState *s = SBSA_GWDT(opaque);
> +    bool enable;
> +
> +    switch (offset) {
> +    case SBSA_GWDT_WCS:
> +        enable = data & SBSA_GWDT_WCS_EN;
> +        if (enable) {
> +            s->wcs |= SBSA_GWDT_WCS_EN;
> +        } else {
> +            s->wcs &= ~SBSA_GWDT_WCS_EN;
> +        }
> +        s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS1;

These 8 lines are a long-winded way to write:

  /* All writes clear WS0 and WS1 */
  s->wcs = data & SBSA_GWDT_WCS_EN;

> +        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
> +        break;
> +
> +    case SBSA_GWDT_WOR:
> +        /*
> +         * store the lower 32 bits of WOR for now.
> +         * explicit refresh to be triggered on upper 16 bits
> +         * being written to WORU register (that follows this write)
> +         */

There's nothing in the spec that I can see that obliges the guest
to write the high half last. I think you should call the
timer update function and clear WS0/WS1 for a write here as well
as one to WORU.

> +        s->worl = data;
> +        break;
> +
> +    case SBSA_GWDT_WORU:
> +        s->woru = data & SBSA_GWDT_WOR_MASK;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS1;

You might as well combine these into one line:
           s->wcs &= ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
(same applies for the same code in the SBSA_GWDT_WRR write handling.)

> +        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
> +        break;
> +
> +    case SBSA_GWDT_WCV:
> +        s->wcvl = data;
> +        break;
> +
> +    case SBSA_GWDT_WCVU:
> +        s->wcvu = data;
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame write :"
> +                " 0x%x\n", (int)offset);
> +    }
> +    return;
> +}
> +
> +static void wdt_sbsa_gwdt_reset(DeviceState *dev)
> +{
> +    SBSA_GWDTState *s = SBSA_GWDT(dev);
> +
> +    timer_del(s->timer);
> +
> +    s->wcs &= ~SBSA_GWDT_WCS_EN;
> +    s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +    s->wcs &= ~SBSA_GWDT_WCS_WS1;

Just saying s->wcs = 0; is clearer than clearing all
the bits one by one.

> +    s->wcvl = 0;
> +    s->wcvu = 0;
> +    s->worl = 0;
> +    s->woru = 0;
> +    s->id = SBSA_GWDT_ID;
> +}

thanks
-- PMM

