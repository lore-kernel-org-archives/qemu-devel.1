Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70005C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E53820760
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K49Jf/Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E53820760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzkf-0004rJ-D2
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jpzjq-0004GR-9p; Mon, 29 Jun 2020 15:46:46 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:39002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jpzjo-0005NM-BK; Mon, 29 Jun 2020 15:46:45 -0400
Received: by mail-il1-x142.google.com with SMTP id k6so15543734ili.6;
 Mon, 29 Jun 2020 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JflIh2KC82RAfGb+J90gvtsop7+kSncUYkSw2aEPVOM=;
 b=K49Jf/XoaUyuhoC9RJt9JAJWFPoprPZjh7lMqW0ZebeTiVNRiXFsXI83pwIlVBNvIL
 2uuMCTCiO+yVxJPoEqmPJoq17zFljsNsMfoU+xgTWuT7R3ySfkOd7OALtsm3RFmoZoEs
 WpNsmIFbU6vMCVQ1MTIfrRZsJsQKmOSzw0M49sce3Nh92o/3aRW34axIbYtVbvG0AI13
 TMFPUD2+arHDoThD1LgCl/YL8hUoYinDs8Cdo8z8HrlmQ7V1j6DLJmyNevhjEvbYH+l1
 UI+J8JHqn6jISNoq7PDGnAP8E7pM8IECYnIoxX9Je/sfs1rmXMuDqkVovwGNAd6V29Ex
 7b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JflIh2KC82RAfGb+J90gvtsop7+kSncUYkSw2aEPVOM=;
 b=lPP/DaWC9vlzhMaF/AvoOy/R0NqHhQTK7+3rVOszDHJQXNolrhQ/JOjOD2xl/KtjT7
 sNYx/Uf6a0YONPuTqjCFL4aJgYhRNMfe1r4juuP9zaJxiPLK/rhCKWdPZk/0jDpvRByf
 4uKi2nAx3M1KQv59/Dbyy5H/CM56g/F3FnDBah6LSZJuQN1kf/4gYhdiJApZBqvpUj7B
 LN7AvY3rM1TogReWY3J6pOKBgsf+BB2yK/2SaAR88RdbQkq7V41wDplAEGNQjjTRnvYX
 JQcD0A+fkLxoaavvL2kP61lm+Ctbe+l9v8vf1vj4JKeAsx9YKo/et2W40mP9Q4VSU0Nw
 +VOA==
X-Gm-Message-State: AOAM531x2mP/4SQEgNVjF1GYnCLyOjiMUzdhJ4JLxGdKHd+uP8Eg4bQ1
 ZG4NkX7iOMBAlsv8rBlC4vfznKJ8B8pZzF2i8+g=
X-Google-Smtp-Source: ABdhPJwv26YJfFb13R7uj+9T5pgejdyLE62y2hX95/RgybpFRsdaqJbeGoRBEPo5FibGjr8I2DnTkiR9GIfiLjNNYW4=
X-Received: by 2002:a92:d186:: with SMTP id z6mr18518815ilz.227.1593460002831; 
 Mon, 29 Jun 2020 12:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-4-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-4-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2020 12:36:59 -0700
Message-ID: <CAKmqyKPDvjXoS_mrBv3MUwtVPbzHA7sHu2+W2D7Ak8Fh0Bzpdg@mail.gmail.com>
Subject: Re: [PATCH 03/17] hw/arm/spitz: Keep pointers to MPU and SSI devices
 in SpitzMachineState
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

On Sun, Jun 28, 2020 at 7:24 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Keep pointers to the MPU and the SSI devices in SpitzMachineState.
> We're going to want to make GPIO connections between some of the
> SSI devices and the SCPs, so we want to keep hold of a pointer to
> those; putting the MPU into the struct allows us to pass just
> one thing to spitz_ssp_attach() rather than two.
>
> We have to retain the setting of the global "max1111" variable
> for the moment as it is used in spitz_adc_temp_on(); later in
> this series of commits we will be able to remove it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/spitz.c | 50 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index c70e912a33d..f48e966c047 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -43,6 +43,11 @@ typedef struct {
>
>  typedef struct {
>      MachineState parent;
> +    PXA2xxState *mpu;
> +    DeviceState *mux;
> +    DeviceState *lcdtg;
> +    DeviceState *ads7846;
> +    DeviceState *max1111;
>  } SpitzMachineState;
>
>  #define TYPE_SPITZ_MACHINE "spitz-common"
> @@ -709,34 +714,33 @@ static void corgi_ssp_realize(SSISlave *d, Error **errp)
>      s->bus[2] = ssi_create_bus(dev, "ssi2");
>  }
>
> -static void spitz_ssp_attach(PXA2xxState *cpu)
> +static void spitz_ssp_attach(SpitzMachineState *sms)
>  {
> -    DeviceState *mux;
> -    DeviceState *dev;
>      void *bus;
>
> -    mux = ssi_create_slave(cpu->ssp[CORGI_SSP_PORT - 1], "corgi-ssp");
> +    sms->mux = ssi_create_slave(sms->mpu->ssp[CORGI_SSP_PORT - 1], "corgi-ssp");
>
> -    bus = qdev_get_child_bus(mux, "ssi0");
> -    ssi_create_slave(bus, "spitz-lcdtg");
> +    bus = qdev_get_child_bus(sms->mux, "ssi0");
> +    sms->lcdtg = ssi_create_slave(bus, "spitz-lcdtg");
>
> -    bus = qdev_get_child_bus(mux, "ssi1");
> -    dev = ssi_create_slave(bus, "ads7846");
> -    qdev_connect_gpio_out(dev, 0,
> -                          qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_TP_INT));
> +    bus = qdev_get_child_bus(sms->mux, "ssi1");
> +    sms->ads7846 = ssi_create_slave(bus, "ads7846");
> +    qdev_connect_gpio_out(sms->ads7846, 0,
> +                          qdev_get_gpio_in(sms->mpu->gpio, SPITZ_GPIO_TP_INT));
>
> -    bus = qdev_get_child_bus(mux, "ssi2");
> -    max1111 = ssi_create_slave(bus, "max1111");
> -    max111x_set_input(max1111, MAX1111_BATT_VOLT, SPITZ_BATTERY_VOLT);
> -    max111x_set_input(max1111, MAX1111_BATT_TEMP, 0);
> -    max111x_set_input(max1111, MAX1111_ACIN_VOLT, SPITZ_CHARGEON_ACIN);
> +    bus = qdev_get_child_bus(sms->mux, "ssi2");
> +    sms->max1111 = ssi_create_slave(bus, "max1111");
> +    max1111 = sms->max1111;
> +    max111x_set_input(sms->max1111, MAX1111_BATT_VOLT, SPITZ_BATTERY_VOLT);
> +    max111x_set_input(sms->max1111, MAX1111_BATT_TEMP, 0);
> +    max111x_set_input(sms->max1111, MAX1111_ACIN_VOLT, SPITZ_CHARGEON_ACIN);
>
> -    qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_LCDCON_CS,
> -                        qdev_get_gpio_in(mux, 0));
> -    qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_ADS7846_CS,
> -                        qdev_get_gpio_in(mux, 1));
> -    qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_MAX1111_CS,
> -                        qdev_get_gpio_in(mux, 2));
> +    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_LCDCON_CS,
> +                        qdev_get_gpio_in(sms->mux, 0));
> +    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_ADS7846_CS,
> +                        qdev_get_gpio_in(sms->mux, 1));
> +    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_MAX1111_CS,
> +                        qdev_get_gpio_in(sms->mux, 2));
>  }
>
>  /* CF Microdrive */
> @@ -936,6 +940,7 @@ static struct arm_boot_info spitz_binfo = {
>  static void spitz_common_init(MachineState *machine)
>  {
>      SpitzMachineClass *smc = SPITZ_MACHINE_GET_CLASS(machine);
> +    SpitzMachineState *sms = SPITZ_MACHINE(machine);
>      enum spitz_model_e model = smc->model;
>      PXA2xxState *mpu;
>      DeviceState *scp0, *scp1 = NULL;
> @@ -945,6 +950,7 @@ static void spitz_common_init(MachineState *machine)
>      /* Setup CPU & memory */
>      mpu = pxa270_init(address_space_mem, spitz_binfo.ram_size,
>                        machine->cpu_type);
> +    sms->mpu = mpu;
>
>      sl_flash_register(mpu, (model == spitz) ? FLASH_128M : FLASH_1024M);
>
> @@ -954,7 +960,7 @@ static void spitz_common_init(MachineState *machine)
>      /* Setup peripherals */
>      spitz_keyboard_register(mpu);
>
> -    spitz_ssp_attach(mpu);
> +    spitz_ssp_attach(sms);
>
>      scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
>      if (model != akita) {
> --
> 2.20.1
>
>

