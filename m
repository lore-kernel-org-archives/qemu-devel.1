Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A16C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A274B20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BchfWjuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A274B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3NG-0002fn-SG
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr3Kd-00069r-WE; Thu, 02 Jul 2020 13:49:08 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:43939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr3Kb-0001Md-Tb; Thu, 02 Jul 2020 13:49:07 -0400
Received: by mail-il1-x143.google.com with SMTP id i18so24995645ilk.10;
 Thu, 02 Jul 2020 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kNMd4oet0VDFPxEzSrfmsRw93s33vgMbDXGptEoKZ3E=;
 b=BchfWjucRP4CKU6YxgVblRq9XTPL/sqY+ThCDE9nq2WCKoiri4EFbyJ/7LiSHYYLWq
 94I4NXdJ11fhtwNPP2Jy6Hw7H7e30jUAWjg3orm5DwAboWPfuMR6PZnhj/uYjz9IxMCH
 kOPEE3g5VPySEb263Vi5/MuQcFCB6o91XnCRdob7qYvGPszcxrLVWY25G8zzCklE71EN
 4vTjv+dfqkWoYpKYCBAxP6hXpap/lujuQYnFDCBFR03LZEEVXUhhnGtyOeXJYTH5+PVT
 DjrsyBKW/E5op8BuQnnPGCda+TPzHSc3a2Z57k7k8cxgUEl3rFjVoHwRyhxWUuvTzdK8
 Fwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kNMd4oet0VDFPxEzSrfmsRw93s33vgMbDXGptEoKZ3E=;
 b=tvBT7YDFZgbFzWCZhgBRYmZPIiVnil855XGZph43nQJ4+X0FXeT+tygSbGEpkbyT/G
 zw14ZO68Db7mLAGAcWlAnlcOJnwYjvdhJINlO54uzuIpFuJxXNsGEwYOdbzlTbaQFa9m
 23Ia254IopaCoJ2PmmY/wNFmRBx8Thhu0SWJMuSs3FKXq1lVpnWBJC8rtsKEAw/C6PAj
 RZ0BVzzRE8IjNLpCSeFdeaRi4FAZ5ypcaKG3PqwpqQ5PfEZrMhwH38VryyCwgeFAGdLy
 GufLgXQTkohatFF5zwWklSZ03cbVlgp+gqskErjhnU9QuSGnsOj2FHwz7QYkPfdf2woj
 84DA==
X-Gm-Message-State: AOAM530laYN7xcIXk3E7cabAJat+nxpwrOg8bScoK5QXJbcOsBkCL2gy
 nXkPsr2NVivNPY/ipSo1aINcGGzEYoXh92omG0M=
X-Google-Smtp-Source: ABdhPJyckI7gZ3N/RGf4koySFpUugM5EhLFyJfUtYtZ1nnUCC744aYn4CqIhk7iSNxKwipHewZAQfH6kejwANa61K08=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr14045195ilj.131.1593712143967; 
 Thu, 02 Jul 2020 10:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-13-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-13-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jul 2020 10:39:17 -0700
Message-ID: <CAKmqyKPHB4Sbx1pjbp7UFHcNgwwFjBy299Otx=6UL2ZUHx5m-g@mail.gmail.com>
Subject: Re: [PATCH 12/17] hw/arm/spitz: Encapsulate misc GPIO handling in a
 device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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

On Sun, Jun 28, 2020 at 7:33 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently we have a free-floating set of IRQs and a function
> spitz_out_switch() which handle some miscellaneous GPIO lines for the
> spitz board.  Encapsulate this behaviour in a simple QOM device.
>
> At this point we can finally remove the 'max1111' global, because the
> ADC battery-temperature value is now handled by the misc-gpio device
> writing the value to its outbound "adc-temp" GPIO, which the board
> code wires up to the appropriate inbound GPIO line on the max1111.
>
> This commit also fixes Coverity issue CID 1421913 (which pointed out
> that the 'outsignals' in spitz_scoop_gpio_setup() were leaked),
> because it removes the use of the qemu_allocate_irqs() API from this
> code entirely.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/spitz.c | 129 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 87 insertions(+), 42 deletions(-)
>
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 1400a56729d..bab9968ccee 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -51,6 +51,7 @@ typedef struct {
>      DeviceState *max1111;
>      DeviceState *scp0;
>      DeviceState *scp1;
> +    DeviceState *misc_gpio;
>  } SpitzMachineState;
>
>  #define TYPE_SPITZ_MACHINE "spitz-common"
> @@ -658,8 +659,6 @@ static void spitz_lcdtg_realize(SSISlave *ssi, Error **errp)
>  #define SPITZ_GPIO_MAX1111_CS   20
>  #define SPITZ_GPIO_TP_INT       11
>
> -static DeviceState *max1111;
> -
>  /* "Demux" the signal based on current chipselect */
>  typedef struct {
>      SSISlave ssidev;
> @@ -695,18 +694,6 @@ static void corgi_ssp_gpio_cs(void *opaque, int line, int level)
>  #define SPITZ_BATTERY_VOLT      0xd0    /* About 4.0V */
>  #define SPITZ_CHARGEON_ACIN     0x80    /* About 5.0V */
>
> -static void spitz_adc_temp_on(void *opaque, int line, int level)
> -{
> -    int batt_temp;
> -
> -    if (!max1111)
> -        return;
> -
> -    batt_temp = level ? SPITZ_BATTERY_TEMP : 0;
> -
> -    qemu_set_irq(qdev_get_gpio_in(max1111, MAX1111_BATT_TEMP), batt_temp);
> -}
> -
>  static void corgi_ssp_realize(SSISlave *d, Error **errp)
>  {
>      DeviceState *dev = DEVICE(d);
> @@ -734,7 +721,6 @@ static void spitz_ssp_attach(SpitzMachineState *sms)
>
>      bus = qdev_get_child_bus(sms->mux, "ssi2");
>      sms->max1111 = qdev_new(TYPE_MAX_1111);
> -    max1111 = sms->max1111;
>      qdev_prop_set_uint8(sms->max1111, "input1" /* BATT_VOLT */,
>                          SPITZ_BATTERY_VOLT);
>      qdev_prop_set_uint8(sms->max1111, "input2" /* BATT_TEMP */, 0);
> @@ -810,27 +796,66 @@ static void spitz_akita_i2c_setup(PXA2xxState *cpu)
>
>  /* Other peripherals */
>
> -static void spitz_out_switch(void *opaque, int line, int level)
> +/*
> + * Encapsulation of some miscellaneous GPIO line behaviour for the Spitz boards.
> + *
> + * QEMU interface:
> + *  + named GPIO inputs "green-led", "orange-led", "charging", "discharging":
> + *    these currently just print messages that the line has been signalled
> + *  + named GPIO input "adc-temp-on": set to cause the battery-temperature
> + *    value to be passed to the max111x ADC
> + *  + named GPIO output "adc-temp": the ADC value, to be wired up to the max111x
> + */
> +#define TYPE_SPITZ_MISC_GPIO "spitz-misc-gpio"
> +#define SPITZ_MISC_GPIO(obj) \
> +    OBJECT_CHECK(SpitzMiscGPIOState, (obj), TYPE_SPITZ_MISC_GPIO)
> +
> +typedef struct SpitzMiscGPIOState {
> +    SysBusDevice parent_obj;
> +
> +    qemu_irq adc_value;
> +} SpitzMiscGPIOState;
> +
> +static void spitz_misc_charging(void *opaque, int n, int level)
>  {
> -    switch (line) {
> -    case 0:
> -        zaurus_printf("Charging %s.\n", level ? "off" : "on");
> -        break;
> -    case 1:
> -        zaurus_printf("Discharging %s.\n", level ? "on" : "off");
> -        break;
> -    case 2:
> -        zaurus_printf("Green LED %s.\n", level ? "on" : "off");
> -        break;
> -    case 3:
> -        zaurus_printf("Orange LED %s.\n", level ? "on" : "off");
> -        break;
> -    case 6:
> -        spitz_adc_temp_on(opaque, line, level);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> +    zaurus_printf("Charging %s.\n", level ? "off" : "on");
> +}
> +
> +static void spitz_misc_discharging(void *opaque, int n, int level)
> +{
> +    zaurus_printf("Discharging %s.\n", level ? "off" : "on");
> +}
> +
> +static void spitz_misc_green_led(void *opaque, int n, int level)
> +{
> +    zaurus_printf("Green LED %s.\n", level ? "off" : "on");
> +}
> +
> +static void spitz_misc_orange_led(void *opaque, int n, int level)
> +{
> +    zaurus_printf("Orange LED %s.\n", level ? "off" : "on");
> +}
> +
> +static void spitz_misc_adc_temp(void *opaque, int n, int level)
> +{
> +    SpitzMiscGPIOState *s = SPITZ_MISC_GPIO(opaque);
> +    int batt_temp = level ? SPITZ_BATTERY_TEMP : 0;
> +
> +    qemu_set_irq(s->adc_value, batt_temp);
> +}
> +
> +static void spitz_misc_gpio_init(Object *obj)
> +{
> +    SpitzMiscGPIOState *s = SPITZ_MISC_GPIO(obj);
> +    DeviceState *dev = DEVICE(obj);
> +
> +    qdev_init_gpio_in_named(dev, spitz_misc_charging, "charging", 1);
> +    qdev_init_gpio_in_named(dev, spitz_misc_discharging, "discharging", 1);
> +    qdev_init_gpio_in_named(dev, spitz_misc_green_led, "green-led", 1);
> +    qdev_init_gpio_in_named(dev, spitz_misc_orange_led, "orange-led", 1);
> +    qdev_init_gpio_in_named(dev, spitz_misc_adc_temp, "adc-temp-on", 1);
> +
> +    qdev_init_gpio_out_named(dev, &s->adc_value, "adc-temp", 1);
>  }
>
>  #define SPITZ_SCP_LED_GREEN             1
> @@ -850,12 +875,22 @@ static void spitz_out_switch(void *opaque, int line, int level)
>
>  static void spitz_scoop_gpio_setup(SpitzMachineState *sms)
>  {
> -    qemu_irq *outsignals = qemu_allocate_irqs(spitz_out_switch, sms->mpu, 8);
> +    DeviceState *miscdev = sysbus_create_simple(TYPE_SPITZ_MISC_GPIO, -1, NULL);
>
> -    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_CHRG_ON, outsignals[0]);
> -    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_JK_B, outsignals[1]);
> -    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_GREEN, outsignals[2]);
> -    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_ORANGE, outsignals[3]);
> +    sms->misc_gpio = miscdev;
> +
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_CHRG_ON,
> +                          qdev_get_gpio_in_named(miscdev, "charging", 0));
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_JK_B,
> +                          qdev_get_gpio_in_named(miscdev, "discharging", 0));
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_GREEN,
> +                          qdev_get_gpio_in_named(miscdev, "green-led", 0));
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_ORANGE,
> +                          qdev_get_gpio_in_named(miscdev, "orange-led", 0));
> +    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_ADC_TEMP_ON,
> +                          qdev_get_gpio_in_named(miscdev, "adc-temp-on", 0));
> +    qdev_connect_gpio_out_named(miscdev, "adc-temp", 0,
> +                                qdev_get_gpio_in(sms->max1111, MAX1111_BATT_TEMP));
>
>      if (sms->scp1) {
>          qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_CONT,
> @@ -863,8 +898,6 @@ static void spitz_scoop_gpio_setup(SpitzMachineState *sms)
>          qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_ON,
>                                qdev_get_gpio_in_named(sms->lcdtg, "bl_power", 0));
>      }
> -
> -    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
>  }
>
>  #define SPITZ_GPIO_HSYNC                22
> @@ -1217,12 +1250,24 @@ static const TypeInfo spitz_lcdtg_info = {
>      .class_init    = spitz_lcdtg_class_init,
>  };
>
> +static const TypeInfo spitz_misc_gpio_info = {
> +    .name = TYPE_SPITZ_MISC_GPIO,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SpitzMiscGPIOState),
> +    .instance_init = spitz_misc_gpio_init,
> +    /*
> +     * No class_init required: device has no internal state so does not
> +     * need to set up reset or vmstate, and does not have a realize method.
> +     */
> +};
> +
>  static void spitz_register_types(void)
>  {
>      type_register_static(&corgi_ssp_info);
>      type_register_static(&spitz_lcdtg_info);
>      type_register_static(&spitz_keyboard_info);
>      type_register_static(&sl_nand_info);
> +    type_register_static(&spitz_misc_gpio_info);
>  }
>
>  type_init(spitz_register_types)
> --
> 2.20.1
>
>

