Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF1FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BC42074D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5EoJpC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BC42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqNIf-0007xz-Ll
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqNHr-000778-0t; Tue, 30 Jun 2020 16:55:27 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqNHp-0004HP-BR; Tue, 30 Jun 2020 16:55:26 -0400
Received: by mail-io1-xd43.google.com with SMTP id k23so22507877iom.10;
 Tue, 30 Jun 2020 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cS07S9PeaiBeK0IzcW0qbV66hIIZRnIen/5zf8xLf1c=;
 b=X5EoJpC6n7Z6YvON2sQFoVhsOwbawuSeaPsYxkJC7x4N17/U9xK5Udfy3kNOcTYIhT
 O+GkysAPVljHAvKXJ2dYXmrQjXO43xv2rgdCBJkKH6sQxcgRkmA/u5nPOvXhpNWT9B99
 HGkqf3WY/gz51AbJIrU/xP+wb4ckM+HyjKOIXFy4m0k8as5CCO7mIWDv+GH64bF2/R0v
 v/FrnOyOywvCyrfe92Hi0DRZAyMhy5Xw9ECYsEiIg68q04JIQyu2EOE3WVKHSyowWs4d
 FTIjBHfoIZ5iPoxETbygTdLObU4TnqOgzK6VDkXcjcLyDhbRWsEpCYcxMrRt23MYc0Kz
 uEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cS07S9PeaiBeK0IzcW0qbV66hIIZRnIen/5zf8xLf1c=;
 b=W1PGFlJ/fLTxl/MT/OrloDXoeIrxkWN3NnE939DPij2Rlb9fVFVXtpDFpvxZ5OoelN
 i6hE9q2i+Rlpslatz+poAbHuxSfs2otiyty6N2x3pUPm5LcgsPTVCVYe0qPBgVgVuGub
 ND3OjWGdbre7F6VZ+8g4lQOilDT8iHnyDE+JBr3hlMIXwMzOBPPvo5SmBqIiV+AuG6Jo
 gmt2jcQP27XrKrjDehNHV2I+CzIzcVFGUzxpkMz9Rxfu4IQUZ2iqOlC4FnH/fNjPsFFZ
 LlSakGYnnOVeSdUyfUAr0H0NXF4JHOhjQBtJWjV0kqfF2FkeJivdlPf6ZR0orn5zz6E5
 wdRQ==
X-Gm-Message-State: AOAM533f8fpYgFfIS305JCMxiD6zUMhpovQoIqlt1rB34tzj5bcKeugX
 VeKN7fygse3SF3trVoAMGB02fORZmlPInAAOWmA=
X-Google-Smtp-Source: ABdhPJzc1HK+aiVyA7xPxnOjkc+y1u/ihbeEBTgGWDTI84rWORAuSnFo5uoYbu2GP0rHoINmq9H2KpRzQDktup9jgmY=
X-Received: by 2002:a6b:8dd1:: with SMTP id
 p200mr23583366iod.118.1593550523524; 
 Tue, 30 Jun 2020 13:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-6-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-6-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jun 2020 13:45:39 -0700
Message-ID: <CAKmqyKPiq4QGuhUADFLhMnekEpDA2NPh=MTHPskUjt2u+DTA5g@mail.gmail.com>
Subject: Re: [PATCH 05/17] hw/arm/spitz: Implement inbound GPIO lines for bit5
 and power signals
To: Peter Maydell <peter.maydell@linaro.org>
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

On Sun, Jun 28, 2020 at 7:29 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently the Spitz board uses a nasty hack for the GPIO lines
> that pass "bit5" and "power" information to the LCD controller:
> the lcdtg realize function sets a global variable to point to
> the instance it just realized, and then the functions spitz_bl_power()
> and spitz_bl_bit5() use that to find the device they are changing
> the internal state of. There is a comment reading:
>  FIXME: Implement GPIO properly and remove this hack.
> which was added in 2009.
>
> Implement GPIO properly and remove this hack.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/spitz.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 69bc2b3fa10..11e413723f4 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -586,12 +586,9 @@ static void spitz_bl_update(SpitzLCDTG *s)
>          zaurus_printf("LCD Backlight now off\n");
>  }
>
> -/* FIXME: Implement GPIO properly and remove this hack.  */
> -static SpitzLCDTG *spitz_lcdtg;
> -
>  static inline void spitz_bl_bit5(void *opaque, int line, int level)
>  {
> -    SpitzLCDTG *s = spitz_lcdtg;
> +    SpitzLCDTG *s = opaque;
>      int prev = s->bl_intensity;
>
>      if (level)
> @@ -605,7 +602,7 @@ static inline void spitz_bl_bit5(void *opaque, int line, int level)
>
>  static inline void spitz_bl_power(void *opaque, int line, int level)
>  {
> -    SpitzLCDTG *s = spitz_lcdtg;
> +    SpitzLCDTG *s = opaque;
>      s->bl_power = !!level;
>      spitz_bl_update(s);
>  }
> @@ -639,13 +636,16 @@ static uint32_t spitz_lcdtg_transfer(SSISlave *dev, uint32_t value)
>      return 0;
>  }
>
> -static void spitz_lcdtg_realize(SSISlave *dev, Error **errp)
> +static void spitz_lcdtg_realize(SSISlave *ssi, Error **errp)
>  {
> -    SpitzLCDTG *s = FROM_SSI_SLAVE(SpitzLCDTG, dev);
> +    SpitzLCDTG *s = FROM_SSI_SLAVE(SpitzLCDTG, ssi);
> +    DeviceState *dev = DEVICE(s);
>
> -    spitz_lcdtg = s;
>      s->bl_power = 0;
>      s->bl_intensity = 0x20;
> +
> +    qdev_init_gpio_in_named(dev, spitz_bl_bit5, "bl_bit5", 1);
> +    qdev_init_gpio_in_named(dev, spitz_bl_power, "bl_power", 1);
>  }
>
>  /* SSP devices */
> @@ -820,15 +820,11 @@ static void spitz_out_switch(void *opaque, int line, int level)
>      case 3:
>          zaurus_printf("Orange LED %s.\n", level ? "on" : "off");
>          break;
> -    case 4:
> -        spitz_bl_bit5(opaque, line, level);
> -        break;
> -    case 5:
> -        spitz_bl_power(opaque, line, level);
> -        break;
>      case 6:
>          spitz_adc_temp_on(opaque, line, level);
>          break;
> +    default:
> +        g_assert_not_reached();
>      }
>  }
>
> @@ -858,9 +854,9 @@ static void spitz_scoop_gpio_setup(SpitzMachineState *sms)
>
>      if (sms->scp1) {
>          qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_CONT,
> -                              outsignals[4]);
> +                              qdev_get_gpio_in_named(sms->lcdtg, "bl_bit5", 0));
>          qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_ON,
> -                              outsignals[5]);
> +                              qdev_get_gpio_in_named(sms->lcdtg, "bl_power", 0));
>      }
>
>      qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
> --
> 2.20.1
>
>

