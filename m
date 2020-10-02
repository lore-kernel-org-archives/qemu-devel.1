Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF6EC35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811EA20758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXJ3uHSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811EA20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONVq-00033j-8Q
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kONIY-0001Vd-H5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:48:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kONIV-00050V-LR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:48:42 -0400
Received: by mail-wm1-x341.google.com with SMTP id e11so1391059wme.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ndn3+dn01xCBxjK2wL7sB8ecAb+kOBq9c06j8JXt5Jg=;
 b=nXJ3uHSUaQtzOzDPBn2kl2dC4GZOT9MViCaPyKfyJeanGQNuaGQbtXdZ0ZMXrBKuQu
 lJ3KVM4ukAbIPPXbqDf53XavYGLfoq6ZFHtlCEvY190OZWXxUAJNXCctPYh1Te00dbCh
 0DnJGQQexekx+2s1GmVwm1RMWCT5Qpfagf+QWqrbDBHYmFpr854/lZ+Y3GDJZK3SQ/0D
 SBHtHDLqIYV8NAPGGKuKhWOYboKk9nr6J3uDzK7D8gQ6Cbl67a9x1JVXq996AP3luI4M
 89Na63qdC24YQ37b9kIWJu3+G9SyMeuyQw4YC9s8kliR+nXE79umnqzdPv3VhnG9HJXH
 0edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Ndn3+dn01xCBxjK2wL7sB8ecAb+kOBq9c06j8JXt5Jg=;
 b=eswA8ymD4jwBFwFH2lv5q9cSb7YTrFYCOglm8d3LrAjb89THPYrPixL438RZbB3uSC
 S8gXVE1EAm7ca6fGgmrYM5+mWje4LUQcO2EJkZbQKgwRqeKm9eDvaKk0wBs1Jr2MGush
 D7hGt4IrlKtk80PwSR7sYlvg0Y2fLjbS3w/RWP5cavv+S+QmNck0qB8kVM7vkfhdtw6N
 2wEGJ75IGDdkCKRC/t+stDA8xpJj5TABHgNhKKA9dRbfubvBDFdPN1louMw8h87u4gr0
 CnEeNfxvHqoZVkWIy+BGYa4oWOtqGT+HHVqpa+VDxlT2f8AqWYwokE/6ef6iikctPd0Y
 4HKw==
X-Gm-Message-State: AOAM5323QzYSF8EFmrRTHhXUPHf0dPfRblYnTvFBt+iZ8LEcWPNFX+EC
 CnvTQLOfdpnKSL7zMxro7cE=
X-Google-Smtp-Source: ABdhPJw6Y+lGbyFjJIvbe8jqMekypIf5wFpzjHmcYJCtgpDhqMFN1PoPY0GN5ApMjhKOpKp2ByETpQ==
X-Received: by 2002:a1c:9885:: with SMTP id a127mr3604381wme.8.1601653717527; 
 Fri, 02 Oct 2020 08:48:37 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 88sm2208679wrl.76.2020.10.02.08.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 08:48:36 -0700 (PDT)
Subject: Re: [PATCH] hw/avr: Add limited support for avr gpio registers
To: Heecheol Yang <heecheol.yang@outlook.com>, qemu-devel@nongnu.org
References: <DM6PR16MB24737F911BD260F1FA8EBC37E6310@DM6PR16MB2473.namprd16.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <45f921ac-39d5-2650-9b52-382acecf71d7@amsat.org>
Date: Fri, 2 Oct 2020 17:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR16MB24737F911BD260F1FA8EBC37E6310@DM6PR16MB2473.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.256,
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
Cc: S.E.Harris@kent.ac.uk, mrolnik@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yang,

On 10/2/20 5:24 PM, Heecheol Yang wrote:
> Add some of these features for avr gpio:
>
>  Â  - GPIO I/O : PORTx registers
>  Â  - Data Direction : DDRx registers
>
> Following things are not supported yet:
>  Â  - PINx registers
>  Â  - MCUR registers
>  Â  - Even though read/write for DDRx registers are
>  Â Â Â  implemented, actual direction controls are not
>  Â Â Â  supported yet.

Thanks for your patch, however its encoding seems
completely broken, and I can not test it. Similar
problem occurred to the patchew automatic script:

https://patchew.org/QEMU/DM6PR16MB24737F911BD260F1FA8EBC37E6310@DM6PR16MB2473.namprd16.prod.outlook.com/

This might be useful:
https://wiki.qemu.org/Contribute/SubmitAPatch#Use_git_format-patch

Anyway I'll try to review what I can follow.

>
> Signed-off-by: Heecheol Yang <heecheol.yang@outlook.com>
> ---
>  Â hw/avr/KconfigÂ Â Â Â Â Â Â Â Â Â Â Â  |Â Â  1 +
>  Â hw/avr/atmega.cÂ Â Â Â Â Â Â Â Â Â Â  |Â Â  7 ++-
>  Â hw/avr/atmega.hÂ Â Â Â Â Â Â Â Â Â Â  |Â Â  2 +
>  Â hw/gpio/KconfigÂ Â Â Â Â Â Â Â Â Â Â  |Â Â  3 +
>  Â hw/gpio/avr_gpio.cÂ Â Â Â Â Â Â Â  | 117
+++++++++++++++++++++++++++++++++++++
>  Â hw/gpio/meson.buildÂ Â Â Â Â Â Â  |Â Â  2 +
>  Â include/hw/gpio/avr_gpio.h |Â  48 +++++++++++++++
>  Â 7 files changed, 178 insertions(+), 2 deletions(-)
>  Â create mode 100644 hw/gpio/avr_gpio.c
>  Â create mode 100644 include/hw/gpio/avr_gpio.h
>
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> index d31298c3cc..16a57ced11 100644
> --- a/hw/avr/Kconfig
> +++ b/hw/avr/Kconfig
> @@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU
>  Â Â Â Â  select AVR_TIMER16
>  Â Â Â Â  select AVR_USART
>  Â Â Â Â  select AVR_POWER
> +Â Â Â  select AVR_GPIO
>
>  Â config ARDUINO
>  Â Â Â Â  select AVR_ATMEGA_MCU
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index 44c6afebbb..ad942028fd 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error
> **errp)
>  Â Â Â Â Â Â Â Â Â Â Â Â  continue;
>  Â Â Â Â Â Â Â Â  }
>  Â Â Â Â Â Â Â Â  devname = g_strdup_printf("atmega-gpio-%c", 'a' +
(char)i);
> -Â Â Â Â Â Â Â  create_unimplemented_device(devname,
> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â
 OFFSET_DATA + mc->dev[idx].addr, 3);
> +Â Â Â Â Â Â Â  object_initialize_child(OBJECT(dev), devname, &s->gpio[i],
> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â
TYPE_AVR_GPIO);
> +Â Â Â Â Â Â Â  sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
> +Â Â Â Â Â Â Â  sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
> +Â Â Â Â Â Â Â Â Â Â Â  OFFSET_DATA + mc->dev[idx].addr);
>  Â Â Â Â Â Â Â Â  g_free(devname);
>  Â Â Â Â  }
>
> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
> index a99ee15c7e..e2289d5744 100644
> --- a/hw/avr/atmega.h
> +++ b/hw/avr/atmega.h
> @@ -13,6 +13,7 @@
>
>  Â #include "hw/char/avr_usart.h"
>  Â #include "hw/timer/avr_timer16.h"
> +#include "hw/gpio/avr_gpio.h"
>  Â #include "hw/misc/avr_power.h"
>  Â #include "target/avr/cpu.h"
>  Â #include "qom/object.h"
> @@ -44,6 +45,7 @@ struct AtmegaMcuState {
>  Â Â Â Â  DeviceState *io;
>  Â Â Â Â  AVRMaskState pwr[POWER_MAX];
>  Â Â Â Â  AVRUsartState usart[USART_MAX];
> +Â Â Â  AVRGPIOState gpio[GPIO_MAX];
>  Â Â Â Â  AVRTimer16State timer[TIMER_MAX];
>  Â Â Â Â  uint64_t xtal_freq_hz;
>  Â };
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index b6fdaa2586..1752d0ce56 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -10,3 +10,6 @@ config GPIO_KEY
>
>  Â config SIFIVE_GPIO
>  Â Â Â Â  bool
> +
> +config AVR_GPIO
> +Â Â Â  bool
> diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c
> new file mode 100644
> index 0000000000..7114216847
> --- /dev/null
> +++ b/hw/gpio/avr_gpio.c
> @@ -0,0 +1,117 @@
> +/*
> + * AVR processors GPIO registers emulation.
> + *
> + * Copyright (C) 2020 Heecheol Yang <heecheol.yang@outlook.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/timer.h"

"qemu/timer.h" not needed.

> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +#include "hw/gpio/avr_gpio.h"
> +#include "hw/qdev-properties.h"
> +#include "chardev/char-fe.h"

"chardev/char-fe.h" not needed.

> +
> +static void avr_gpio_reset(DeviceState *dev)
> +{
> +Â Â Â  AVRGPIOState *gpio = AVR_GPIO(dev);
> +Â Â Â  gpio->ddr_val = 0u;
> +Â Â Â  gpio->port_val = 0u;
> +}
> +static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int
> size)
> +{
> +Â Â Â  AVRGPIOState *s = (AVRGPIOState *)opaque;
> +Â Â Â  switch (offset) {
> +Â Â Â  case GPIO_PIN:
> +Â Â Â Â Â Â Â  /* Not implemented yet */

Please use:

   qemu_log_mask(LOG_UNIMP, ...

> +Â Â Â Â Â Â Â  break;
> +Â Â Â  case GPIO_DDR:
> +Â Â Â Â Â Â Â  return s->ddr_val;
> +Â Â Â Â Â Â Â  break;
> +Â Â Â  case GPIO_PORT:
> +Â Â Â Â Â Â Â  return s->port_val;
> +Â Â Â  default:
> +Â Â Â Â Â Â Â  qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %lx\n",
> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  __func__, offset);
> +Â Â Â Â Â Â Â  break;

This can not happen, so I'd simply use:

     g_assert_not_reached();

> +Â Â Â  }
> +Â Â Â  return 0;
> +}
> +
> +static void avr_gpio_write(void *opaque, hwaddr offset, uint64_t value,
> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â
unsigned int size)
> +{
> +Â Â Â  AVRGPIOState *s = (AVRGPIOState *)opaque;
> +Â Â Â  switch (offset) {
> +Â Â Â  case GPIO_PIN:
> +Â Â Â Â Â Â Â  /* Not implemented yet */
> +Â Â Â Â Â Â Â  break;
> +Â Â Â  case GPIO_DDR:
> +Â Â Â Â Â Â Â  s->ddr_val = value & 0xF;
> +Â Â Â Â Â Â Â  break;
> +Â Â Â  case GPIO_PORT:
> +Â Â Â Â Â Â Â  s->port_val = value & 0xF;
> +Â Â Â Â Â Â Â  break;
> +Â Â Â  default:
> +Â Â Â Â Â Â Â  qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %lx\n",
> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  __func__, offset);
> +Â Â Â Â Â Â Â  break;
> +Â Â Â  }

Similar comments than avr_gpio_read().

> +}
> +
> +static const MemoryRegionOps avr_gpio_ops = {
> +Â Â Â  .read = avr_gpio_read,
> +Â Â Â  .write = avr_gpio_write,
> +Â Â Â  .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void avr_gpio_init(Object *obj)
> +{
> +Â Â Â  AVRGPIOState *s = AVR_GPIO(obj);
> +Â Â Â  memory_region_init_io(&s->mmio, obj, &avr_gpio_ops, s,
> TYPE_AVR_GPIO, 3);
> +Â Â Â  sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +Â Â Â  s->enabled = true;
> +}
> +static void avr_gpio_realize(DeviceState *dev, Error **errp)
> +{
> +Â Â Â  avr_gpio_reset(dev);
> +}
> +
> +
> +static void avr_gpio_class_init(ObjectClass *klass, void *data)
> +{
> +Â Â Â  DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +Â Â Â  dc->reset = avr_gpio_reset;
> +Â Â Â  dc->realize = avr_gpio_realize;
> +}
> +
> +static const TypeInfo avr_gpio_info = {
> +Â Â Â  .nameÂ Â Â Â Â Â Â Â Â  = TYPE_AVR_GPIO,
> +Â Â Â  .parentÂ Â Â Â Â Â Â  = TYPE_SYS_BUS_DEVICE,
> +Â Â Â  .instance_size = sizeof(AVRGPIOState),
> +Â Â Â  .instance_init = avr_gpio_init,
> +Â Â Â  .class_initÂ Â Â  = avr_gpio_class_init,
> +};
> +
> +static void avr_gpio_register_types(void)
> +{
> +Â Â Â  type_register_static(&avr_gpio_info);
> +}
> +
> +type_init(avr_gpio_register_types)
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 86cae9a0f3..258bd5dcfc 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true:
> files('omap_gpio.c'))
>  Â softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
>  Â softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true:
files('aspeed_gpio.c'))
>  Â softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true:
> files('sifive_gpio.c'))
> +
> +softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true: files('avr_gpio.c'))
> diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h
> new file mode 100644
> index 0000000000..45d42753c8
> --- /dev/null
> +++ b/include/hw/gpio/avr_gpio.h
> @@ -0,0 +1,48 @@
> +/*
> + * AVR processors GPIO registers definition.
> + *
> + * Copyright (C) 2020 Heecheol Yang <heecheol.yang@outlook.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef AVR_GPIO_H
> +#define AVR_GPIO_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +#include "chardev/char-fe.h"

"chardev/char-fe.h" not needed.

> +
> +/* Offsets of registers. */
> +#define GPIO_PINÂ Â  0x00
> +#define GPIO_DDRÂ Â  0x01
> +#define GPIO_PORTÂ  0x02
> +
> +#define TYPE_AVR_GPIO "avr-gpio"
> +OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)
> +
> +struct AVRGPIOState {
> +Â Â Â  /*< private >*/
> +Â Â Â  SysBusDevice parent_obj;
> +
> +Â Â Â  /*< public >*/
> +Â Â Â  MemoryRegion mmio;
> +
> +Â Â Â  uint8_t ddr_val;
> +Â Â Â  uint8_t port_val;
> +Â Â Â  bool enabled;

What is 'enabled' for?

> +
> +};
> +
> +#endif /* AVR_GPIO_H */
> --
> 2.17.1

Regards,

Phil.

