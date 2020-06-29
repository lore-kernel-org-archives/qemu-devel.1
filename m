Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCBF23359
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbpZPTg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCBF23359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppBI-0003pt-Iy
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppAY-0002r9-01; Mon, 29 Jun 2020 04:29:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppAW-0004A7-Bh; Mon, 29 Jun 2020 04:29:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so15614323wrw.5;
 Mon, 29 Jun 2020 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fYhoelT3nTUqSVB7h6Ql+6croT76pPN3cRxOuAgzR3M=;
 b=HbpZPTg7husWVuOvC+pDzzGwMsIUIHiQd0fetYT/OB+xHsWPAlOhpSCcojpza+Rip9
 +FpfBhd2zE2L0HbyKLnDE2AmVvox+NGmS0v+QWa70yQprCncAPLmVlRoE/OH4UHH/BWc
 T3h9I0Cfeyu/yMW9zUFq3UbMvXV9P0x0OLK465C6R3OQYFXnEuF83zr1xV50W50POELG
 XP6eJ8V8U/pCxERNEVtrLljrO835Tlj38jDdYrOmgawGlAD3XpUs2PCcOgYGC1y2K+Xd
 /vmGDE6xl6zjeLPnqd8rDFBaz3aJ1MxgcTz18F2VGWJzfA69BjkiyD8pke7of9C8gReN
 MSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fYhoelT3nTUqSVB7h6Ql+6croT76pPN3cRxOuAgzR3M=;
 b=GsVGreS1VLt8Xg6g646x/c4YK+7Me3rkqNDCEDuLH1HPzEg8WcaGpEOV5yqyg0hK6B
 JICTELT8Fboes12Vnzwoxb6eL1kiRsSiMb6qgGS701MrS1E3GFKms7KJA4OD5tnkxKle
 nzbNcaIowi0ibaRMGMb+VFznpQ9nDNCW4mRmimIkDxpSEjC6c4+IWMO727Mv0XuidUk1
 ELA4Go/0puedNg++ulPDvdYL5ffQPVVlBYZSGx1SBXc9yHLo+MoUsR5t02rnWJ9DAGOl
 H5DcNLCOCHFWPNOggEuM7gDJqrzVXNcKmU13Ovv/hhNy5cJo9P2LYKUuMs1ux/U4KZZo
 2+BQ==
X-Gm-Message-State: AOAM532ujNQTSf508ST+rEYKSD6RWDBThnYg/2uiI21c2Px8Tx1VdQD4
 riBh42w8HODBh6JeVUO2rkw=
X-Google-Smtp-Source: ABdhPJw7LGhjpJwYseAINVWP8zxLvHI/iOeW9ezK8jAPzaKqZ7jGmidZtv+toT9VXQ1FxT2aarZ7SQ==
X-Received: by 2002:a5d:554d:: with SMTP id g13mr15004117wrw.98.1593419374311; 
 Mon, 29 Jun 2020 01:29:34 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 30sm44976031wrm.74.2020.06.29.01.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 01:29:33 -0700 (PDT)
Subject: Re: [PATCH 11/17] hw/misc/max111x: Create header file for
 documentation, TYPE_ macros
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-12-peter.maydell@linaro.org>
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
Message-ID: <b1a56ac5-f2a7-ec88-0191-5324821f4916@amsat.org>
Date: Mon, 29 Jun 2020 10:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> Create a header file for the hw/misc/max111x device, in the
> usual modern style for QOM devices:
>  * definition of the TYPE_ constants and macros
>  * definition of the device's state struct so that it can
>    be embedded in other structs if desired
>  * documentation of the interface
> 
> This allows us to use TYPE_MAX_1111 in the spitz.c code rather
> than the string "max1111".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> To be honest the main driver here is that I wanted a header
> file to put the documentation comment in :-)
> ---
>  include/hw/misc/max111x.h | 57 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/spitz.c            |  3 ++-
>  hw/misc/max111x.c         | 25 +----------------
>  MAINTAINERS               |  1 +
>  4 files changed, 61 insertions(+), 25 deletions(-)
>  create mode 100644 include/hw/misc/max111x.h
> 
> diff --git a/include/hw/misc/max111x.h b/include/hw/misc/max111x.h
> new file mode 100644
> index 00000000000..337ba63d588
> --- /dev/null
> +++ b/include/hw/misc/max111x.h
> @@ -0,0 +1,57 @@
> +/*
> + * Maxim MAX1110/1111 ADC chip emulation.
> + *
> + * Copyright (c) 2006 Openedhand Ltd.
> + * Written by Andrzej Zaborowski <balrog@zabor.org>
> + *
> + * This code is licensed under the GNU GPLv2.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */
> +
> +#ifndef HW_MISC_MAX111X_H
> +#define HW_MISC_MAX111X_H
> +
> +#include "hw/ssi/ssi.h"
> +#include "hw/irq.h"

"hw/irq.h" not needed as qemu_irq is forward-declared in
"qemu/typedefs.h".

> +
> +/*
> + * This is a model of the Maxim MAX1110/1111 ADC chip, which for QEMU
> + * is an SSI slave device. It has either 4 (max1110) or 8 (max1111)
> + * 8-bit ADC channels.
> + *
> + * QEMU interface:
> + *  + GPIO inputs 0..3 (for max1110) or 0..7 (for max1111): set the value
> + *    of each ADC input, as an unsigned 8-bit value
> + *  + GPIO output 0: interrupt line
> + *  + Properties "input0" to "input3" (max1110) or "input0" to "input7"
> + *    (max1111): initial reset values for ADC inputs.
> + *
> + * Known bugs:
> + *  + the interrupt line is not correctly implemented, and will never
> + *    be lowered once it has been asserted.
> + */
> +typedef struct {
> +    SSISlave parent_obj;
> +
> +    qemu_irq interrupt;
> +    /* Values of inputs at system reset (settable by QOM property) */
> +    uint8_t reset_input[8];
> +
> +    uint8_t tb1, rb2, rb3;
> +    int cycle;
> +
> +    uint8_t input[8];
> +    int inputs, com;
> +} MAX111xState;
> +
> +#define TYPE_MAX_111X "max111x"
> +
> +#define MAX_111X(obj) \
> +    OBJECT_CHECK(MAX111xState, (obj), TYPE_MAX_111X)

Nitpick, we can keep MAX_111X() + MAX111xState in "hw/misc/max111x.c"
until we get a consumer.

> +
> +#define TYPE_MAX_1110 "max1110"
> +#define TYPE_MAX_1111 "max1111"
> +
> +#endif
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index fa592aad6d6..1400a56729d 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -29,6 +29,7 @@
>  #include "audio/audio.h"
>  #include "hw/boards.h"
>  #include "hw/sysbus.h"
> +#include "hw/misc/max111x.h"
>  #include "migration/vmstate.h"
>  #include "exec/address-spaces.h"
>  #include "cpu.h"
> @@ -732,7 +733,7 @@ static void spitz_ssp_attach(SpitzMachineState *sms)
>                            qdev_get_gpio_in(sms->mpu->gpio, SPITZ_GPIO_TP_INT));
>  
>      bus = qdev_get_child_bus(sms->mux, "ssi2");
> -    sms->max1111 = qdev_new("max1111");
> +    sms->max1111 = qdev_new(TYPE_MAX_1111);
>      max1111 = sms->max1111;
>      qdev_prop_set_uint8(sms->max1111, "input1" /* BATT_VOLT */,
>                          SPITZ_BATTERY_VOLT);
> diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
> index 3a5cb838445..d41cfd92a8d 100644
> --- a/hw/misc/max111x.c
> +++ b/hw/misc/max111x.c
> @@ -11,34 +11,11 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "hw/irq.h"

You still need "hw/irq.h" for qemu_irq_raise().

> -#include "hw/ssi/ssi.h"
> +#include "hw/misc/max111x.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
>  #include "hw/qdev-properties.h"
>  
> -typedef struct {
> -    SSISlave parent_obj;
> -
> -    qemu_irq interrupt;
> -    /* Values of inputs at system reset (settable by QOM property) */
> -    uint8_t reset_input[8];
> -
> -    uint8_t tb1, rb2, rb3;
> -    int cycle;
> -
> -    uint8_t input[8];
> -    int inputs, com;
> -} MAX111xState;
> -
> -#define TYPE_MAX_111X "max111x"
> -
> -#define MAX_111X(obj) \
> -    OBJECT_CHECK(MAX111xState, (obj), TYPE_MAX_111X)
> -
> -#define TYPE_MAX_1110 "max1110"
> -#define TYPE_MAX_1111 "max1111"
> -
>  /* Control-byte bitfields */
>  #define CB_PD0		(1 << 0)
>  #define CB_PD1		(1 << 1)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b40446c739..550844d1514 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -787,6 +787,7 @@ F: hw/gpio/max7310.c
>  F: hw/gpio/zaurus.c
>  F: hw/misc/mst_fpga.c
>  F: hw/misc/max111x.c
> +F: include/hw/misc/max111x.h
>  F: include/hw/arm/pxa.h
>  F: include/hw/arm/sharpsl.h
>  F: include/hw/display/tc6393xb.h
> 


