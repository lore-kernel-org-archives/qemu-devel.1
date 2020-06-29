Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FDFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B97020874
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3qRhvLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B97020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzmU-0006Sj-Db
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jpzlN-0005hD-0D; Mon, 29 Jun 2020 15:48:21 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:32782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jpzlL-0005gw-Bs; Mon, 29 Jun 2020 15:48:20 -0400
Received: by mail-il1-x142.google.com with SMTP id a11so7308697ilk.0;
 Mon, 29 Jun 2020 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZO8nlt67qGajT8gumgRqcgytwuiKZm5Fzjlpx3nwyVw=;
 b=b3qRhvLNOmiWz4o9mQfWGddS51+oa/lkT6r/6VaWzfjzZrosWP1/AqyX7jgQykOvux
 mhyLb1aRFFgMINFnG/pQgHZIzqiU4tvqs9omaJ94DG8qbQa+smbnUJRw+LqnuQZlPyi1
 yvSFGMvTCzF8WS9uZN97hdTm/UdBI7/dizl2WNLh1hN7eTP3U3aiTFSkHKiwlQEPdlgK
 V6BX8onU2aBK8QutbfteK66iHru2cyNw+9fhEH6DxEWMHgJrUix+hrK/IJSg0qH6IZHl
 z0IlG77fcpLA9Ubu43/H1xEiM18m/etKmNsIt20QVU1G57yD5C4vZiBuGLDlOwWltccV
 78hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZO8nlt67qGajT8gumgRqcgytwuiKZm5Fzjlpx3nwyVw=;
 b=hzqirFsf+MixvlxYzdvNSYhMzhpiqqT54TEXKz9bXjKRTBtsKBAV4wsC3vn0UtU8RR
 fKKwrCqlW7asj3UJ2qZW944YKCYNaadmJALZvjvgu+nxTtXs6Yf2kksT+Jo0YYJw1TQt
 W1dbE3qrNn2hidebF+Dw96214n2clkr8H7i7FIOiXVP9MhqeOw1ndj+m/1eU7wXBINk1
 KpnCKpR3h6HBC5YwZEOpjWErxP4uohFKJLWb6wTYzwdOnQRTqpK/bf0o3aqwmFb4/btz
 Pfuh209pXEUi+lQDorPzsYtCHSU19PaAyXX8mKoNWwrBbHhLhZ/YF+0c3yIK9zxLbd9E
 5QrQ==
X-Gm-Message-State: AOAM533UBtGUrrk9lR/VE6cPUYC3YVXc0YDrXx48BAkhf45s18L78Hus
 4/D2q6RSidMle7R+Mleh7jeZ0AxT2gHzExjqlVw=
X-Google-Smtp-Source: ABdhPJz/PBx39EP3E3RmyqHyoObzwHk4M27bWkcoeng5Zs4Vw2Hc6HkMLbhqBisV7VvA2pQdk3HzVCw0D8ecbzqKBsY=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr9211439ilj.131.1593460098111; 
 Mon, 29 Jun 2020 12:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-5-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-5-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2020 12:38:35 -0700
Message-ID: <CAKmqyKPm2PzjPXxGb9p2_k-mD3MEYtHkT_owEhg+8+hM=_y1-g@mail.gmail.com>
Subject: Re: [PATCH 04/17] hw/arm/spitz: Keep pointers to scp0,
 scp1 in SpitzMachineState
To: Peter Maydell <peter.maydell@linaro.org>
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 7:27 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Keep pointers to scp0, scp1 in SpitzMachineState, and just pass
> that to spitz_scoop_gpio_setup().
>
> (We'll want to use some of the other fields in SpitzMachineState
> in that function in the next commit.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/spitz.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index f48e966c047..69bc2b3fa10 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -48,6 +48,8 @@ typedef struct {
>      DeviceState *lcdtg;
>      DeviceState *ads7846;
>      DeviceState *max1111;
> +    DeviceState *scp0;
> +    DeviceState *scp1;
>  } SpitzMachineState;
>
>  #define TYPE_SPITZ_MACHINE "spitz-common"
> @@ -845,22 +847,23 @@ static void spitz_out_switch(void *opaque, int line, int level)
>  #define SPITZ_SCP2_BACKLIGHT_ON                 8
>  #define SPITZ_SCP2_MIC_BIAS             9
>
> -static void spitz_scoop_gpio_setup(PXA2xxState *cpu,
> -                DeviceState *scp0, DeviceState *scp1)
> +static void spitz_scoop_gpio_setup(SpitzMachineState *sms)
>  {
> -    qemu_irq *outsignals = qemu_allocate_irqs(spitz_out_switch, cpu, 8);
> +    qemu_irq *outsignals = qemu_allocate_irqs(spitz_out_switch, sms->mpu, 8);
>
> -    qdev_connect_gpio_out(scp0, SPITZ_SCP_CHRG_ON, outsignals[0]);
> -    qdev_connect_gpio_out(scp0, SPITZ_SCP_JK_B, outsignals[1]);
> -    qdev_connect_gpio_out(scp0, SPITZ_SCP_LED_GREEN, outsignals[2]);
> -    qdev_connect_gpio_out(scp0, SPITZ_SCP_LED_ORANGE, outsignals[3]);
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_CHRG_ON, outsignals[0]);
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_JK_B, outsignals[1]);
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_GREEN, outsignals[2]);
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_ORANGE, outsignals[3]);
>
> -    if (scp1) {
> -        qdev_connect_gpio_out(scp1, SPITZ_SCP2_BACKLIGHT_CONT, outsignals[4]);
> -        qdev_connect_gpio_out(scp1, SPITZ_SCP2_BACKLIGHT_ON, outsignals[5]);
> +    if (sms->scp1) {
> +        qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_CONT,
> +                              outsignals[4]);
> +        qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_ON,
> +                              outsignals[5]);
>      }
>
> -    qdev_connect_gpio_out(scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
>  }
>
>  #define SPITZ_GPIO_HSYNC                22
> @@ -943,7 +946,6 @@ static void spitz_common_init(MachineState *machine)
>      SpitzMachineState *sms = SPITZ_MACHINE(machine);
>      enum spitz_model_e model = smc->model;
>      PXA2xxState *mpu;
> -    DeviceState *scp0, *scp1 = NULL;
>      MemoryRegion *address_space_mem = get_system_memory();
>      MemoryRegion *rom = g_new(MemoryRegion, 1);
>
> @@ -962,12 +964,14 @@ static void spitz_common_init(MachineState *machine)
>
>      spitz_ssp_attach(sms);
>
> -    scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
> +    sms->scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
>      if (model != akita) {
> -        scp1 = sysbus_create_simple("scoop", 0x08800040, NULL);
> +        sms->scp1 = sysbus_create_simple("scoop", 0x08800040, NULL);
> +    } else {
> +        sms->scp1 = NULL;
>      }
>
> -    spitz_scoop_gpio_setup(mpu, scp0, scp1);
> +    spitz_scoop_gpio_setup(sms);
>
>      spitz_gpio_setup(mpu, (model == akita) ? 1 : 2);
>
> --
> 2.20.1
>
>

