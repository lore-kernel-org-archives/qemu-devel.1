Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B886AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDF52076B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvS9kSMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDF52076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59Pq-0001GI-LE
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k59Ow-00007C-3F; Mon, 10 Aug 2020 11:07:50 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k59Ou-0004YT-BW; Mon, 10 Aug 2020 11:07:49 -0400
Received: by mail-io1-xd44.google.com with SMTP id b16so777403ioj.4;
 Mon, 10 Aug 2020 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UORo0qD+fb6kK//n4IaoPZabo4hM1LaKVGqLFNiLsCM=;
 b=IvS9kSMrHNRAP3O6Cf08oi24rQcgES2x4xaPRzVT9OdvMm1eYNR2iNctsq1Q1T9WMa
 ZHq0MscPK8MAj4LCDVhQULsMwE2uUdXc2VvTOusJrWCeyCHOweg7hWHDbPlk+mqhRgr1
 3HwbCNT0d656Wf97+8Df3qRarlcBT49ROkDqtVLtGvdouPWZR+LgYqVhNJfrxoVHhSUf
 n2AY+oeOX6lLElyFTc2sDi12xRAeGYylt5Nil5mM/6Xrft/682ul8WW0wO8v/+PFHb6L
 YlD2NNSHY59mm4XcerBW5OQ0tJmXlFxV/ArUXvkL9ULbG876WJwSzxewLwV07FfxDTTR
 1IIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UORo0qD+fb6kK//n4IaoPZabo4hM1LaKVGqLFNiLsCM=;
 b=Y1CaVg6OQkL+3ScaxcxXHvOlrfov9b6FYWobh8ACWHYxP4RLRxDM5y+uhiFRAK4aHC
 x1BCbxRCBTDalRUnJQlQaYQc5NlPy4+NHdNVKuxy8/3LQQRO/rtU598NOyNujiRojmk+
 vnZRwqjqpkJmvNR8q6w4xxAvNc6Eeu07T78ggujETxsn8+Lp4e6jmDweTGulArAmlkne
 ytDBzy/4lO93r1S8bVcXTKoCrgfUif7szG/G2Z4yQzpf6w8bGWIf1d03BSELFvaIrOws
 MIp88c73EWXrhgkK96i38ua4oK5KHJ3fYeUXUp9yh6+o8Rc3upeWWOUoZNhqTtHE9Upc
 cHkQ==
X-Gm-Message-State: AOAM533PYmykAZJjkBDTxp+p3DzA0RwIWDpeiHSZ2AupghhKe/z+4Nn5
 J+AzId0Ta8Bdd/ZUIuGd1jb58oHK8W99xg+QGGI=
X-Google-Smtp-Source: ABdhPJxWVDJgkTz5YQ8UXbt+7h/YrujNlUbc2RsOHphs5xIbn1CWrcn4bmcQX+HPIGo8YlzD35NYZn7caiWcR0SfOjo=
X-Received: by 2002:a05:6638:e90:: with SMTP id
 p16mr20987154jas.26.1597072066586; 
 Mon, 10 Aug 2020 08:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200803105647.22223-1-f4bug@amsat.org>
 <20200803105647.22223-3-f4bug@amsat.org>
In-Reply-To: <20200803105647.22223-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Aug 2020 07:57:24 -0700
Message-ID: <CAKmqyKMUp03sZ0_Dt5hvpp14gWfza7BOSTtQ8JuHWHi7Mqo1dw@mail.gmail.com>
Subject: Re: [PATCH-for-5.1? 2/4] hw/arm/xilinx_zynq: Call
 qdev_connect_clock_in() before DeviceRealize
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
> Clock canonical name is set in device_set_realized (see the block
> added to hw/core/qdev.c in commit 0e6934f264).
> If we connect a clock after the device is realized, this code is
> not executed. This is currently not a problem as this name is only
> used for trace events, however this disrupt tracing.
>
> Fix by calling qdev_connect_clock_in() before realizing.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xilinx_zynq.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index cf6d9757b5..969ef0727c 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -222,18 +222,18 @@ static void zynq_init(MachineState *machine)
>                            1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2=
aa,
>                            0);
>
> -    /* Create slcr, keep a pointer to connect clocks */
> -    slcr =3D qdev_new("xilinx,zynq_slcr");
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
> -
>      /* Create the main clock source, and feed slcr with it */
>      zynq_machine->ps_clk =3D CLOCK(object_new(TYPE_CLOCK));
>      object_property_add_child(OBJECT(zynq_machine), "ps_clk",
>                                OBJECT(zynq_machine->ps_clk));
>      object_unref(OBJECT(zynq_machine->ps_clk));
>      clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
> +
> +    /* Create slcr, keep a pointer to connect clocks */
> +    slcr =3D qdev_new("xilinx,zynq_slcr");
>      qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
>
>      dev =3D qdev_new(TYPE_A9MPCORE_PRIV);
>      qdev_prop_set_uint32(dev, "num-cpu", 1);
> @@ -257,19 +257,19 @@ static void zynq_init(MachineState *machine)
>      dev =3D qdev_new(TYPE_CADENCE_UART);
>      busdev =3D SYS_BUS_DEVICE(dev);
>      qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    qdev_connect_clock_in(dev, "refclk",
> +                          qdev_get_clock_out(slcr, "uart0_ref_clk"));
>      sysbus_realize_and_unref(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, 0xE0000000);
>      sysbus_connect_irq(busdev, 0, pic[59 - IRQ_OFFSET]);
> -    qdev_connect_clock_in(dev, "refclk",
> -                          qdev_get_clock_out(slcr, "uart0_ref_clk"));
>      dev =3D qdev_new(TYPE_CADENCE_UART);
>      busdev =3D SYS_BUS_DEVICE(dev);
>      qdev_prop_set_chr(dev, "chardev", serial_hd(1));
> +    qdev_connect_clock_in(dev, "refclk",
> +                          qdev_get_clock_out(slcr, "uart1_ref_clk"));
>      sysbus_realize_and_unref(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, 0xE0001000);
>      sysbus_connect_irq(busdev, 0, pic[82 - IRQ_OFFSET]);
> -    qdev_connect_clock_in(dev, "refclk",
> -                          qdev_get_clock_out(slcr, "uart1_ref_clk"));
>
>      sysbus_create_varargs("cadence_ttc", 0xF8001000,
>              pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], =
NULL);
> --
> 2.21.3
>
>

