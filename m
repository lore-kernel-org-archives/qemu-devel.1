Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8866C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 16:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4D5215A4
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 16:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyL1wEkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4D5215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn3Dk-0007CL-Uu
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 12:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn3D2-0006fe-Ns; Sun, 21 Jun 2020 12:52:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn3D1-0003dK-7C; Sun, 21 Jun 2020 12:52:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so14360470wru.0;
 Sun, 21 Jun 2020 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xsRWBDAQ8vlJQpU8BrCg4Fe+1vZzqFIokH+gai1iDYg=;
 b=OyL1wEkUUByS/qsBtE880PYcLQIga8KgzHwCtP0bfRgVVPPty51oa4Lfln8VXmwtZ3
 9PSufK0ir8Gou6cvjlwt9HD95WGC8ZMGYFdjT1aYKhMAT5upe2KllKXwLei9mWGtouf7
 MMysXdX/fTzFFBfh4Rd/VFpwFwIButG706o4XA61PRu6uzSFyZ0uhIlF2sEiYq4/zqwX
 4uNNRJBRBwPdo6hIxKuDyzS4g4rp4w0deEQx4m3bMULD0HpALxIfEOASkLAkrYIRgvt6
 8mDucggHOm9Q5XcQiZnq6AYqg9iskNJ7ABfjJo51IeWOXFwETdEjrdKTfKRAnjuzmZio
 BnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xsRWBDAQ8vlJQpU8BrCg4Fe+1vZzqFIokH+gai1iDYg=;
 b=MvH9OzmjJHPuianhHvWHl+9+w1EThK+zNRdNv5wMm2qdCefQIXDAbtMPRnOwfY+6cG
 Mwn6cHpRGh/7AtfyRqKIVrwgOSpQ5j4XKql2Q9TQbZ2Eo1o+Mpk/FvdVn0rUcuWpe9Fk
 KS5BjvjeMp6UK+66+kdqlgxIyuxZuQ4Np4ZEcA8ABNjdhk/ftUxkPlSgyyKiz19JrKsK
 eevwdmMHsm2lTmTn5tCsQKVOYcyeBtC+UK42apE8AGeyb0ck5Jd3vc+LLwAfZeRSGDHE
 BLbY2UikplCgiRN/eYuuMEX+P84GNSTTEg8sg5isysVuD/jR+bpd5HEsR/GJd7O+SY0P
 8WYg==
X-Gm-Message-State: AOAM533riO5xUW9LOvwxe47bsfWMRwjDNYFOPwLIef68kVmp2QfP7YZT
 fJ7u6IbRiS7XZz1vsrikSwM=
X-Google-Smtp-Source: ABdhPJy2io4D1BWHYuBsBZU09IYg7F1j9BVMBaxctyXUcE+sbnhPWv4ip/wS9mtMCWZrKsnIeBnHzQ==
X-Received: by 2002:adf:f34c:: with SMTP id e12mr3606795wrp.46.1592758360759; 
 Sun, 21 Jun 2020 09:52:40 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f16sm14007244wmh.27.2020.06.21.09.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 09:52:40 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] hw/arm/tosa: Replace fprintf() calls by LED devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-8-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4442b9bc-fbc6-3f9a-0c22-2d761286b223@amsat.org>
Date: Sun, 21 Jun 2020 18:52:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200620230719.32139-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 1:07 AM, Philippe Mathieu-Daudé wrote:
> The recently added LED device reports LED status changes with
> the 'led_set_intensity' trace event. It is less invasive than
> the fprintf() calls. We need however to have a binary built
> with tracing support.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/tosa.c  | 40 +++++++++++++---------------------------
>  hw/arm/Kconfig |  1 +
>  2 files changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index 5dee2d76c6..74b5fd1049 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -24,6 +24,7 @@
>  #include "hw/irq.h"
>  #include "hw/ssi/ssi.h"
>  #include "hw/sysbus.h"
> +#include "hw/misc/led.h"
>  #include "exec/address-spaces.h"
>  
>  #define TOSA_RAM    0x04000000
> @@ -65,27 +66,6 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
>      pxa2xx_pcmcia_attach(cpu->pcmcia[0], md);
>  }
>  
> -static void tosa_out_switch(void *opaque, int line, int level)
> -{
> -    switch (line) {
> -        case 0:
> -            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
> -            break;
> -        case 1:
> -            fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
> -            break;
> -        case 2:
> -            fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
> -            break;
> -        case 3:
> -            fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
> -            break;
> -        default:
> -            fprintf(stderr, "Uhandled out event: %d = %d\n", line, level);
> -            break;
> -    }
> -}
> -
>  static void tosa_reset(void *opaque, int line, int level)
>  {
>      if (level) {
> @@ -98,7 +78,6 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
>                  DeviceState *scp1,
>                  TC6393xbState *tmio)
>  {
> -    qemu_irq *outsignals = qemu_allocate_irqs(tosa_out_switch, cpu, 4);
>      qemu_irq reset;
>  
>      /* MMC/SD host */
> @@ -119,11 +98,6 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
>                          qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
>                          NULL);
>  
> -    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED, outsignals[0]);
> -    qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED, outsignals[1]);
> -    qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED, outsignals[2]);
> -    qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED, outsignals[3]);
> -
>      qdev_connect_gpio_out(scp1, TOSA_GPIO_TC6393XB_L3V_ON, tc6393xb_l3v_get(tmio));
>  
>      /* UDC Vbus */
> @@ -234,6 +208,18 @@ static void tosa_init(MachineState *machine)
>  
>      scp0 = sysbus_create_simple("scoop", 0x08800000, NULL);
>      scp1 = sysbus_create_simple("scoop", 0x14800040, NULL);
> +    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
> +                          TOSA_GPIO_BT_LED,
> +                          LED_COLOR_BLUE, "bluetooth", 0);
> +    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
> +                          TOSA_GPIO_NOTE_LED,
> +                          LED_COLOR_GREEN, "note", 1);
> +    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
> +                          TOSA_GPIO_CHRG_ERR_LED,
> +                          LED_COLOR_AMBER, "charger-error", 2);
> +    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
> +                          TOSA_GPIO_WLAN_LED,
> +                          LED_COLOR_GREEN, "wlan", 3);

Oops, wrong last argument...

>  
>      tosa_gpio_setup(mpu, scp0, scp1, tmio);
>  
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1a57a861ac..057c869d65 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -150,6 +150,7 @@ config TOSA
>      select ZAURUS  # scoop
>      select MICRODRIVE
>      select PXA2XX
> +    select LED
>  
>  config SPITZ
>      bool
> 


