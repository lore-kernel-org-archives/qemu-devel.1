Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A61C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D2320760
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+2goFTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D2320760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppo9-0007Wb-5O
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppnW-00071K-Ti; Mon, 29 Jun 2020 05:09:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppnV-00044B-A6; Mon, 29 Jun 2020 05:09:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id f139so15336511wmf.5;
 Mon, 29 Jun 2020 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PVfjpx+nNrAbdKkh7LGQo9GFJS/UGE6X3Fu++GnyF8Y=;
 b=C+2goFTqTN6kls7UpDW8GJd9fJ3V6ha/tGwLpnTO2yhqgASrJSQwh1jsXyB/lO5QHa
 O9f+QQOCpNNBZsP0yrp1xqMNzmjUlmqCKjDJfVZfunbPq0aWAQ0gYscXrpsEdVr4vlEZ
 2KLQM7RxHkcId1fwFeNYBTZ3yESLsjXGNS6irGgUjSHdIxoA9GxkENkPBJ4F3V6nJLSE
 uu0Udc8OACU4uLmZofFXLjBF4KUaXLaT52x+lRpE+DxRz4qRbjYy6e3jRbEnDlXXxjo+
 kSpjk/X1Og06h7cWRc/Ijlqrg+7nBhzRONm2RSCo7TwhztxuidBBulWFMPvEmGUfvGr5
 MrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PVfjpx+nNrAbdKkh7LGQo9GFJS/UGE6X3Fu++GnyF8Y=;
 b=Dhi76ezT5dIgL6OssoCkRQ+TTmDn4GVzHy7rsRXHjtOFmMLvMb46+8taeemtRvXVOj
 GS2/G8f2cChZ96ptGeeDAKXsjdzvl4Cr+bj2zA3bNnHuiO+hHw2HorQZbDBcET5hTt2r
 GkyVa4JMq7goJNgtPBI9ptj5qLvhjVKqlhqj1Jjxz/7qAoXqPHs8KIe0BSI340U6oL3x
 Q0NaSJ40mK5TIsIej2ISkwQIQjYgW1poTdCGVnIabxhZepMM+3tod7ubu+MdFjlH7hS0
 kYrfZZJKRmQl7KWA3OsAP4mFnJXlV3awZbUW2GjLqIMFmZD386r424IRAHoP3/MmKTLW
 nC+w==
X-Gm-Message-State: AOAM532upxmxZacipGXufVkXmz4zyW1NQuesSsJiRkeKDVeX75aZw+3a
 +ntB5iBhsEi++gyJC5KIIeo=
X-Google-Smtp-Source: ABdhPJwtF8kYYfCqJDo9TPQNzPisxF+9IMxrbUS5Zp8FamZwfGjwJfavjAVYTzJK+oCAhSwvMCIHlQ==
X-Received: by 2002:a1c:ab56:: with SMTP id u83mr15418455wme.94.1593421791228; 
 Mon, 29 Jun 2020 02:09:51 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id b62sm17195358wmh.38.2020.06.29.02.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:09:50 -0700 (PDT)
Subject: Re: [PATCH 09/17] hw/arm/spitz: Use max111x properties to set initial
 values
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bd800c18-4b59-3c88-0a8c-83ba6ab4a2ba@amsat.org>
Date: Mon, 29 Jun 2020 11:09:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
> Use the new max111x qdev properties to set the initial input
> values rather than calling max111x_set_input(); this means that
> on system reset the inputs will correctly return to their initial
> values.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/spitz.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 11e413723f4..93a25edcb5b 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -731,11 +731,14 @@ static void spitz_ssp_attach(SpitzMachineState *sms)
>                            qdev_get_gpio_in(sms->mpu->gpio, SPITZ_GPIO_TP_INT));
>  
>      bus = qdev_get_child_bus(sms->mux, "ssi2");
> -    sms->max1111 = ssi_create_slave(bus, "max1111");
> +    sms->max1111 = qdev_new("max1111");
>      max1111 = sms->max1111;
> -    max111x_set_input(sms->max1111, MAX1111_BATT_VOLT, SPITZ_BATTERY_VOLT);
> -    max111x_set_input(sms->max1111, MAX1111_BATT_TEMP, 0);
> -    max111x_set_input(sms->max1111, MAX1111_ACIN_VOLT, SPITZ_CHARGEON_ACIN);
> +    qdev_prop_set_uint8(sms->max1111, "input1" /* BATT_VOLT */,
> +                        SPITZ_BATTERY_VOLT);
> +    qdev_prop_set_uint8(sms->max1111, "input2" /* BATT_TEMP */, 0);
> +    qdev_prop_set_uint8(sms->max1111, "input3" /* ACIN_VOLT */,
> +                        SPITZ_CHARGEON_ACIN);

Actually for arrays it would be nice to use:

    DEFINE_PROP_ARRAY("input", MAX111xState, nr_inputs, reset_input,
                      qdev_prop_uint8, uint8_t),

Then something like:

qdev_prop_set_uint8_indexed(sms->max1111, "input", 2 /*BATT_TEMP*/, 0);

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    ssi_realize_and_unref(sms->max1111, bus, &error_fatal);
>  
>      qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_LCDCON_CS,
>                          qdev_get_gpio_in(sms->mux, 0));
> 

