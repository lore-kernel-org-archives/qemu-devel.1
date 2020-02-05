Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35AC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3041C214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMGdGK23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3041C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izPrv-00019O-DR
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 13:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1izPrK-0000hx-V6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1izPrJ-0005KU-Td
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:57:10 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1izPrJ-0005Hp-Ln
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:57:09 -0500
Received: by mail-lf1-x144.google.com with SMTP id t23so2259043lfk.6
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R0LIdouXtD9JD1jcT//O/dUwFu8s1Gw/TYGnfvqIqAo=;
 b=iMGdGK23JcB02LO33+Yz7GZO/km2x/B9shUiSOiLiNnho3KAqdD+dZcdJrjiabzjtP
 PErVPicP6Wgrm6DL05r21n6GVWjmAcJpLmE1etsWpC+KZh764ysDOgjpyyenIDUXTPBU
 0Zmg01cSSyeQduE6M2IcWl86ov8kKYfDtMcz8mwudx9OtQYalEatXbwFDsta7N+C29Hq
 tv4RU8DsGRiT5JXTTgq+gt9y+VUFMhHYgUAiD3rjZqDsLiDh7NmXL7T7aU0J4iG3Jkcp
 EvaC6KwoXd3sFO1OiRG2r0evXqu/SwOdiITvG4ktwkTQun86K59Kwk4CbArq5/xE4zjL
 AGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R0LIdouXtD9JD1jcT//O/dUwFu8s1Gw/TYGnfvqIqAo=;
 b=s0Pb94ZB7quzn1Yel8jdyFTYQ4vZzle6wTAE7vGccXSLmOyTpOErq77eXrAl7b5/jK
 FpkkxXtQRdrBSqs1D3DbQBCT+PpzReRQnewl3dPtgtb14iWzS6M7HtNkhvM4G7gKiJ6K
 w7QWCtdlDttcQ1hcPuReIJeBiXg34lAWnNupRZbElwm6iwhMdk+izkflGPgQjJPzIU5a
 FJD/qO99oODskGMQS+CHy7QEX8RD5wjz8INGwX2J+goFR6ZLY5hQmCrNA8vjNCB3gxIE
 ejNED+krM064ekVjMQ59UHw8Z184u11QSeWyKhEbgyYljt7rnA2LIqReusxSczLmgDYW
 wM8w==
X-Gm-Message-State: APjAAAW2UXF+tG7nak1P3cGzk1Bq8UYt+Ul9X7Rv12CYM9zCScreUzVO
 HH3e8KW4ec8UffaxjwTyWJVYGG8P4pcVqwS4Rp8=
X-Google-Smtp-Source: APXvYqwZUQmpANCqLAeqGcu+lXFYSt+MRUnFDGdaxljp6BQKi7XlExh0whx+21/fZ+h83PA3+H+jHaxod4VxfU5qxGw=
X-Received: by 2002:a19:23d0:: with SMTP id
 j199mr10835302lfj.137.1580929027915; 
 Wed, 05 Feb 2020 10:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20200205070659.22488-1-pannengyuan@huawei.com>
 <20200205070659.22488-3-pannengyuan@huawei.com>
In-Reply-To: <20200205070659.22488-3-pannengyuan@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Feb 2020 10:49:57 -0800
Message-ID: <CAKmqyKNX31vXSq0ic=EHs6k9cb8kpP4xQ_Pr=uxOmBz8GjdwKw@mail.gmail.com>
Subject: Re: [PATCH 2/3] stm32f2xx_timer: delay timer_new to avoid memleaks
To: pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, zhang.zhanghailiang@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 4, 2020 at 11:09 PM <pannengyuan@huawei.com> wrote:
>
> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> There is a memory leak when we call 'device_list_properties' with typename = stm32f2xx_timer. It's easy to reproduce as follow:
>
>     virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-properties", "arguments": {"typename": "stm32f2xx_timer"}}'
>
> This patch delay timer_new to fix this memleaks.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Cc: Alistair Francis <alistair@alistair23.me>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/timer/stm32f2xx_timer.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index fb370ce0f0..06ec8a02c2 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -314,7 +314,11 @@ static void stm32f2xx_timer_init(Object *obj)
>      memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
>                            "stm32f2xx_timer", 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
>
> +static void stm32f2xx_timer_realize(DeviceState *dev, Error **errp)
> +{
> +    STM32F2XXTimerState *s = STM32F2XXTIMER(dev);
>      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interrupt, s);
>  }
>
> @@ -325,6 +329,7 @@ static void stm32f2xx_timer_class_init(ObjectClass *klass, void *data)
>      dc->reset = stm32f2xx_timer_reset;
>      device_class_set_props(dc, stm32f2xx_timer_properties);
>      dc->vmsd = &vmstate_stm32f2xx_timer;
> +    dc->realize = stm32f2xx_timer_realize;
>  }
>
>  static const TypeInfo stm32f2xx_timer_info = {
> --
> 2.21.0.windows.1
>
>
>

