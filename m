Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F6BC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162D722247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rsirwy54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162D722247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUraV-0000Fl-3e
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUrMu-000689-SW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:08:00 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUrMl-00067w-To
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:08:00 -0400
Received: by mail-ed1-x544.google.com with SMTP id l16so1772169eds.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pA5MaUprdCYMP2TXqV9bLGLaHfHeBjb6jUfhZDJX5J0=;
 b=Rsirwy54aP+qgqKmsrt6Ti+sZucPSA24DGVeSBs/kGyCzMxKSXpv+TZOrRKhXeugbU
 qNRzCf7AmiwP2tZnw5WwpyaN3X1Eo2Yd9doq/gSbY9PR1LZLe0Xr6gfpseAIrIPV90Bi
 01hUHOjP56RD7kwA9g2aMbI32Y319zF4ZDwde6qvhlrrpr+pIsQGjxANgKfAfNH2kwVa
 kExGncG+DyITBfC1YTI3vQNAfzKX+CKG8q2FR9V3GBa6QZOSXU2I4tTqNQOEznNCscGW
 CsxYhnFT81pKb2nePK1QidC6MWMjD0ILsHOvbmBvuhzAHc0wRwvoWzqV82/LecHs69bF
 unBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pA5MaUprdCYMP2TXqV9bLGLaHfHeBjb6jUfhZDJX5J0=;
 b=mmQY5wbyum820vgVX7rgyD/9STx93OQvKh9u98sVSf98JCakf4pdAXbrNu+2hR7fcL
 qoVrpAhJRt8pF9M7jdial9cc0Y8xefv9z0/z6UQjeFVDoSDCtgHGU2yRmbzDJonruruy
 aDu6FoUDeFrJ6AfUGqIbGx9f+Ay0XIsKav91RAhN+l4k8ymeUod7Ur12pjjMsmZvyjbe
 2l5QJCsiqh6P+M9NtniBMRc/DChNTcVZqgBCAwWlAaPNmZAVjnL36mon4OfB57KHpVND
 wNqhuVlFXOPy099Wh0EgPzz6wqVjEBnvjlmG7zMqx+vuDjoumgKn4Qkpi6hiYwphCfYP
 XvTg==
X-Gm-Message-State: AOAM531HkOICPUYXtKI4X57XWmx0QqarmsvDvf82XSx9XwsvGlsfasQ/
 fiauWRPlZBQCEkU6hGUOD+8iRP/eqSH0VmMbEawZuA==
X-Google-Smtp-Source: ABdhPJwO+mjtvymxyblSo1tL9DNR4TGkftqp0QQq4tXKij9APCRw5rz9zOhsv/sed+wYiWMVPWDC5s92++zWF5KKlmY=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr2715286edq.204.1603199259672; 
 Tue, 20 Oct 2020 06:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201008232154.94221-1-hskinnemoen@google.com>
 <20201008232154.94221-7-hskinnemoen@google.com>
In-Reply-To: <20201008232154.94221-7-hskinnemoen@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 14:07:28 +0100
Message-ID: <CAFEAcA9hp+7puCWvZfCWBUQpFhQ+uoqtTkNno6D2AA9eTVHpGA@mail.gmail.com>
Subject: Re: [PATCH 6/6] hw/gpio: Add GPIO model for Nuvoton NPCM7xx
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 00:22, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> The NPCM7xx chips have multiple GPIO controllers that are mostly
> identical except for some minor differences like the reset values of
> some registers. Each controller controls up to 32 pins.
>
> Each individual pin is modeled as a pair of unnamed GPIOs -- one for
> emitting the actual pin state, and one for driving the pin externally.
> Like the nRF51 GPIO controller, a gpio level may be negative, which
> means the pin is not driven, or floating.
>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> +static void npcm7xx_gpio_class_init(ObjectClass *klass, void *data)
> +{
> +    ResettableClass *reset = RESETTABLE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    QEMU_BUILD_BUG_ON(NPCM7XX_GPIO_REGS_END > NPCM7XX_GPIO_NR_REGS);
> +
> +    dc->desc = "NPCM7xx GPIO Controller";
> +    reset->phases.enter = npcm7xx_gpio_enter_reset;
> +    reset->phases.hold = npcm7xx_gpio_hold_reset;
> +    device_class_set_props(dc, npcm7xx_gpio_properties);
> +}

Missing vmstate struct. Otherwise device looks good.

thanks
-- PMM

