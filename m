Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F39C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625EA20774
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAKK/05j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625EA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59NX-0006yA-Kd
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k59Mm-0006Cz-4Y; Mon, 10 Aug 2020 11:05:36 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k59Mk-0004Im-Go; Mon, 10 Aug 2020 11:05:35 -0400
Received: by mail-io1-xd43.google.com with SMTP id s189so9229554iod.2;
 Mon, 10 Aug 2020 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lDUPLzsyvA/XwAAz+lyK9n7p7QxGmV13wB9lMp3EUFY=;
 b=qAKK/05jrG08GyQDb3DmbajYi6RCQPRCKDkKw940goJNLMvaoJ8w9p4J6RMpmDrJmg
 3MnNwIvD/nziwhYDBpO5HqgsphKr0no7grlhNZ3YIq0Jj8a4BWp2E8X/QtFKjDjh7iuH
 Csxbc8I1XkyQGB3Lht5xEMs+/4EGlLZqE5T9gTp6xeQIwlFj4OlBbaCo8LktJnUG4IK+
 B/EI0icqjP3/aPdtTt5oL61wNYjzBKePiW+QC5CgEgzSUchk7bZeHO0lysuPBeFHaPJq
 6XKLS/UsrzC5zpd6Yn6hQaMyTYA0cYX17YTFMfX4uwj0bhE5FYx3rFu+jjhy3qlCPBAX
 00rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lDUPLzsyvA/XwAAz+lyK9n7p7QxGmV13wB9lMp3EUFY=;
 b=gjRQPjmlvUz0jD3ibSQveXhOh+B1lHU1o+6Yn5gxDm+Bxn4cpREykXLd94VM3sgXQ6
 Uea/+PZ2qRDECy/sQ6sOgeAScdyRRMniDyB3gD4gsaWBsDNBKo8827kA8pSTPnVVjU9N
 1LrpExr/1/n60A2ZuOwffM/OlW0gBsXHPu0hjxOsVtJfOBsxWsXvmxvUcFGWeuJJD5D7
 rbmemcsKzjdQPXYRdDUyKxuvV2pzsAa8z5sC+DNYvmONd2fnDblguWpiiDHBtiPhb+qG
 BclYcpxQQ82wAA1t06NWRLSSZNS3BT0kMnLrrtmwXyEvQ+Lwc6JyTwH+FDdits4OBSW4
 XzLg==
X-Gm-Message-State: AOAM530qEQ2DK8hJ7vKpbADH/s/SwuQil1C7XeVHaWRxNzPGz6Rmw2Vk
 7JMfZgCzNVIt7f6Cd/Xi2QDFKt3vnazuUUg4rfs=
X-Google-Smtp-Source: ABdhPJy3SPbV/8RwheCIB1E04mW54Io/JZK1qYQCgp5DaAyFQXSM+Q+au6I9ybi5Q4lQleRnUIw8jbgeTe6SwMUMFfc=
X-Received: by 2002:a05:6638:248e:: with SMTP id
 x14mr20200786jat.135.1597071932164; 
 Mon, 10 Aug 2020 08:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200803105647.22223-1-f4bug@amsat.org>
 <20200803105647.22223-2-f4bug@amsat.org>
In-Reply-To: <20200803105647.22223-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Aug 2020 07:55:10 -0700
Message-ID: <CAKmqyKM228r87A9+fS=KZBNun-i-knK6DAxQH+y2drD1wtrY1w@mail.gmail.com>
Subject: Re: [PATCH-for-5.1? 1/4] hw/arm/xilinx_zynq: Uninline
 cadence_uart_create()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 3, 2020 at 3:57 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> As we want to call qdev_connect_clock_in() before the device
> is realized, we need to uninline cadence_uart_create() first.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/char/cadence_uart.h | 17 -----------------
>  hw/arm/xilinx_zynq.c           | 14 ++++++++++++--
>  2 files changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
> index ed7b58d31d..dabc49ea4f 100644
> --- a/include/hw/char/cadence_uart.h
> +++ b/include/hw/char/cadence_uart.h
> @@ -53,21 +53,4 @@ typedef struct {
>      Clock *refclk;
>  } CadenceUARTState;
>
> -static inline DeviceState *cadence_uart_create(hwaddr addr,
> -                                        qemu_irq irq,
> -                                        Chardev *chr)
> -{
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -
> -    dev =3D qdev_new(TYPE_CADENCE_UART);
> -    s =3D SYS_BUS_DEVICE(dev);
> -    qdev_prop_set_chr(dev, "chardev", chr);
> -    sysbus_realize_and_unref(s, &error_fatal);
> -    sysbus_mmio_map(s, 0, addr);
> -    sysbus_connect_irq(s, 0, irq);
> -
> -    return dev;
> -}
> -
>  #endif
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 32aa7323d9..cf6d9757b5 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -254,10 +254,20 @@ static void zynq_init(MachineState *machine)
>      sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - IRQ_OFFSET]=
);
>      sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - IRQ_OFFSET]=
);
>
> -    dev =3D cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial=
_hd(0));
> +    dev =3D qdev_new(TYPE_CADENCE_UART);
> +    busdev =3D SYS_BUS_DEVICE(dev);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    sysbus_realize_and_unref(busdev, &error_fatal);
> +    sysbus_mmio_map(busdev, 0, 0xE0000000);
> +    sysbus_connect_irq(busdev, 0, pic[59 - IRQ_OFFSET]);
>      qdev_connect_clock_in(dev, "refclk",
>                            qdev_get_clock_out(slcr, "uart0_ref_clk"));
> -    dev =3D cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial=
_hd(1));
> +    dev =3D qdev_new(TYPE_CADENCE_UART);
> +    busdev =3D SYS_BUS_DEVICE(dev);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(1));
> +    sysbus_realize_and_unref(busdev, &error_fatal);
> +    sysbus_mmio_map(busdev, 0, 0xE0001000);
> +    sysbus_connect_irq(busdev, 0, pic[82 - IRQ_OFFSET]);
>      qdev_connect_clock_in(dev, "refclk",
>                            qdev_get_clock_out(slcr, "uart1_ref_clk"));
>
> --
> 2.21.3
>
>

