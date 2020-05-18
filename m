Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E8DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF9620758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c47bMeNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF9620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaj8q-0007zl-LY
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jaj5L-0002wO-6u; Mon, 18 May 2020 12:57:51 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:37838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jaj5K-00026x-8Y; Mon, 18 May 2020 12:57:50 -0400
Received: by mail-il1-x142.google.com with SMTP id n11so10561388ilj.4;
 Mon, 18 May 2020 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xOqpUizbZ52/ey8AistUihYLiyi7pkYwNA/587ExWso=;
 b=c47bMeNsDVWseZDl95wHpGzvmuv2bXSiWi9g9rAWckZtULOva5geMkOEh/XFXgC/ok
 bo3QMpULlc4wwWv/4sAr1IIHt/k6tGJUD1xmhFPHMvk6j5XwR1X0aZBAMN/V6KTnh/M8
 aA+vaCJS40/+W8O8xmEq1GCHxvxD9tPdmQLnVs7aByfR6Y405o3HDGErNur38lhgF5SM
 OaeBBQb4wYfafEtOzN8oUMpXTCeNHjlH69NLwzySpQQ/m6ji9564OxkI7cZyLMcbmhxU
 vtMK3LcAn7p/kCif7x574cZ/uXhd/un0O0WSfwpnS1u+HXpJEfywgoGDzfaSYMbmBWk9
 gvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xOqpUizbZ52/ey8AistUihYLiyi7pkYwNA/587ExWso=;
 b=BoG5BiL6zgDF7N/9oHG9BT/3VtOAEkdS0J2/vZ9rF3q7OE3DP9rlTLseOJ49UvAi4U
 /eqrDScUYzQaLHw2bBrNvt960ijddl2P3VECU1k4nfKVC8oTG2B8B/JRcFa8c3On+802
 OJUlXimY6d6nCGdZzm48mgSM0JpmzSq4b4DDd9UoeU+relSHS192qvZlNxDLid7r3kMi
 eJsceRDxjm4bPGqwW66eajD/gaezNH9pVN7ITcGEC2FE9itVGB+AJkWwzZZzU69OgUtG
 iaa+wXU8Y3D4TRqZiY8v5EV9On1IeSeiCnKGY0hFgBZYzhqE5WDT/GO0RF4z8YP396sr
 7uXQ==
X-Gm-Message-State: AOAM530VZCqGzZFXyj6MBAzIPBw5pQ10S+90cgyvtDwwqtAekGD9r+mT
 8GUjbDUy3Zj1qDjN7jNxMhsjXwdRL2VgzKbFoYE=
X-Google-Smtp-Source: ABdhPJzwtkHx8J1SJZK9QrTrMIDWvOw+hRZ3J84bznyyktS4qOWngs82d8HWbCnFSEQIlVIB/ATfsJc3FB4UyjUo3Wc=
X-Received: by 2002:a05:6e02:52e:: with SMTP id
 h14mr3017842ils.177.1589821068312; 
 Mon, 18 May 2020 09:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-2-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-2-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2020 09:48:56 -0700
Message-ID: <CAKmqyKOun2FyT+JR8cyrP9eQn9xFDAppFb4W12ym-TPGt9h7Hg@mail.gmail.com>
Subject: Re: [PATCH 01/24] arm/stm32f405: Fix realization of "stm32f2xx-adc"
 devices
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 17, 2020 at 10:06 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> stm32f405_soc_initfn() creates six such devices, but
> stm32f405_soc_realize() realizes only one.  Affects machine
> netduinoplus2.
>
> I wonder how this ever worked.  If the "device becomes real only on
> realize" thing actually works, then we've always been missing five of
> six such devices, yet nobody noticed.

I must have just been testing the first ADC.

>
> Fix stm32f405_soc_realize() to realize all six.  Visible in "info
> qtree":
>
>      bus: main-system-bus
>        type System
>        dev: stm32f405-soc, id ""
>          cpu-type = "cortex-m4-arm-cpu"
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012000/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012000/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012000/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012000/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>          mmio 0000000040012000/00000000000000ff
>        dev: stm32f2xx-adc, id ""
>          gpio-out "sysbus-irq" 1
>     -    mmio ffffffffffffffff/00000000000000ff
>     +    mmio 0000000040012000/00000000000000ff
>        dev: armv7m, id ""
>
> The mmio addresses look suspicious.

Good catch, thanks :)

>
> Fixes: 529fc5fd3e18ace8f739afd02dc0953354f39442
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/stm32f405_soc.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index 4f10ce6176..4649502711 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -185,16 +185,18 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
>      qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
>                            qdev_get_gpio_in(armv7m, ADC_IRQ));
>
> -    dev = DEVICE(&(s->adc[i]));
> -    object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
> -    if (err != NULL) {
> -        error_propagate(errp, err);
> -        return;
> +    for (i = 0; i < STM_NUM_ADCS; i++) {
> +        dev = DEVICE(&(s->adc[i]));
> +        object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
> +        if (err != NULL) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        busdev = SYS_BUS_DEVICE(dev);
> +        sysbus_mmio_map(busdev, 0, ADC_ADDR);
> +        sysbus_connect_irq(busdev, 0,
> +                           qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
>      }
> -    busdev = SYS_BUS_DEVICE(dev);
> -    sysbus_mmio_map(busdev, 0, ADC_ADDR);
> -    sysbus_connect_irq(busdev, 0,
> -                       qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
>
>      /* SPI devices */
>      for (i = 0; i < STM_NUM_SPIS; i++) {
> --
> 2.21.1
>
>

