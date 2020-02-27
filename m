Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CEAC4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 06:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2B724683
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 06:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMl2em50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2B724683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7CkX-0002vU-Qx
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 01:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j7Cjr-0002OF-FN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 01:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j7Cjq-0008RA-EG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 01:33:39 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j7Cjq-0008Pt-7K; Thu, 27 Feb 2020 01:33:38 -0500
Received: by mail-lj1-x242.google.com with SMTP id q23so2019273ljm.4;
 Wed, 26 Feb 2020 22:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QDQ+tLqj+2ND5MOZarTy4osGo+cc45/4S4LUUrHn8UI=;
 b=gMl2em50MXlHnb9ckwoNIkqcmUvkR79A8nVqKr5SQc5v8flpDKe887X72o6MyFy4yk
 71mYOmHi+w5epzb9o5k8EKiqCsSO242KC9P8vnbnrDimLRw6pNAVw3XAFxTjyvPU+LJD
 vo4wLMacMRWZO/xRWoVBcsfbQqZOrW+j4rf68WJ9y3FYiO1e4HfsurOvGrday5+RFaZw
 /Eq7bk/JVUylsXEljshv+ozmGoChXRrOfbHmgxjHVeODfIovb6Kg4kHGYTx1qsMvcRz9
 JSKEQu6I9+ljHnaUQyywou1NCldwIivy+zVw68snFJALiIcw62+/OsV1v1gduqZRs0ky
 Xn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QDQ+tLqj+2ND5MOZarTy4osGo+cc45/4S4LUUrHn8UI=;
 b=dfQZV1Sr8wediOzF279HE44CzmYjetLrMLZIwMZDz08SVO2Vwu9fQtnzX87HPAPRGg
 CnZ3gV7XoeEAGVD93uC60N0wXK70X2mZqJ4LIdTvAZc3VYOGv7zbbJE5cHd9FYq+8NwZ
 PeicX0M9T2KYG7divi7ou4TX11A9S8EKmQ22OJk7prW69fCr6XAi9af4HBIg6OtSUABa
 qzwL851ZpsfKbrPFQFGpH2jou6Kmc3uVCapMMt0xYd/nbCRKmMBAnYGlQl1C8Tjmp5hu
 fjiUDtSU9sQ7bOn87Bm++DrC5A/m5VTdkBIcegJV/LqLPY9OSDwW2OjoqmnbH1UgB108
 Gt0g==
X-Gm-Message-State: ANhLgQ0UYxOYDhG9D0GleF7Fdu44ltpU6RSGcHLh+T3oeQm93JahOTpv
 jboQ8UL5izAA15LLpcGCGzFZi3FRCxgByaWbsh0=
X-Google-Smtp-Source: ADFU+vszYhyiHPud3lDHrRBFb4+WgK4qLgaclkBiJTs7xblfCdJ0B8PJ7gJ313wrJ/PZMg0+3oDuB8cndpcCEtyMmFI=
X-Received: by 2002:a2e:b4ac:: with SMTP id q12mr1654229ljm.285.1582785216492; 
 Wed, 26 Feb 2020 22:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-7-pannengyuan@huawei.com>
In-Reply-To: <20200227025055.14341-7-pannengyuan@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 22:33:10 -0800
Message-ID: <CAKmqyKM-nZ6odr6G1dHy6ZMoc+v3e6WoESjPkzmcTYN8totTeg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] hw/timer/cadence_ttc: move timer_new from init()
 into realize() to avoid memleaks
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>, zhang.zhanghailiang@huawei.com,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 6:37 PM Pan Nengyuan <pannengyuan@huawei.com> wrote:
>
> There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> ---
>  hw/timer/cadence_ttc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
> index 5e3128c1e3..b0ba6b2bba 100644
> --- a/hw/timer/cadence_ttc.c
> +++ b/hw/timer/cadence_ttc.c
> @@ -412,16 +412,21 @@ static void cadence_timer_init(uint32_t freq, CadenceTimerState *s)
>  static void cadence_ttc_init(Object *obj)
>  {
>      CadenceTTCState *s = CADENCE_TTC(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &cadence_ttc_ops, s,
> +                          "timer", 0x1000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
> +
> +static void cadence_ttc_realize(DeviceState *dev, Error **errp)
> +{
> +    CadenceTTCState *s = CADENCE_TTC(dev);
>      int i;
>
>      for (i = 0; i < 3; ++i) {
>          cadence_timer_init(133000000, &s->timer[i]);
> -        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->timer[i].irq);
> +        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->timer[i].irq);
>      }
> -
> -    memory_region_init_io(&s->iomem, obj, &cadence_ttc_ops, s,
> -                          "timer", 0x1000);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>  }
>
>  static int cadence_timer_pre_save(void *opaque)
> @@ -479,6 +484,7 @@ static void cadence_ttc_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
>      dc->vmsd = &vmstate_cadence_ttc;
> +    dc->realize = cadence_ttc_realize;
>  }
>
>  static const TypeInfo cadence_ttc_info = {
> --
> 2.18.2
>
>

