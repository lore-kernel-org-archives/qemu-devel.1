Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E83C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634692068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYyYnHHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634692068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuHk-0004jZ-N2
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juuH1-0004D9-Lm; Mon, 13 Jul 2020 04:57:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juuH0-0002UW-2m; Mon, 13 Jul 2020 04:57:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so15106657wrw.1;
 Mon, 13 Jul 2020 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vTxaeiK4H/wXMOJNW8a2fx6baFKR/j6gqcQDSMLpMQE=;
 b=mYyYnHHnNWomP9y1NPkqaZT+hkAUX/f3ZDrPg8VcR+u2UsKwS0kC9S8FglGym8u3dv
 Rl2HpzHjymNMVDr5rdiOdUM4Mh7Vyemz75VcdoqzF8BGLAQZBK0eNkDkZgMCz6V958Wn
 SA6IRnIhcgevyi3r9celSm+gwnMnW9rW0F+jcJL0IaY91wSyDF2PbGb58YAqESdlxznt
 /n1irhq4jQ/Ne+kAmywkpwPm8gZWKsaY6DTO7slgCENqFLA+SnL/7AEJ0IDHj6GtSF5H
 Pc8BgIjH6UFDeLCPM8vfUyQp6hFmO5i9OddMAaY/Tt0MTV3eaWrnaDpv0PyIPgmqp+dc
 Dh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vTxaeiK4H/wXMOJNW8a2fx6baFKR/j6gqcQDSMLpMQE=;
 b=Eh3PakK+u4yxiusrVhxEDjvprD3y63DNokQvYoPMQ530rrnZEeq9Kn+5JL+Vpb1ZFL
 vqk80lnvEUgR2ylSkSFMXAN3Q0r9jng28RFke9XQ9NcBS09AGIuA3azsES9dr2+OmOja
 lF3DVRbvy2q2yXzGsMd/iL1WH2ZD+x4W9nNoomrYWgfP6NE7KSti6miM5hffdpGMHcSY
 PVp71NDKzCG79rgFjGb/JNguhSMZuSv4XCYZPaL1tqNJYXJJg3zIQdH1XtkXFPL9Y5ON
 dkNX7eo+23d1p8N44HFLPFWmJNvC8H7u3t56gN67xwYl0HZO8PyswzmzGtjLy/CKzZRh
 FJeA==
X-Gm-Message-State: AOAM5324fZI1mfSYLItkMJtoUnaBG1Q6lAj2scktgASdvafxkuqUDPpw
 3NDrEnm7m80ksTHENYUYOhY=
X-Google-Smtp-Source: ABdhPJws2EAitFjCAK90MeAlQShY9EpE1lFDEHq8bARz5lAbxOKYOnsOXjR/1dc2reZJo8EcdPKYZg==
X-Received: by 2002:adf:f889:: with SMTP id u9mr86336337wrp.149.1594630634292; 
 Mon, 13 Jul 2020 01:57:14 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id m16sm24891490wro.0.2020.07.13.01.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 01:57:13 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/arm/palm.c: Encapsulate misc GPIO handling in a
 device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628214230.2592-1-peter.maydell@linaro.org>
 <20200628214230.2592-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4c049b0c-f305-729a-748d-0a7742b496ed@amsat.org>
Date: Mon, 13 Jul 2020 10:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628214230.2592-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 6/28/20 11:42 PM, Peter Maydell wrote:
> Replace the free-floating set of IRQs and palmte_onoff_gpios()
> function with a simple QOM device that encapsulates this
> behaviour.
> 
> This fixes Coverity issue CID 1421944, which points out that
> the memory returned by qemu_allocate_irqs() is leaked.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/palm.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> index 569836178f6..e7bc9ea4c6a 100644
> --- a/hw/arm/palm.c
> +++ b/hw/arm/palm.c
> @@ -124,6 +124,21 @@ static void palmte_button_event(void *opaque, int keycode)
>                          !(keycode & 0x80));
>  }
>  
> +/*
> + * Encapsulation of some GPIO line behaviour for the Palm board
> + *
> + * QEMU interface:
> + *  + unnamed GPIO inputs 0..6: for the various miscellaneous input lines
> + */
> +
> +#define TYPE_PALM_MISC_GPIO "palm-misc-gpio"
> +#define PALM_MISC_GPIO(obj) \
> +    OBJECT_CHECK(PalmMiscGPIOState, (obj), TYPE_PALM_MISC_GPIO)
> +
> +typedef struct PalmMiscGPIOState {
> +    SysBusDevice parent_obj;
> +} PalmMiscGPIOState;
> +
>  static void palmte_onoff_gpios(void *opaque, int line, int level)
>  {
>      switch (line) {
> @@ -151,23 +166,44 @@ static void palmte_onoff_gpios(void *opaque, int line, int level)
>      }
>  }
>  
> +static void palm_misc_gpio_init(Object *obj)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +
> +    qdev_init_gpio_in(dev, palmte_onoff_gpios, 7);
> +}
> +
> +static const TypeInfo palm_misc_gpio_info = {
> +    .name = TYPE_PALM_MISC_GPIO,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(PalmMiscGPIOState),
> +    .instance_init = palm_misc_gpio_init,
> +    /*
> +     * No class init required: device has no internal state so does not
> +     * need to set up reset or vmstate, and has no realize method.
> +     */
> +};
> +
>  static void palmte_gpio_setup(struct omap_mpu_state_s *cpu)
>  {
> -    qemu_irq *misc_gpio;
> +    DeviceState *misc_gpio;
> +
> +    misc_gpio = sysbus_create_simple(TYPE_PALM_MISC_GPIO, -1, NULL);

Why not make it a generic container in the MachineState and create
the container in hw/core/machine.c::machine_initfn()?

>  
>      omap_mmc_handlers(cpu->mmc,
>                      qdev_get_gpio_in(cpu->gpio, PALMTE_MMC_WP_GPIO),
>                      qemu_irq_invert(omap_mpuio_in_get(cpu->mpuio)
>                              [PALMTE_MMC_SWITCH_GPIO]));
>  
> -    misc_gpio = qemu_allocate_irqs(palmte_onoff_gpios, cpu, 7);
> -    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,     misc_gpio[0]);
> -    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,       misc_gpio[1]);
> -    qdev_connect_gpio_out(cpu->gpio, 11,                        misc_gpio[2]);
> -    qdev_connect_gpio_out(cpu->gpio, 12,                        misc_gpio[3]);
> -    qdev_connect_gpio_out(cpu->gpio, 13,                        misc_gpio[4]);
> -    omap_mpuio_out_set(cpu->mpuio, 1,                           misc_gpio[5]);
> -    omap_mpuio_out_set(cpu->mpuio, 3,                           misc_gpio[6]);
> +    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,
> +                          qdev_get_gpio_in(misc_gpio, 0));
> +    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,
> +                          qdev_get_gpio_in(misc_gpio, 1));
> +    qdev_connect_gpio_out(cpu->gpio, 11, qdev_get_gpio_in(misc_gpio, 2));
> +    qdev_connect_gpio_out(cpu->gpio, 12, qdev_get_gpio_in(misc_gpio, 3));
> +    qdev_connect_gpio_out(cpu->gpio, 13, qdev_get_gpio_in(misc_gpio, 4));
> +    omap_mpuio_out_set(cpu->mpuio, 1, qdev_get_gpio_in(misc_gpio, 5));
> +    omap_mpuio_out_set(cpu->mpuio, 3, qdev_get_gpio_in(misc_gpio, 6));
>  
>      /* Reset some inputs to initial state.  */
>      qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, PALMTE_USBDETECT_GPIO));
> @@ -276,3 +312,10 @@ static void palmte_machine_init(MachineClass *mc)
>  }
>  
>  DEFINE_MACHINE("cheetah", palmte_machine_init)
> +
> +static void palm_register_types(void)
> +{
> +    type_register_static(&palm_misc_gpio_info);
> +}
> +
> +type_init(palm_register_types)
> 


