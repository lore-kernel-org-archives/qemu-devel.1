Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0B2C47432
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D207B24859
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7I4haoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D207B24859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEG4g-0004Pl-OR
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 14:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEG3k-00039V-9P; Fri, 04 Sep 2020 14:03:36 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEG3i-0001Pb-L5; Fri, 04 Sep 2020 14:03:35 -0400
Received: by mail-io1-xd43.google.com with SMTP id g14so8071062iom.0;
 Fri, 04 Sep 2020 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FhgVsOtlPhTSWd3KLHSI68NoaE29e0zkbL2NLdgxz0g=;
 b=Z7I4haoF/sarpeaJ7MGI1w9qEOIl87mcTeCIES+MvsDUH0qgWF0cTbi/2li8LRazHR
 9IWv1xgvY9dPLJ4AV4+/1cy568cErnoKnf2VjL+CMb63UB8ECncYcTcqjyXxCPOj2KIG
 D0YERJpIo1e1H3tjWxK3RQB1BOYvCYt0PneP5HHcuxCayNiTIJbONz+9543Ggwu/5AtK
 JNE3DrvtKilEvuFhyvU4DMNhMCh0e1HhbRThbo3sB241NESalUKwQXD9Ps7Id+APsfwr
 SvDAd+aOWOTCCpPcsie49q6Is0RfI8y/6TFpMP+V4zYpvebIvxVG7h78SIN4ELj9Ty/Y
 BJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FhgVsOtlPhTSWd3KLHSI68NoaE29e0zkbL2NLdgxz0g=;
 b=ohaY8YABDP5rS7L2eDqdMWGPZI7c/pG02nCfapc3fDSLWoua9kDqrV1QliQD0x7iM3
 /4NE+o0cPOI9xP6cpvR2ibRHQ0++M/cAmZ9KFvEg0DK2IfujWqnGVtcFENIXKwVV5UNa
 xkCbKW9K7qTjUbRsfdjwzRrT3lqH3FGMIIZf1VMhcvwW3m/CteU9TlbkJ3RwbBho1SYF
 aDQLmyV8z7xYovdt3v2m2POisfMwjFtma2Rn/HoXxJD6ky/2sKyNd0YNbXPoIT5f2iZq
 euOyA9aywvC5DR/Pf8D5QlZji2wJ68N9ZNo/C+I4eYhaN+7I12DUL2RMyXrZN5MZ0NEf
 mZ6Q==
X-Gm-Message-State: AOAM531lCONugLZ3wfRxTtVhQfMnVGA4qfezEAxqz3lw8wHsYVgzUxft
 dmvgYj7ivPVUd4d0gglx7f0Cr0aXBC/r3y/TuQg=
X-Google-Smtp-Source: ABdhPJzxdE8b/3z2KJDSLrUMePhO4cmn6wQ5vpflGrBp0M+AGM7orCC19UHmIfJtPuXS4JL09wJwSXLRidxKK7asTQg=
X-Received: by 2002:a6b:3e84:: with SMTP id l126mr8503862ioa.118.1599242613126; 
 Fri, 04 Sep 2020 11:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-50-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-50-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 10:52:38 -0700
Message-ID: <CAKmqyKPdfmKXb-CvpBLd_fwcwyRY2UD=CySB2zHwzwBZAtZ-7g@mail.gmail.com>
Subject: Re: [PATCH 49/63] stm32f205: Rename STM32F2XXTIMER to STM32F2XX_TIMER
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 2, 2020 at 4:04 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Make the type checking macro name consistent with the TYPE_*
> constant.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/timer/stm32f2xx_timer.h | 2 +-
>  hw/timer/stm32f2xx_timer.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f2xx_timer.h
> index 90f40f1746..70ef426afc 100644
> --- a/include/hw/timer/stm32f2xx_timer.h
> +++ b/include/hw/timer/stm32f2xx_timer.h
> @@ -63,7 +63,7 @@
>
>  #define TYPE_STM32F2XX_TIMER "stm32f2xx-timer"
>  typedef struct STM32F2XXTimerState STM32F2XXTimerState;
> -DECLARE_INSTANCE_CHECKER(STM32F2XXTimerState, STM32F2XXTIMER,
> +DECLARE_INSTANCE_CHECKER(STM32F2XXTimerState, STM32F2XX_TIMER,
>                           TYPE_STM32F2XX_TIMER)
>
>  struct STM32F2XXTimerState {
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index ba8694dcd3..d880c0b4d5 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -96,7 +96,7 @@ static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t now)
>
>  static void stm32f2xx_timer_reset(DeviceState *dev)
>  {
> -    STM32F2XXTimerState *s = STM32F2XXTIMER(dev);
> +    STM32F2XXTimerState *s = STM32F2XX_TIMER(dev);
>      int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>
>      s->tim_cr1 = 0;
> @@ -306,7 +306,7 @@ static Property stm32f2xx_timer_properties[] = {
>
>  static void stm32f2xx_timer_init(Object *obj)
>  {
> -    STM32F2XXTimerState *s = STM32F2XXTIMER(obj);
> +    STM32F2XXTimerState *s = STM32F2XX_TIMER(obj);
>
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
>
> @@ -317,7 +317,7 @@ static void stm32f2xx_timer_init(Object *obj)
>
>  static void stm32f2xx_timer_realize(DeviceState *dev, Error **errp)
>  {
> -    STM32F2XXTimerState *s = STM32F2XXTIMER(dev);
> +    STM32F2XXTimerState *s = STM32F2XX_TIMER(dev);
>      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interrupt, s);
>  }
>
> --
> 2.26.2
>
>

